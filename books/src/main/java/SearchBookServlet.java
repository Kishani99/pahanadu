import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SearchBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String search = request.getParameter("search");
        StringBuilder resultHtml = new StringBuilder();

        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/yourdbname", "root", "yourpassword"
            );

            // Search by Book ID or Book Name
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM books WHERE book_id = ? OR book_name LIKE ?"
            );
            ps.setString(1, search);
            ps.setString(2, "%" + search + "%");

            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
                resultHtml.append("<p>No matching book found.</p>");
            } else {
                resultHtml.append("<table>");
                resultHtml.append("<tr><th>Book ID</th><th>Name</th><th>Author</th><th>Price</th><th>Quantity</th></tr>");

                while (rs.next()) {
                    resultHtml.append("<tr>");
                    resultHtml.append("<td>").append(rs.getString("book_id")).append("</td>");
                    resultHtml.append("<td>").append(rs.getString("book_name")).append("</td>");
                    resultHtml.append("<td>").append(rs.getString("author")).append("</td>");
                    resultHtml.append("<td>").append(rs.getDouble("price")).append("</td>");
                    resultHtml.append("<td>").append(rs.getInt("quantity")).append("</td>");
                    resultHtml.append("</tr>");
                }

                resultHtml.append("</table>");
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            resultHtml.append("<p>Error: ").append(e.getMessage()).append("</p>");
            e.printStackTrace();
        }

        // Set the result to be displayed in the JSP
        request.setAttribute("result", resultHtml.toString());
        RequestDispatcher rd = request.getRequestDispatcher("search_book.jsp");  // your JSP file name
        rd.forward(request, response);
    }
}

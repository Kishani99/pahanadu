import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Cashier_ManageBooksServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String redirectURL = "add_books.jsp";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");
            PreparedStatement stmt;

            if ("add".equals(action)) {
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                stmt = conn.prepareStatement("INSERT INTO book(title, author, price, quantity) VALUES (?, ?, ?, ?)");
                stmt.setString(1, title);
                stmt.setString(2, author);
                stmt.setDouble(3, price);
                stmt.setInt(4, quantity);

                int rows = stmt.executeUpdate();
                redirectURL += "?message=" + (rows > 0 ? "addsuccess" : "error");
            } else if ("delete".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("book_id"));

                stmt = conn.prepareStatement("DELETE FROM book WHERE book_id = ?");
                stmt.setInt(1, bookId);

                int rows = stmt.executeUpdate();
                redirectURL += "?message=" + (rows > 0 ? "deletesuccess" : "error");
            }

            conn.close();
        } catch (Exception e) {
            redirectURL += "?message=error";
        }

        response.sendRedirect(redirectURL);
    }
}

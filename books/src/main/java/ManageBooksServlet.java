

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class ManageBooksServlet
 */
@WebServlet("/ManageBooksServlet")
public class ManageBooksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private static final String DB_URL = "jdbc:mysql://localhost:3306/pahanaedu";
	    private static final String DB_USER = "root";
	    private static final String DB_PASSWORD = "";  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageBooksServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            if ("add".equalsIgnoreCase(action)) {
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                String sql = "INSERT INTO book (title, author, price, quantity) VALUES (?, ?, ?, ?)";
                String sql1 = "INSERT INTO deletebook (title,) VALUES (?, )";
                PreparedStatement ps1 = conn.prepareStatement(sql1);
                ps1.setString(1, title);
                PreparedStatement ps = conn.prepareStatement(sql1);
                ps.setString(1, title);
                ps.setString(2, author);
                ps.setDouble(3, price);
                ps.setInt(4, quantity);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("manage_books.jsp?message=addsuccess");
                } else {
                    response.sendRedirect("manage_books.jsp?message=error");
                }

            } else if ("delete".equalsIgnoreCase(action)) {
                String booktitle = request.getParameter("title");

                String sql = "DELETE FROM book WHERE title = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, booktitle);


                int rows = ps.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect("manage_books.jsp?message=deletesuccess");
                } else {
                    response.sendRedirect("manage_books.jsp?message=error");
                }

            } else {
                response.sendRedirect("manage_books.jsp?message=error");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_books.jsp?message=error");
        }
    }
}

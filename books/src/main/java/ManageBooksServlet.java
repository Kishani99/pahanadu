

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ManageBooksServlet")
public class ManageBooksServlet extends HttpServlet {

    private final String jdbcURL = "jdbc:mysql://localhost:3306/pahanaedu";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            if ("add".equals(action)) {
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String category = request.getParameter("category");
                String priceStr = request.getParameter("price");
                String quantityStr = request.getParameter("quantity");

                if (title == null || priceStr == null || title.trim().isEmpty() || priceStr.trim().isEmpty()) {
                    request.setAttribute("message", "Title and Price are required.");
                } else {
                    double price = Double.parseDouble(priceStr);
                    int quantity = quantityStr == null || quantityStr.trim().isEmpty() ? 0 : Integer.parseInt(quantityStr);

                    String sql = "INSERT INTO books (title, author, price, category, quantity) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setString(1, title);
                        stmt.setString(2, author);
                        stmt.setDouble(3, price);
                        stmt.setString(4, category);
                        stmt.setInt(5, quantity);
                        stmt.executeUpdate();
                        request.setAttribute("message", "Book added successfully!");
                    }
                }
            } else if ("delete".equals(action)) {
                String bookIdStr = request.getParameter("book_id");
                if (bookIdStr != null) {
                    int bookId = Integer.parseInt(bookIdStr);
                    String sql = "DELETE FROM books WHERE book_id = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setInt(1, bookId);
                        int rows = stmt.executeUpdate();
                        if (rows > 0) {
                            request.setAttribute("message", "Book deleted successfully!");
                        } else {
                            request.setAttribute("message", "Book not found.");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
        }

        request.getRequestDispatcher("manage_books.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to POST for simplicity or show books list
        doPost(request, response);
    }
}

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminCustomerServlet")
public class AdminCustomerServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            if ("add".equals(action)) {
                String sql = "INSERT INTO customers (account_number, name, address, telephone, username, password) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("account_number"));
                ps.setString(2, request.getParameter("name"));
                ps.setString(3, request.getParameter("address"));
                ps.setString(4, request.getParameter("telephone"));
                ps.setString(5, request.getParameter("username"));
                ps.setString(6, request.getParameter("password"));
                int rows = ps.executeUpdate();
                System.out.println("Rows inserted: " + rows);
                if (rows > 0) {
                    response.sendRedirect("register_customer.jsp?msg=Customer+added+successfully&type=success");
                } else {
                    response.sendRedirect("register_customer.jsp?msg=Failed+to+add+customer&type=error");
                }
            }
            else if ("delete".equals(action)) {
                String sql = "DELETE FROM customers WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(request.getParameter("id")));

                int rows = ps.executeUpdate();
                System.out.println("Rows deleted: " + rows);
                if (rows > 0) {
                    response.sendRedirect("register_customer.jsp?msg=Customer+deleted+successfully&type=success");
                } else {
                    response.sendRedirect("register_customer.jsp?msg=No+customer+found&type=error");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register_customer.jsp?msg=Database+error:+"
                + e.getMessage().replace(" ", "+") + "&type=error");
        }
    }
}

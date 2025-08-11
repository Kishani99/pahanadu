import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "INSERT INTO customers (account_number, name, address, telephone, username, password, role) VALUES (?, ?, ?, ?, ?, ?, 'customer')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, accountNumber);
            ps.setString(2, name);
            ps.setString(3, address);
            ps.setString(4, telephone);
            ps.setString(5, username);
            ps.setString(6, password);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                // Auto-login after registration
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", "customer");

                response.sendRedirect("customerDashboard.jsp");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed");
            }
            conn.close();
        } catch (SQLIntegrityConstraintViolationException e) {
            response.sendRedirect("register.jsp?error=Username or Account Number already exists");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error");
        }
    }
}



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;
@WebServlet("/AdminRegisterCustomerServlet")
public class AdminRegisterCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String password = request.getParameter("password");

        String message = null, messageType = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pahanaedu", "root", "");

            String sql = "INSERT INTO customers (accountNumber, name, address, telephone, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accountNumber);
            stmt.setString(2, name);
            stmt.setString(3, address);
            stmt.setString(4, telephone);
            stmt.setString(5, password);

            int result = stmt.executeUpdate();
            conn.close();

            if (result > 0) {
                message = "Customer registered successfully!";
                messageType = "success";
            } else {
                message = "Registration failed.";
                messageType = "error";
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            message = "Account number already exists!";
            messageType = "error";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            messageType = "error";
        }

        request.setAttribute("message", message);
        request.setAttribute("messageType", messageType);
        request.getRequestDispatcher("register_customer.jsp").forward(request, response);
    }
}

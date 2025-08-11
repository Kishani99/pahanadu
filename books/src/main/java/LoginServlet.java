import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pahanaedu";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            String sql = "SELECT role FROM users WHERE username=? AND password=? "
                    + "UNION SELECT role FROM customers WHERE username=? AND password=?";
         PreparedStatement ps = conn.prepareStatement(sql);
         ps.setString(1, username);
         ps.setString(2, password);
         ps.setString(3, username);
         ps.setString(4, password);


            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                switch (role) {
                    case "admin":
                        response.sendRedirect("admin_dashboard.jsp");
                        break;
                    case "cashier":
                        response.sendRedirect("cashierDashboard.jsp");
                        break;
                    case "customer":
                        response.sendRedirect("customerDashboard.jsp");
                        break;
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid username or password");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database connection error");
        }
    }
}

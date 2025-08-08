

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class SearchCustomerServlet
 */
@WebServlet("/SearchCustomerServlet")
public class SearchCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ServletRequest request;
	
	String search = request.getParameter("search");
    StringBuilder result = new StringBuilder();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchCustomerServlet() {
        super();
        
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/pahanaedu", "root", ""
        );

        String sql = "SELECT * FROM customers WHERE accountNumber LIKE ? OR name LIKE ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, "%" + search + "%");
        ps.setString(2, "%" + search + "%");

        ResultSet rs = ps.executeQuery();

        result.append("<table>");
        result.append("<tr><th>ID</th><th>Account Number</th><th>Name</th><th>Address</th><th>Telephone</th></tr>");

        boolean found = false;
        while (rs.next()) {
            found = true;
            result.append("<tr>")
                    .append("<td>").append(rs.getInt("id")).append("</td>")
                    .append("<td>").append(rs.getString("accountNumber")).append("</td>")
                    .append("<td>").append(rs.getString("name")).append("</td>")
                    .append("<td>").append(rs.getString("address")).append("</td>")
                    .append("<td>").append(rs.getString("telephone")).append("</td>")
                    .append("</tr>");
        }

        if (!found) {
            result = new StringBuilder("<p style='color:red; text-align:center;'>No matching customers found.</p>");
        } else {
            result.append("</table>");
        }

        conn.close();
    } catch (Exception e) {
        result = new StringBuilder("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
    }

    request.setAttribute("result", result.toString());
    RequestDispatcher rd = request.getRequestDispatcher("search_customer.jsp");
    rd.forward(request, response);
}
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

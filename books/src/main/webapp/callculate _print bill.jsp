<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Bill - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            padding: 30px;
        }

        .bill-box {
            background: #fff;
            padding: 30px;
            max-width: 900px;
            margin: 0 auto;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        form {
            text-align: center;
            margin-bottom: 20px;
        }

        input {
            margin: 10px;
            padding: 10px;
            font-size: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
            width: 250px;
        }

        button {
            background: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            margin: 10px;
        }

        button:hover {
            background: #2980b9;
        }

        table {
            width: 100%;
            margin-top: 25px;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px;
            border-bottom: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #2c3e50;
            color: white;
        }

        .total-row {
            font-weight: bold;
            background: #f0f0f0;
        }

        .print-btn {
            margin: 20px auto;
            background-color: #27ae60;
        }

        .export-btn {
            background-color: #e67e22;
        }

        .info-bar {
            display: flex;
            justify-content: space-between;
            font-weight: bold;
            margin: 10px 0;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #2c3e50;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="bill-box">
    <h2><i class="fa-solid fa-receipt"></i> Customer Purchase Bill - Pahana Edu</h2>

    <form method="get" action="print_bill.jsp">
        <input type="text" name="customer_name" placeholder="Enter Customer Name" required />
        <button type="submit"><i class="fa-solid fa-calculator"></i> Generate Bill</button>
    </form>

<%
    String cname = request.getParameter("customer_name");
    String loggedUser = (String) session.getAttribute("username");
    double total = 0.0;

    if (cname != null && !cname.trim().isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");

            PreparedStatement ps = conn.prepareStatement(
                "SELECT cu.customer_id, cu.customer_name, b.book_name, b.price, p.quantity, (b.price * p.quantity) AS subtotal " +
                "FROM purchase p " +
                "JOIN customer cu ON p.customer_id = cu.customer_id " +
                "JOIN book b ON p.book_id = b.book_id " +
                "WHERE cu.customer_name LIKE ?"
            );

            ps.setString(1, "%" + cname + "%");

            ResultSet rs = ps.executeQuery();

            boolean found = false;
            int custId = 0;
            String customerDisplayName = "";
%>

<div class="info-bar">
    <div>Admin/Cashier: <%= loggedUser %></div>
<%
            while (rs.next()) {
                if (!found) {
                    custId = rs.getInt("customer_id");
                    customerDisplayName = rs.getString("customer_name");
%>
    <div>Customer: <%= customerDisplayName %></div>
</div>
<table>
    <tr>
        <th>📘 Book</th>
        <th>💰 Price</th>
        <th>🔢 Quantity</th>
        <th>🧮 Subtotal</th>
    </tr>
<%
                }
                found = true;
                double sub = rs.getDouble("subtotal");
                total += sub;
%>
    <tr>
        <td><%= rs.getString("book_name") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getInt("quantity") %></td>
        <td><%= sub %></td>
    </tr>
<%
            }

            if (found) {
%>
    <tr class="total-row">
        <td colspan="3">TOTAL</td>
        <td>Rs. <%= total %></td>
    </tr>
</table>
<%
                // Save to bill_history
                PreparedStatement save = conn.prepareStatement(
                    "INSERT INTO bill_history (customer_id, total_amount, generated_by, generated_on) VALUES (?, ?, ?, NOW())"
                );
                save.setInt(1, custId);
                save.setDouble(2, total);
                save.setString(3, loggedUser);
                save.executeUpdate();
                save.close();
            } else {
%>
    <p style="color:red; text-align:center;">No purchases found for customer "<%= cname %>"</p>
<%
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
%>
    <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
        }
    }
%>

    <button onclick="window.print()" class="print-btn"><i class="fa-solid fa-print"></i> Print Bill</button>
    <a href="admin_dashboard.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Admin Dashboard</a>
</div>
</body>
</html>

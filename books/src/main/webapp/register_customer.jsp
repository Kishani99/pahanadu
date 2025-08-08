<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Customer - Admin Panel</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #007bff;
        }

        form {
            margin-top: 20px;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .delete-btn {
            background-color: #dc3545;
            margin-left: 10px;
        }

        .delete-btn:hover {
            background-color: #bd2130;
        }

        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f1f1f1;
        }

        .msg {
            padding: 10px;
            border-radius: 6px;
            text-align: center;
            margin-bottom: 15px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }

        .icon {
            width: 24px;
            vertical-align: middle;
            margin-right: 8px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2><img class="icon" src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="register"> Register New Customer</h2>

    <% String msg = (String) request.getAttribute("message");
       String type = (String) request.getAttribute("messageType");
       if (msg != null && type != null) { %>
        <div class="msg <%= type %>"><%= msg %></div>
    <% } %>

    <form action="RegisterCustomerServlet" method="post">
        <input type="text" name="accountNumber" placeholder="Account Number" required>
        <input type="text" name="name" placeholder="Full Name" required>
        <textarea name="address" placeholder="Address" required></textarea>
        <input type="text" name="telephone" placeholder="Telephone Number" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit" class="btn">Register</button>
    </form>

    <h3>📋 Existing Customers</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Account Number</th>
            <th>Name</th>
            <th>Address</th>
            <th>Telephone</th>
            <th>Action</th>
        </tr>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM customers");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("accountNumber") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("telephone") %></td>
            <td>
                <form action="AdminDeleteCustomerServlet" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="btn delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
        %>
        <tr><td colspan="6">Error: <%= e.getMessage() %></td></tr>
        <%
            }
        %>
    </table>
</div>
</body>
</html>

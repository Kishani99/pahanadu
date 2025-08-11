<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Books - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f8;
            margin: 0; padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            text-shadow: 1px 1px 2px #aaa;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 30px;
            align-items: center;
        }
        input[type="text"], input[type="number"] {
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 6px;
            flex: 1;
            min-width: 150px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #007bff;
            outline: none;
        }
        button {
            background: #007bff;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 1rem;
            border-radius: 6px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0,123,255,0.3);
            transition: background-color 0.3s ease;
        }
        button:hover {
            background: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            background: #fff;
        }
        th {
            background: #007bff;
            color: white;
            text-shadow: 1px 1px 2px #004080;
        }
        tr:hover {
            background: #f1f9ff;
        }
        .delete-btn {
            background: #dc3545;
            border: none;
            padding: 8px 12px;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(220,53,69,0.3);
            transition: background-color 0.3s ease;
            font-size: 0.9rem;
        }
        .delete-btn:hover {
            background: #a71d2a;
        }
        .icon {
            margin-right: 6px;
        }
        .message {
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 8px;
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            box-shadow: 0 2px 5px rgba(40,167,69,0.2);
        }
    </style>
</head>
<body>
<div class="container">
    <h1><i class="fa-solid fa-book icon"></i>Manage Books</h1>

    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="message"><i class="fa-solid fa-circle-check"></i> <%= message %></div>
    <% } %>

    <form action="ManageBooksServlet" method="post">
        <input type="hidden" name="action" value="add" />
        <input type="text" name="title" placeholder="Book Title *" required />
        <input type="text" name="author" placeholder="Author" />
        <input type="text" name="category" placeholder="Category" />
        <input type="number" step="0.01" name="price" placeholder="Price *" required />
        <input type="number" name="quantity" placeholder="Quantity" min="0" />
        <button type="submit"><i class="fa-solid fa-plus"></i> Add Book</button>
    </form>

    <table>
        <thead>
            <tr>
                <th><i class="fa-solid fa-hashtag"></i> ID</th>
                <th><i class="fa-solid fa-book"></i> Title</th>
                <th><i class="fa-solid fa-user"></i> Author</th>
                <th><i class="fa-solid fa-tag"></i> Category</th>
                <th><i class="fa-solid fa-dollar-sign"></i> Price</th>
                <th><i class="fa-solid fa-boxes-stacked"></i> Quantity</th>
                <th><i class="fa-solid fa-trash"></i> Delete</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/pahanaedu";
                    String user = "root";
                    String pass = "";
                    Connection conn = DriverManager.getConnection(url, user, pass);

                    String sql = "SELECT * FROM books ORDER BY book_id DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("book_id");
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String category = rs.getString("category");
                        double price = rs.getDouble("price");
                        int quantity = rs.getInt("quantity");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= title %></td>
                <td><%= author != null ? author : "-" %></td>
                <td><%= category != null ? category : "-" %></td>
                <td>$<%= String.format("%.2f", price) %></td>
                <td><%= quantity %></td>
                <td>
                    <form action="ManageBooksServlet" method="post" onsubmit="return confirm('Delete this book?');" style="margin:0;">
                        <input type="hidden" name="action" value="delete" />
                        <input type="hidden" name="book_id" value="<%= id %>" />
                        <button class="delete-btn" type="submit" title="Delete Book">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
            %>
            <tr><td colspan="7" style="color:red;">Error: <%= e.getMessage() %></td></tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>

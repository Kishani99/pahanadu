<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Books - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            padding: 30px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        form {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            width: 90%;
            max-width: 600px;
            margin: 20px auto;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        label {
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        button {
            background: #3498db;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            width: 100%;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #2980b9;
        }

        .delete-btn {
            background: #e74c3c;
        }

        .delete-btn:hover {
            background: #c0392b;
        }

        .success-msg, .error-msg {
            padding: 12px;
            margin: 20px auto;
            border-radius: 6px;
            width: 90%;
            max-width: 600px;
            font-weight: bold;
            text-align: center;
        }

        .success-msg {
            background-color: #d4edda;
            color: #155724;
        }

        .error-msg {
            background-color: #f8d7da;
            color: #721c24;
        }

        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 15px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #2c3e50;
            color: white;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        .back-btn {
            display: block;
            margin: 30px auto;
            width: 220px;
            background: #6c757d;
            color: white;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        .back-btn:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>

<h2><i class="fa-solid fa-book"></i> Manage Books</h2>

<%
    String message = request.getParameter("message");
    if ("addsuccess".equals(message)) {
%>
    <div class="success-msg"><i class="fa-solid fa-circle-check"></i> Book added successfully!</div>
<%
    } else if ("deletesuccess".equals(message)) {
%>
    <div class="success-msg"><i class="fa-solid fa-trash"></i> Book deleted successfully!</div>
<%
    } else if ("error".equals(message)) {
%>
    <div class="error-msg"><i class="fa-solid fa-circle-xmark"></i> Operation failed!</div>
<%
    }
%>

<!-- Add Book Form -->
<form method="post" action="ManageBooksServlet">
    <label><i class="fa-solid fa-heading"></i> Title:</label>
    <input type="text" name="title" required>

    <label><i class="fa-solid fa-user-pen"></i> Author:</label>
    <input type="text" name="author" required>

    <label><i class="fa-solid fa-money-bill-wave"></i> Price:</label>
    <input type="number" name="price" step="0.01" required>

    <label><i class="fa-solid fa-boxes-stacked"></i> Quantity:</label>
    <input type="number" name="quantity" required>

    <button type="submit" name="action" value="add">
        <i class="fa-solid fa-plus-circle"></i> Add Book
    </button>
</form>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahanaedu", "root", "");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM book");

        while (rs.next()) {
      }
        rs.close();
        conn.close();
    } catch (Exception e) {
        out.print("<tr><td colspan='5'>Error loading data.</td></tr>");
    }
%>
</table>


<a href="cashier_dashboard.jsp" class="back-btn"><i class="fa-solid fa-arrow-left"></i> Back to Cashier Panel</a>

</body>
</html>

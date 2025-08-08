<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f4f9ff, #dfe9f3);
            padding: 30px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        form {
            max-width: 500px;
            margin: 20px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }

        button {
            width: 100%;
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        .result-box {
            margin-top: 30px;
            max-width: 700px;
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            margin-left: auto;
            margin-right: auto;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 30px;
            background: #6c757d;
            color: white;
            padding: 10px;
            text-decoration: none;
            border-radius: 8px;
            width: 200px;
            margin-left: auto;
            margin-right: auto;
        }

        .back-btn:hover {
            background: #5a6268;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <h2>📚🔍 Search Page</h2>

    <!-- Book Search Form -->
    <form method="post" action="SearchBookServlet">
        <input type="text" name="search" placeholder="Enter Book ID or Book Name" required>
        <button type="submit"><i class="fas fa-book"></i> Search Book</button>
    </form>

    <!-- Customer Search Form -->
    <form method="post" action="SearchCustomerServlet">
        <input type="text" name="search" placeholder="Enter Customer Name" required>
        <button type="submit"><i class="fas fa-user"></i> Search Customer</button>
    </form>

    <!-- Display Search Results -->
    <div class="result-box">
    <%
        String resultHtml = (String) request.getAttribute("result");
        if (resultHtml != null) {
            out.print(resultHtml);
        }
    %>
</div>


    <a href="admin_dashboard.jsp" class="back-btn">⬅️ Back to Admin Panel</a>
</body>
</html>

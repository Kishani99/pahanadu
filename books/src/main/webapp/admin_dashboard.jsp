<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Pahana Edu</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #d7e1ec, #f0f4f8);
        }

        .header {
            background-color: #007bff;
            padding: 20px;
            color: white;
            text-align: center;
            font-size: 24px;
        }

        .container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
            padding: 40px;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card img {
            width: 60px;
            margin-bottom: 15px;
        }

        .card a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .exit-button {
            position: fixed;
            top: 15px;
            right: 20px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 16px;
            cursor: pointer;
        }

        .exit-button:hover {
            background-color: #bd2130;
        }
    </style>
</head>
<body>

    <div class="header">
        📚 Admin Dashboard - Pahana Edu
    </div>

    <button class="exit-button" onclick="window.location.href='login.jsp'">Exit</button>

    <div class="container">
        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="Register">
            <a href="Admin register_customer.jsp">Register Customer</a>
        </div>


        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/1828/1828911.png" alt="Books">
            <a href="manage_books.jsp">Manage Books</a>
        </div>

        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/1077/1077063.png" alt="Search">
            <a href="search_customer.jsp">Search Customer</a>
        </div>

        <div class="card">
            <img src="https://cdn-icons-png.flaticon.com/512/3523/3523063.png" alt="Bill">
            <a href="callculate _print bill.jsp">Print & Calculate Bill</a>
        </div>
    </div>


</body>
</html>

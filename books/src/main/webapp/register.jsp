<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Customer Account - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .register-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .input-group {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 10px;
            background: #f9f9f9;
        }
        .input-group i {
            margin-right: 10px;
            color: #555;
        }
        .input-group input {
            border: none;
            outline: none;
            background: none;
            flex: 1;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #2196F3;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background: #1976D2;
        }
        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2><i class="fas fa-user-plus"></i> New Customer Registration</h2>
    <form action="RegisterServlet" method="post">
        <div class="input-group">
            <i class="fas fa-id-card"></i>
            <input type="text" name="accountNumber" placeholder="Account Number" required>
        </div>
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="name" placeholder="Full Name" required>
        </div>
        <div class="input-group">
            <i class="fas fa-map-marker-alt"></i>
            <input type="text" name="address" placeholder="Address" required>
        </div>
        <div class="input-group">
            <i class="fas fa-phone"></i>
            <input type="text" name="telephone" placeholder="Telephone" required>
        </div>
        <div class="input-group">
            <i class="fas fa-user-circle"></i>
            <input type="text" name="username" placeholder="Username" required>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required>
        </div>
        <button type="submit"><i class="fas fa-check"></i> Register</button>
    </form>
    <%
        String error = request.getParameter("error");
        if (error != null) {
            out.print("<p class='error'>" + error + "</p>");
        }
    %>
</div>
</body>
</html>

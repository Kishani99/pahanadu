<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 35px 30px;
            border-radius: 15px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
            width: 360px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 18px 40px rgba(0,0,0,0.25);
        }
        .login-container h2 {
            margin-bottom: 25px;
            color: #333;
            font-size: 1.6rem;
        }
        .input-group {
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 10px 12px;
            border-radius: 10px;
            background: #f9f9f9;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .input-group:focus-within {
            border-color: #4CAF50;
            box-shadow: 0 0 6px rgba(76, 175, 80, 0.4);
            background: #fff;
        }
        .input-group i {
            margin-right: 10px;
            color: #4CAF50;
            font-size: 1.2rem;
        }
        .input-group input {
            border: none;
            outline: none;
            background: none;
            flex: 1;
            font-size: 1rem;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 5px;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        button:hover {
            background: #45a049;
            transform: scale(1.02);
        }
        .register-btn {
            background: #2196F3;
            margin-top: 10px;
        }
        .register-btn:hover {
            background: #1976D2;
        }
        .error {
            color: red;
            margin-top: 15px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2><i class="fas fa-book-open"></i> Pahana Edu Login</h2>
    <form action="LoginServlet" method="post">
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="username" placeholder="Username" required>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required>
        </div>
        <button type="submit"><i class="fas fa-sign-in-alt"></i> Login</button>
    </form>
    <form action="register.jsp" method="get">
        <button type="submit" class="register-btn"><i class="fas fa-user-plus"></i> Register</button>
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

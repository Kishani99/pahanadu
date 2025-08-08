<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cashier Dashboard - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #eef2f3, #8e9eab);
            padding: 40px;
        }

        .dashboard-container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            padding: 30px;
            text-align: center;
        }

        h2 {
            color: #34495e;
            margin-bottom: 20px;
        }

        .btn {
            display: block;
            margin: 15px auto;
            padding: 14px 24px;
            width: 60%;
            background: #3498db;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn:hover {
            background: #2980b9;
        }

        .logout-btn {
            background: #e74c3c;
        }

        .logout-btn:hover {
            background: #c0392b;
        }

        .icon {
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>👨‍💼 Cashier Dashboard</h2>
        <a class="btn" href="cashier_addBook.jsp"><i class="fas fa-plus icon"></i>Add Books</a>
        <a class="btn" href="view_books.jsp"><i class="fas fa-book icon"></i>View Books</a>
        <a class="btn" href="update_book.jsp"><i class="fas fa-edit icon"></i>Update Books</a>
        <a class="btn" href="print_bill.jsp"><i class="fas fa-file-invoice icon"></i>Print Bill</a>
        <a class="btn logout-btn" href="logout.jsp"><i class="fas fa-sign-out-alt icon"></i>Exit</a>
    </div>
</body>
</html>

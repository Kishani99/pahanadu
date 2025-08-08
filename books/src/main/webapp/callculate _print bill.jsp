<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bookshop Bill - Pahana Edu</title>
    <link rel="stylesheet" href="css/bill.css">
    <style>
        body {
            font-family: "Open Sans", sans-serif;
            background-color: #f5ce64;
            margin: 0;
            padding: 20px;
        }

        h3 {
            text-align: center;
            color: #2c3e50;
        }

        hr {
            width: 100%;
            border: 1px solid #ccc;
        }

        .section {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
        }

        .section div {
            flex: 1;
            padding: 0 10px;
        }

        #bill-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        #bill-table th, #bill-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        #bill-table th {
            background-color: #fff;
            color: black;
        }

        #bill-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        #bill-table tr:hover {
            background-color: #ddd;
        }

        .button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 20px;
            margin: 20px 10px;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            width: 40%;
        }

        .button:hover {
            background-color: #0056b3;
        }

        .button-group {
            text-align: center;
        }

        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #ccc;
            color: black;
            text-align: center;
            padding: 10px;
        }

        .total {
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
            font-size: 18px;
        }
    </style>
</head>
<body>

    <h3>📚 Bookshop Invoice - Pahana Edu</h3>
    
    <h3>📘 Book Details</h3>
    <table id="bill-table">
        <tr>
            <th>#</th>
            <th>Book Title</th>
            <th>Genre</th>
            <th>Price (LKR)</th>
            <th>Quantity</th>
            <th>Subtotal (LKR)</th>
        </tr>

       

    </table>


    <div class="button-group">
        <a href="customer_dashboard.jsp"><button class="button">⬅ Continue Shopping</button></a>
        <button class="button" onclick="window.print()">🖨 Print Bill</button>
    </div>

    <div class="footer">
        © 2025 Pahana Edu Bookshop | All rights reserved.
    </div>

</body>
</html>

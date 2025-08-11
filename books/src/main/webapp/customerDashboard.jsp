<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Purchase - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; margin: 0; padding: 0; min-height: 100vh; display: flex; flex-direction: column;}
        
        /* Navbar */
        .navbar {
            display: flex;
            background: linear-gradient(90deg, #4a90e2, #007bff);
            padding: 12px;
            box-shadow: 0px 4px 8px rgba(0,0,0,0.2);
        }
        .navbar a {
            color: white; padding: 10px 15px;
            text-decoration: none; font-weight: bold;
        }
        .navbar a:hover {
            background: rgba(255,255,255,0.2);
            border-radius: 5px;
        }

        h1 { text-align: center; color: #333; margin: 20px 0; }

        /* Search Bar */
        .search-box {
            text-align: center; margin: 20px;
        }
        .search-box input[type=text] {
            padding: 10px; width: 300px;
            border-radius: 5px; border: 1px solid #ccc;
        }
        .search-box input[type=submit] {
            padding: 10px 15px;
            background: #007bff; color: white;
            border: none; border-radius: 5px; cursor: pointer;
        }
        .search-box input[type=submit]:hover {
            background: #0056b3;
        }

        /* Book Cards */
        .book-container {
            display: flex; flex-wrap: wrap;
            justify-content: center; gap: 20px; padding: 20px;
            flex-grow: 1;
        }
        .book-card {
            background: white; border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            width: 220px; text-align: center;
            padding: 15px; transition: transform 0.2s;
            display: flex; flex-direction: column;
            justify-content: space-between;
        }
        .book-card:hover { transform: translateY(-5px); }
        .book-card img {
            max-width: 100%; height: 200px; border-radius: 5px;
            object-fit: cover;
        }
        .book-card h3 { font-size: 18px; margin: 10px 0; }
        .book-card p { margin: 5px 0; color: #555; }
        
        /* Add to Cart Button */
        .book-card button {
            background-color: #28a745;
            color: white; padding: 8px 15px;
            border: none; cursor: pointer;
            border-radius: 5px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
            display: flex; align-items: center;
            justify-content: center; gap: 5px;
            margin-top: 10px;
            font-weight: bold;
        }
        .book-card button:hover { background-color: #218838; }

        /* Footer */
        footer {
            background: #333; color: white; padding: 20px; text-align: center;
            box-shadow: 0 -4px 8px rgba(0,0,0,0.2);
        }
        footer .social-icons a {
            color: white; margin: 0 10px; font-size: 20px;
            transition: color 0.3s ease;
        }
        footer .social-icons a:hover {
            color: #007bff;
        }
        footer p { margin: 5px 0; }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <a href="customer_purchase.jsp"><i class="fa fa-home"></i> Home</a>
        <a href="view_cart.jsp"><i class="fa fa-shopping-cart"></i> My Cart</a>
        <a href="checkout.jsp"><i class="fa fa-credit-card"></i> Checkout</a>
        <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>

    <h1>Buy Your Favorite Books</h1>

    <!-- Search form -->
    <div class="search-box">
        <form method="get" action="customer_purchase.jsp">
            <input type="text" name="search" placeholder="Search books..." 
                value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <input type="submit" value="Search">
        </form>
    </div>

    <!-- Book Listing -->
    <div class="book-container">

        <%
            // Hardcoded book list as example, replace with DB in production
            class Book {
                String title, category, imgUrl;
                double price;
                int id;
                Book(int id, String t, String c, double p, String i) {
                    this.id = id; title = t; category = c; price = p; imgUrl = i;
                }
            }

            List<Book> books = new ArrayList<>();
            books.add(new Book(1, "The Great Gatsby", "Fiction", 1250, "https://images-na.ssl-images-amazon.com/images/I/81af+MCATTL.jpg"));
            books.add(new Book(2, "Atomic Habits", "Self-help", 2000, "https://images-na.ssl-images-amazon.com/images/I/51-nXsSRfZL._SX328_BO1,204,203,200_.jpg"));
            books.add(new Book(3, "Clean Code", "Programming", 3500, "https://images-na.ssl-images-amazon.com/images/I/41xShlnTZTL._SX374_BO1,204,203,200_.jpg"));
            books.add(new Book(4, "Harry Potter and the Sorcerer's Stone", "Fantasy", 1800, "https://images-na.ssl-images-amazon.com/images/I/51UoqRAxwEL._SX331_BO1,204,203,200_.jpg"));
            books.add(new Book(5, "Rich Dad Poor Dad", "Finance", 1500, "https://images-na.ssl-images-amazon.com/images/I/81bsw6fnUiL.jpg"));
            books.add(new Book(6, "The Lean Startup", "Business", 2200, "https://images-na.ssl-images-amazon.com/images/I/81-QB7nDh4L.jpg"));

            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                search = search.toLowerCase();
            }

            for (Book b : books) {
                if (search == null || search.isEmpty() || b.title.toLowerCase().contains(search) || b.category.toLowerCase().contains(search)) {
        %>
            <div class="book-card">
                <img src="<%= b.imgUrl %>" alt="Book Image">
                <h3><%= b.title %></h3>
                <p><i class="fa fa-tag"></i> <%= b.category %></p>
                <p><i class="fa fa-money-bill-wave"></i> Rs. <%= b.price %></p>
                <form method="post" action="AddToCartServlet">
                    <input type="hidden" name="bookId" value="<%= b.id %>">
                    <button type="submit"><i class="fa fa-cart-plus"></i> Add to Cart</button>
                </form>
            </div>
        <%
                }
            }
        %>
    </div>

    <!-- Footer -->
    <footer>
        <div class="social-icons">
            <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
            <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
        </div>
        <p>&copy; 2025 Pahana Edu. All Rights Reserved.</p>
        <p>Email: support@pahanaedu.com | Phone: +94 71 234 5678</p>
    </footer>

</body>
</html>

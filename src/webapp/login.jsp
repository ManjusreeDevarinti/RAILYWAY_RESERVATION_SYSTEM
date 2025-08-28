<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚂 Railway Reservation System</h1>
            <p>Login to your account</p>
        </div>

        <div class="nav">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="searchTrains">Search Trains</a></li>
            </ul>
        </div>

        <div class="card" style="max-width: 500px; margin: 0 auto;">
            <h2>Login to Your Account</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <form id="loginForm" action="login" method="post">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" 
                           placeholder="Enter your username" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Enter your password" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block">Login</button>
                </div>
            </form>

            <div style="text-align: center; margin-top: 2rem;">
                <p>Don't have an account? <a href="register.jsp" style="color: #667eea; text-decoration: none; font-weight: 500;">Register here</a></p>
                <p><a href="index.jsp" style="color: #718096; text-decoration: none;">← Back to Home</a></p>
            </div>
        </div>
    </div>

    <script src="js/script.js"></script>
</body>
</html>

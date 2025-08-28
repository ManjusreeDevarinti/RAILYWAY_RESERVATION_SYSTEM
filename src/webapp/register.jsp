<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚂 Railway Reservation System</h1>
            <p>Create your account</p>
        </div>

        <div class="nav">
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="searchTrains">Search Trains</a></li>
            </ul>
        </div>

        <div class="card" style="max-width: 700px; margin: 0 auto;">
            <h2>Create Your Account</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form id="registrationForm" action="register" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">First Name:</label>
                        <input type="text" id="firstName" name="firstName" class="form-control" 
                               placeholder="Enter your first name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="lastName">Last Name:</label>
                        <input type="text" id="lastName" name="lastName" class="form-control" 
                               placeholder="Enter your last name" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" 
                           placeholder="Choose a unique username" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           placeholder="Enter your email address" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="Enter password (min 6 characters)" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password:</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                               placeholder="Confirm your password" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number:</label>
                    <input type="tel" id="phone" name="phone" class="form-control" 
                           placeholder="Enter 10-digit phone number" pattern="[0-9]{10}" required>
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <textarea id="address" name="address" class="form-control" rows="3" 
                              placeholder="Enter your complete address"></textarea>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block">Create Account</button>
                </div>
            </form>

            <div style="text-align: center; margin-top: 2rem;">
                <p>Already have an account? <a href="login.jsp" style="color: #667eea; text-decoration: none; font-weight: 500;">Login here</a></p>
                <p><a href="index.jsp" style="color: #718096; text-decoration: none;">← Back to Home</a></p>
            </div>
        </div>
    </div>

    <script src="js/script.js"></script>
</body>
</html>

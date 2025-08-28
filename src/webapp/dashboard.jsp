<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚂 Railway Reservation System</h1>
            <p>Welcome back, <%= user.getFirstName() %>!</p>
        </div>

        <div class="nav">
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="searchTrains">Search Trains</a></li>
                <li><a href="myBookings.jsp">My Bookings</a></li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="#" onclick="confirmLogout()">Logout</a></li>
            </ul>
        </div>

        <div class="card">
            <h2>Welcome to Your Dashboard</h2>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div style="font-size: 2rem; margin-bottom: 1rem;">👋</div>
                    <h3 style="color: #4a5568; margin-bottom: 0.5rem;">Hello <%= user.getFirstName() %>!</h3>
                    <p style="color: #718096;">Ready to plan your next journey?</p>
                </div>
                
                <div class="stat-card">
                    <div style="font-size: 2rem; margin-bottom: 1rem;">🎫</div>
                    <h3 style="color: #4a5568; margin-bottom: 0.5rem;">Quick Booking</h3>
                    <p style="color: #718096;">Search and book trains instantly</p>
                    <a href="searchTrains" class="btn btn-primary" style="margin-top: 1rem;">Search Trains</a>
                </div>
                
                <div class="stat-card">
                    <div style="font-size: 2rem; margin-bottom: 1rem;">📋</div>
                    <h3 style="color: #4a5568; margin-bottom: 0.5rem;">My Bookings</h3>
                    <p style="color: #718096;">View and manage your reservations</p>
                    <a href="myBookings.jsp" class="btn btn-secondary" style="margin-top: 1rem;">View Bookings</a>
                </div>
            </div>

            <div style="margin-top: 3rem;">
                <h3 style="color: #4a5568; margin-bottom: 2rem;">Quick Actions</h3>
                
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                    <div class="train-card">
                        <h4 style="color: #667eea; margin-bottom: 1rem;">🔍 Search Trains</h4>
                        <p style="color: #718096; margin-bottom: 1.5rem;">Find trains between any two stations and check availability</p>
                        <a href="searchTrains" class="btn btn-primary">Start Search</a>
                    </div>
                    
                    <div class="train-card">
                        <h4 style="color: #667eea; margin-bottom: 1rem;">📱 Mobile Booking</h4>
                        <p style="color: #718096; margin-bottom: 1.5rem;">Book tickets on-the-go with our mobile-friendly interface</p>
                        <a href="searchTrains" class="btn btn-success">Book Now</a>
                    </div>
                    
                    <div class="train-card">
                        <h4 style="color: #667eea; margin-bottom: 1rem;">💳 Payment Options</h4>
                        <p style="color: #718096; margin-bottom: 1.5rem;">Multiple secure payment methods available for your convenience</p>
                        <button class="btn btn-secondary" onclick="showAlert('Feature coming soon!', 'info')">Learn More</button>
                    </div>
                    
                    <div class="train-card">
                        <h4 style="color: #667eea; margin-bottom: 1rem;">🎯 Travel Tips</h4>
                        <p style="color: #718096; margin-bottom: 1.5rem;">Get tips for comfortable and safe train travel</p>
                        <button class="btn btn-secondary" onclick="showAlert('Feature coming soon!', 'info')">View Tips</button>
                    </div>
                </div>
            </div>

            <div style="margin-top: 3rem; padding: 2rem; background: rgba(102, 126, 234, 0.1); border-radius: 10px;">
                <h3 style="color: #4a5568; margin-bottom: 1rem;">📢 Important Information</h3>
                <ul style="color: #718096; line-height: 1.8;">
                    <li>Book your tickets at least 2 hours before departure</li>
                    <li>Carry a valid ID proof during travel</li>
                    <li>Arrive at the station 30 minutes before departure</li>
                    <li>Check platform information before boarding</li>
                    <li>Keep your e-ticket ready for verification</li>
                </ul>
            </div>
        </div>

        <footer style="text-align: center; margin-top: 2rem; padding: 1rem; color: rgba(255,255,255,0.8);">
            <p>&copy; 2025 Railway Reservation System. All rights reserved.</p>
        </footer>
    </div>

    <script src="js/script.js"></script>
</body>
</html>

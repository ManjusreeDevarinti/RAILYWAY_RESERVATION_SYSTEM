<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚂 Railway Reservation System</h1>
            <p>Your journey begins here - Book trains with ease and comfort</p>
        </div>

        <div class="card">
            <h2>Welcome to Railway Reservation System</h2>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Trains Available</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">1000+</div>
                    <div class="stat-label">Cities Connected</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Booking Service</div>
                </div>
            </div>

            <div style="text-align: center; margin: 2rem 0;">
                <p style="font-size: 1.2rem; color: #4a5568; margin-bottom: 2rem;">
                    Plan your journey with India's most trusted railway reservation platform
                </p>
                
                <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
                    <a href="login.jsp" class="btn btn-primary">Login to Your Account</a>
                    <a href="register.jsp" class="btn btn-secondary">Create New Account</a>
                    <a href="searchTrains" class="btn btn-success">Search Trains</a>
                </div>
            </div>

            <div style="margin-top: 3rem;">
                <h3 style="text-align: center; margin-bottom: 2rem; color: #4a5568;">Why Choose Us?</h3>
                
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem;">
                    <div style="text-align: center; padding: 1.5rem;">
                        <div style="font-size: 3rem; margin-bottom: 1rem;">🎫</div>
                        <h4 style="color: #4a5568; margin-bottom: 0.5rem;">Easy Booking</h4>
                        <p style="color: #718096;">Book tickets in just a few clicks with our user-friendly interface</p>
                    </div>
                    
                    <div style="text-align: center; padding: 1.5rem;">
                        <div style="font-size: 3rem; margin-bottom: 1rem;">🔒</div>
                        <h4 style="color: #4a5568; margin-bottom: 0.5rem;">Secure Payment</h4>
                        <p style="color: #718096;">Your transactions are protected with industry-standard security</p>
                    </div>
                    
                    <div style="text-align: center; padding: 1.5rem;">
                        <div style="font-size: 3rem; margin-bottom: 1rem;">⚡</div>
                        <h4 style="color: #4a5568; margin-bottom: 0.5rem;">Instant Confirmation</h4>
                        <p style="color: #718096;">Get instant booking confirmation and e-tickets</p>
                    </div>
                    
                    <div style="text-align: center; padding: 1.5rem;">
                        <div style="font-size: 3rem; margin-bottom: 1rem;">📱</div>
                        <h4 style="color: #4a5568; margin-bottom: 0.5rem;">Mobile Friendly</h4>
                        <p style="color: #718096;">Access from anywhere using your mobile device</p>
                    </div>
                </div>
            </div>
        </div>

        <footer style="text-align: center; margin-top: 2rem; padding: 1rem; color: rgba(255,255,255,0.8);">
            <p>&copy; 2025 Railway Reservation System. All rights reserved.</p>
            <p>Developed for educational purposes</p>
        </footer>
    </div>

    <script src="js/script.js"></script>
</body>
</html>

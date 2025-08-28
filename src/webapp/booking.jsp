<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.Train" %>
<%@ page import="com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Train train = (Train) request.getAttribute("train");
    if (train == null) {
        response.sendRedirect("searchTrains");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Ticket - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚂 Railway Reservation System</h1>
            <p>Complete your booking</p>
        </div>

        <div class="nav">
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="searchTrains">Search Trains</a></li>
                <li><a href="myBookings.jsp">My Bookings</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>

        <!-- Train Details Card -->
        <div class="card">
            <h2>🚆 Train Details</h2>
            
            <div class="train-card">
                <div class="train-header">
                    <div>
                        <div class="train-name"><%= train.getTrainName() %></div>
                        <div class="train-number">#<%= train.getTrainNumber() %></div>
                    </div>
                    <div style="text-align: right;">
                        <div style="font-size: 1.2rem; font-weight: bold; color: #667eea;">
                            ₹<%= String.format("%.2f", train.getFare()) %>
                        </div>
                        <div style="font-size: 0.9rem; color: #718096;">per person</div>
                    </div>
                </div>
                
                <div class="train-details">
                    <div class="detail-item">
                        <div class="detail-label">From</div>
                        <div class="detail-value"><%= train.getSource() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">To</div>
                        <div class="detail-value"><%= train.getDestination() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Departure</div>
                        <div class="detail-value"><%= train.getDepartureTime() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Arrival</div>
                        <div class="detail-value"><%= train.getArrivalTime() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Available Seats</div>
                        <div class="detail-value"><%= train.getAvailableSeats() %></div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">Train Type</div>
                        <div class="detail-value"><%= train.getTrainType() %></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Booking Form -->
        <div class="card">
            <h2>📝 Booking Details</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form id="bookingForm" action="bookTicket" method="post">
                <input type="hidden" name="trainId" value="<%= train.getTrainId() %>">
                <input type="hidden" id="farePerTicket" value="<%= train.getFare() %>">

                <div class="form-group">
                    <label for="journeyDate">Journey Date:</label>
                    <input type="date" id="journeyDate" name="journeyDate" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="numberOfPassengers">Number of Passengers:</label>
                    <select id="numberOfPassengers" name="numberOfPassengers" class="form-control" 
                            onchange="updatePassengerFields(); calculateTotalFare();" required>
                        <option value="">Select number of passengers</option>
                        <% for (int i = 1; i <= Math.min(6, train.getAvailableSeats()); i++) { %>
                            <option value="<%= i %>"><%= i %> Passenger<%= i > 1 ? "s" : "" %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group" id="passengerNamesContainer">
                    <label for="passengerNames">Passenger Names:</label>
                    <input type="text" id="passengerNames" name="passengerNames" class="form-control" 
                           placeholder="Enter passenger names separated by commas" required>
                    <small style="color: #718096; font-size: 0.9rem;">
                        Example: John Doe, Jane Smith (Names as per ID proof)
                    </small>
                </div>

                <div style="background: rgba(102, 126, 234, 0.1); padding: 1.5rem; border-radius: 10px; margin: 2rem 0;">
                    <h3 style="color: #4a5568; margin-bottom: 1rem;">💰 Fare Summary</h3>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>Base Fare per Ticket:</span>
                        <span>₹<%= String.format("%.2f", train.getFare()) %></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                        <span>Number of Passengers:</span>
                        <span id="passengerCount">0</span>
                    </div>
                    <hr style="margin: 1rem 0; border: 1px solid rgba(102, 126, 234, 0.3);">
                    <div style="display: flex; justify-content: space-between; font-size: 1.2rem; font-weight: bold; color: #4a5568;">
                        <span>Total Fare:</span>
                        <span id="totalFare">₹0.00</span>
                    </div>
                </div>

                <div style="background: rgba(245, 101, 101, 0.1); padding: 1.5rem; border-radius: 10px; margin: 2rem 0;">
                    <h4 style="color: #e53e3e; margin-bottom: 1rem;">📋 Important Instructions</h4>
                    <ul style="color: #742a2a; line-height: 1.6;">
                        <li>Enter passenger names exactly as per government ID proof</li>
                        <li>Carry original ID proof during travel</li>
                        <li>Arrive at station 30 minutes before departure</li>
                        <li>E-ticket will be sent to your registered email</li>
                        <li>Cancellation charges may apply as per railway rules</li>
                    </ul>
                </div>

                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                    <button type="button" onclick="goBack()" class="btn btn-secondary">
                        ← Back to Search
                    </button>
                    <button type="submit" class="btn btn-success" onclick="return confirmBooking()">
                        💳 Confirm Booking
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="js/script.js"></script>
    <script>
        // Update passenger count display when selection changes
        document.getElementById('numberOfPassengers').addEventListener('change', function() {
            document.getElementById('passengerCount').textContent = this.value || '0';
        });
    </script>
</body>
</html>

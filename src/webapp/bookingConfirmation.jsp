<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.railway.model.Booking" %>
<%@ page import="com.railway.model.Train" %>
<%@ page import="com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Booking booking = (Booking) request.getAttribute("booking");
    Train train = (Train) request.getAttribute("train");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        @media print {
            .no-print { display: none !important; }
            .card { box-shadow: none; border: 1px solid #ddd; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header no-print">
            <h1>🚂 Railway Reservation System</h1>
            <p>Booking Confirmation</p>
        </div>

        <div class="nav no-print">
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="searchTrains">Search Trains</a></li>
                <li><a href="myBookings.jsp">My Bookings</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>

        <!-- Success Message -->
        <div class="card">
            <div style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 4rem; color: #48bb78; margin-bottom: 1rem;">✅</div>
                <h2 style="color: #48bb78; margin-bottom: 0.5rem;">Booking Confirmed!</h2>
                <p style="color: #718096; font-size: 1.1rem;">Your train ticket has been successfully booked</p>
            </div>

            <% if (booking != null && train != null) { %>
            <!-- E-Ticket -->
            <div id="bookingDetails" style="border: 2px solid #667eea; border-radius: 15px; padding: 2rem; margin: 2rem 0; background: rgba(102, 126, 234, 0.05);">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; flex-wrap: wrap;">
                    <h3 style="color: #667eea; margin: 0;">🎫 E-TICKET</h3>
                    <div style="text-align: right;">
                        <div style="font-size: 0.9rem; color: #718096;">Booking ID</div>
                        <div style="font-size: 1.2rem; font-weight: bold; color: #4a5568;">#<%= booking.getBookingId() %></div>
                    </div>
                </div>

                <!-- Passenger Details -->
                <div style="margin-bottom: 2rem;">
                    <h4 style="color: #4a5568; margin-bottom: 1rem; border-bottom: 2px solid #e2e8f0; padding-bottom: 0.5rem;">
                        👤 Passenger Details
                    </h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Passenger Name(s)</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= booking.getPassengerNames() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Number of Passengers</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= booking.getNumberOfPassengers() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Seat Numbers</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= booking.getSeatNumbers() %></div>
                        </div>
                    </div>
                </div>

                <!-- Train Details -->
                <div style="margin-bottom: 2rem;">
                    <h4 style="color: #4a5568; margin-bottom: 1rem; border-bottom: 2px solid #e2e8f0; padding-bottom: 0.5rem;">
                        🚆 Train Details
                    </h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Train Name</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= train.getTrainName() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Train Number</div>
                            <div style="font-weight: 500; color: #4a5568;">#<%= train.getTrainNumber() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Train Type</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= train.getTrainType() %></div>
                        </div>
                    </div>
                </div>

                <!-- Journey Details -->
                <div style="margin-bottom: 2rem;">
                    <h4 style="color: #4a5568; margin-bottom: 1rem; border-bottom: 2px solid #e2e8f0; padding-bottom: 0.5rem;">
                        🗓️ Journey Details
                    </h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">From</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= train.getSource() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">To</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= train.getDestination() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Journey Date</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= booking.getJourneyDate() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Departure Time</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= train.getDepartureTime() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Arrival Time</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= train.getArrivalTime() %></div>
                        </div>
                    </div>
                </div>

                <!-- Payment Details -->
                <div style="margin-bottom: 2rem;">
                    <h4 style="color: #4a5568; margin-bottom: 1rem; border-bottom: 2px solid #e2e8f0; padding-bottom: 0.5rem;">
                        💰 Payment Details
                    </h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Total Fare</div>
                            <div style="font-weight: bold; color: #48bb78; font-size: 1.2rem;">₹<%= String.format("%.2f", booking.getTotalFare()) %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Booking Status</div>
                            <div style="font-weight: 500; color: #48bb78;"><%= booking.getStatus() %></div>
                        </div>
                        <div>
                            <div style="font-size: 0.9rem; color: #718096;">Booking Date</div>
                            <div style="font-weight: 500; color: #4a5568;"><%= booking.getBookingDateTime().toLocalDate() %></div>
                        </div>
                    </div>
                </div>

                <!-- Important Instructions -->
                <div style="background: rgba(245, 101, 101, 0.1); padding: 1.5rem; border-radius: 10px; margin-top: 2rem;">
                    <h4 style="color: #e53e3e; margin-bottom: 1rem;">📋 Important Instructions</h4>
                    <ul style="color: #742a2a; line-height: 1.6; margin: 0;">
                        <li>Carry original ID proof (same as provided during booking)</li>
                        <li>Arrive at station 30 minutes before departure</li>
                        <li>Keep this e-ticket ready for verification</li>
                        <li>Check platform number before boarding</li>
                        <li>Contact customer support for any queries</li>
                    </ul>
                </div>
            </div>
            <% } %>

            <!-- Action Buttons -->
            <div style="text-align: center; margin-top: 2rem;" class="no-print">
                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                    <button onclick="printBooking()" class="btn btn-primary">
                        🖨️ Print E-Ticket
                    </button>
                    <button onclick="copyBookingDetails()" class="btn btn-secondary">
                        📋 Copy Details
                    </button>
                    <a href="searchTrains" class="btn btn-success">
                        🔍 Book Another Train
                    </a>
                    <a href="dashboard.jsp" class="btn btn-secondary">
                        🏠 Go to Dashboard
                    </a>
                </div>
            </div>

            <!-- Contact Information -->
            <div style="background: rgba(102, 126, 234, 0.1); padding: 1.5rem; border-radius: 10px; margin-top: 2rem; text-align: center;">
                <h4 style="color: #667eea; margin-bottom: 1rem;">📞 Need Help?</h4>
                <p style="color: #4a5568; margin: 0;">
                    Customer Support: 1800-XXX-XXXX | Email: support@railway.com
                    <br>Available 24/7 for your assistance
                </p>
            </div>
        </div>
    </div>

    <script src="js/script.js"></script>
</body>
</html>

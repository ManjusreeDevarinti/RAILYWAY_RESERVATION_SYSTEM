<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.railway.model.Train" %>
<%@ page import="com.railway.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    List<String> stations = (List<String>) request.getAttribute("stations");
    List<Train> trains = (List<Train>) request.getAttribute("trains");
    Boolean searchPerformed = (Boolean) request.getAttribute("searchPerformed");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Trains - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚂 Railway Reservation System</h1>
            <p>Search and book your train tickets</p>
        </div>

        <div class="nav">
            <ul>
                <% if (user != null) { %>
                    <li><a href="dashboard.jsp">Dashboard</a></li>
                    <li><a href="searchTrains">Search Trains</a></li>
                    <li><a href="myBookings.jsp">My Bookings</a></li>
                    <li><a href="logout">Logout</a></li>
                <% } else { %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp">Register</a></li>
                <% } %>
            </ul>
        </div>

        <div class="card">
            <h2>🔍 Search Trains</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-info">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>

            <form id="searchForm" action="searchTrains" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="source">From Station:</label>
                        <select id="source" name="source" class="form-control" required>
                            <option value="">Select Source Station</option>
                            <% if (stations != null) {
                                String selectedSource = (String) request.getAttribute("source");
                                for (String station : stations) { %>
                                <option value="<%= station %>" <%= (station.equals(selectedSource)) ? "selected" : "" %>>
                                    <%= station %>
                                </option>
                            <% } } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="destination">To Station:</label>
                        <select id="destination" name="destination" class="form-control" required>
                            <option value="">Select Destination Station</option>
                            <% if (stations != null) {
                                String selectedDestination = (String) request.getAttribute("destination");
                                for (String station : stations) { %>
                                <option value="<%= station %>" <%= (station.equals(selectedDestination)) ? "selected" : "" %>>
                                    <%= station %>
                                </option>
                            <% } } %>
                        </select>
                    </div>
                </div>

                <div class="form-group" style="text-align: center;">
                    <button type="submit" class="btn btn-primary">🔍 Search Trains</button>
                </div>
            </form>
        </div>

        <% if (searchPerformed != null && searchPerformed && trains != null) { %>
            <div class="card">
                <h2>🚆 Available Trains</h2>
                
                <% if (trains.isEmpty()) { %>
                    <div class="alert alert-info">
                        <p style="text-align: center; font-size: 1.1rem;">
                            No trains found for the selected route.<br>
                            Please try different stations or check back later.
                        </p>
                    </div>
                <% } else { %>
                    <div style="margin-bottom: 1rem;">
                        <p><strong>Route:</strong> <%= request.getAttribute("source") %> → <%= request.getAttribute("destination") %></p>
                        <p><strong>Trains Found:</strong> <%= trains.size() %></p>
                    </div>
                    
                    <% for (Train train : trains) { %>
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
                                    <div class="detail-label">Departure</div>
                                    <div class="detail-value"><%= train.getDepartureTime() %></div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="detail-label">Arrival</div>
                                    <div class="detail-value"><%= train.getArrivalTime() %></div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="detail-label">Train Type</div>
                                    <div class="detail-value"><%= train.getTrainType() %></div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="detail-label">Available Seats</div>
                                    <div class="detail-value">
                                        <span style="color: <%= train.getAvailableSeats() > 10 ? "#48bb78" : "#f56565" %>;">
                                            <%= train.getAvailableSeats() %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            <div style="text-align: center; margin-top: 1.5rem;">
                                <% if (train.getAvailableSeats() > 0) { %>
                                    <% if (user != null) { %>
                                        <a href="bookTicket?trainId=<%= train.getTrainId() %>" class="btn btn-success">
                                            📝 Book This Train
                                        </a>
                                    <% } else { %>
                                        <a href="login.jsp" class="btn btn-primary">
                                            🔐 Login to Book
                                        </a>
                                    <% } %>
                                <% } else { %>
                                    <button class="btn btn-secondary" disabled>
                                        ❌ Fully Booked
                                    </button>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
        <% } %>

        <% if (searchPerformed == null || !searchPerformed) { %>
            <div class="card">
                <h3 style="text-align: center; color: #4a5568;">Popular Routes</h3>
                
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-top: 2rem;">
                    <div style="text-align: center; padding: 1.5rem; background: rgba(102, 126, 234, 0.1); border-radius: 10px;">
                        <h4 style="color: #667eea;">Delhi → Mumbai</h4>
                        <p style="color: #718096;">Express routes available</p>
                    </div>
                    
                    <div style="text-align: center; padding: 1.5rem; background: rgba(102, 126, 234, 0.1); border-radius: 10px;">
                        <h4 style="color: #667eea;">Bangalore → Chennai</h4>
                        <p style="color: #718096;">Comfortable journey</p>
                    </div>
                    
                    <div style="text-align: center; padding: 1.5rem; background: rgba(102, 126, 234, 0.1); border-radius: 10px;">
                        <h4 style="color: #667eea;">Kolkata → Delhi</h4>
                        <p style="color: #718096;">Multiple options</p>
                    </div>
                    
                    <div style="text-align: center; padding: 1.5rem; background: rgba(102, 126, 234, 0.1); border-radius: 10px;">
                        <h4 style="color: #667eea;">Pune → Hyderabad</h4>
                        <p style="color: #718096;">Best connectivity</p>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <script src="js/script.js"></script>
</body>
</html>

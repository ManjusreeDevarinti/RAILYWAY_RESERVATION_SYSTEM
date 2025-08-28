<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.railway.model.User" %>
<%@ page import="com.railway.model.Booking" %>
<%@ page import="com.railway.model.Train" %>
<%@ page import="com.railway.dao.BookingDAO" %>
<%@ page import="com.railway.dao.TrainDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get user's bookings
    BookingDAO bookingDAO = new BookingDAO();
    TrainDAO trainDAO = new TrainDAO();
    List<Booking> bookings = bookingDAO.getBookingsByUserId(user.getUserId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .booking-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
        }

        .booking-card:hover {
            transform: translateX(5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }

        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .booking-id {
            font-size: 1.2rem;
            font-weight: bold;
            color: #4a5568;
        }

        .booking-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .status-confirmed {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-cancelled {
            background: #fed7d7;
            color: #742a2a;
        }

        .booking-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .detail-group {
            background: rgba(102, 126, 234, 0.05);
            padding: 1rem;
            border-radius: 8px;
        }

        .detail-label {
            font-size: 0.8rem;
            color: #718096;
            margin-bottom: 0.3rem;
            font-weight: 500;
        }

        .detail-value {
            font-size: 1rem;
            color: #4a5568;
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #718096;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        /* Styles for filter/sort/search controls */
        .controls-container {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1.5rem;
            align-items: center;
            justify-content: flex-end; /* Align to end for better look */
        }

        .controls-container .status-btn {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: 1px solid #cbd5e0;
            background-color: #f7fafc;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .controls-container .status-btn:hover {
            background-color: #edf2f7;
        }

        .controls-container .status-btn.active {
            background-color: #667eea;
            color: white;
            border-color: #667eea;
        }

        .controls-container select,
        .controls-container input[type="text"] {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: 1px solid #cbd5e0;
            background-color: #f7fafc;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .booking-header {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .booking-details {
                grid-template-columns: 1fr;
            }
            .controls-container {
                justify-content: center; /* Center controls on small screens */
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚂 Railway Reservation System</h1>
            <p>Welcome back, <%= user.getFirstName() %>! Here are your bookings</p>
        </div>

        <div class="nav">
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="searchTrains">Search Trains</a></li>
                <li><a href="myBookings.jsp">My Bookings</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>

        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; flex-wrap: wrap;">
                <h2>📋 My Bookings</h2>
                <div style="display: flex; gap: 0.5rem;">
                    <a href="searchTrains" class="btn btn-primary">🎫 Book New Ticket</a>
                </div>
            </div>

            <% if (bookings != null && !bookings.isEmpty()) { %>
                <div style="margin-bottom: 1rem;">
                    <p><strong>Total Bookings:</strong> <span id="total-bookings"><%= bookings.size() %></span></p>
                    <p style="font-size: 0.9rem; color: #666;">
                        <strong>Current Date:</strong> <%= java.time.LocalDate.now() %>
                    </p>
                </div>

                <div class="controls-container">
                    <div style="display: flex; gap: 0.5rem;">
                        <button class="status-btn active" onclick="filterBookings('all')">All</button>
                        <button class="status-btn" onclick="filterBookings('CONFIRMED')">Confirmed</button>
                        <button class="status-btn" onclick="filterBookings('CANCELLED')">Cancelled</button>
                    </div>
                    <select onchange="sortBookings(this.value)">
                        <option value="">Sort By...</option>
                        <option value="date">Journey Date</option>
                        <option value="amount">Total Fare</option>
                        <option value="train">Train Name</option>
                    </select>
                    <input type="text" id="search-bookings" onkeyup="searchBookings()" placeholder="Search Train/Booking ID...">
                </div>

                <div class="bookings-grid">
                <% for (Booking booking : bookings) {
                    Train train = trainDAO.getTrainById(booking.getTrainId());
                    // Provide default values if train is null to prevent NullPointerException for data attributes
                    String trainName = (train != null) ? train.getTrainName() : "Unknown Train";
                    String journeyDate = (booking.getJourneyDate() != null) ? booking.getJourneyDate().toString() : "";
                %>
                    <div class="booking-card"
                         data-booking-id="<%= booking.getBookingId() %>"
                         data-status="<%= booking.getStatus() %>"
                         data-amount="<%= booking.getTotalFare() %>"
                         data-journey-date="<%= journeyDate %>"
                         data-train-name="<%= trainName %>">
                        <div class="booking-header">
                            <div class="booking-id">
                                🎫 Booking #<%= booking.getBookingId() %>
                            </div>
                            <div class="booking-status <%= booking.getStatus().equals("CONFIRMED") ? "status-confirmed" : "status-cancelled" %>">
                                <%= booking.getStatus() %>
                            </div>
                        </div>

                        <% if (train != null) { %>
                            <div style="background: rgba(72, 187, 120, 0.1); padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                                <h4 style="color: #38a169; margin-bottom: 0.5rem;">🚆 Train Details</h4>
                                <div style="display: flex; justify-content: space-between; flex-wrap: wrap; gap: 1rem;">
                                    <div>
                                        <strong><%= train.getTrainName() %></strong>
                                        (<%= train.getTrainNumber() %>)
                                    </div>
                                    <div>
                                        <strong><%= train.getSource() %></strong> → <strong><%= train.getDestination() %></strong>
                                    </div>
                                    <div>
                                        <strong>Departure:</strong> <%= train.getDepartureTime() %>
                                    </div>
                                </div>
                            </div>
                        <% } %>

                        <div class="booking-details">
                            <div class="detail-group">
                                <div class="detail-label">Journey Date</div>
                                <div class="detail-value">📅 <%= booking.getJourneyDate() %></div>
                            </div>

                            <div class="detail-group">
                                <div class="detail-label">Passengers</div>
                                <div class="detail-value">👥 <%= booking.getNumberOfPassengers() %> Person(s)</div>
                            </div>

                            <div class="detail-group">
                                <div class="detail-label">Total Fare</div>
                                <div class="detail-value">💰 ₹<%= String.format("%.2f", booking.getTotalFare()) %></div>
                            </div>

                            <div class="detail-group">
                                <div class="detail-label">Booking Date</div>
                                <div class="detail-value">📝 <%= booking.getBookingDateTime().toLocalDate() %></div>
                            </div>
                        </div>

                        <div style="background: rgba(102, 126, 234, 0.1); padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                            <h5 style="color: #667eea; margin-bottom: 0.5rem;">👤 Passenger Names</h5>
                            <p style="margin: 0; color: #4a5568;"><%= booking.getPassengerNames() %></p>
                        </div>

                        <% if (booking.getSeatNumbers() != null && !booking.getSeatNumbers().isEmpty()) { %>
                            <div style="background: rgba(245, 101, 101, 0.1); padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                                <h5 style="color: #e53e3e; margin-bottom: 0.5rem;">🪑 Seat Numbers</h5>
                                <p style="margin: 0; color: #4a5568; font-weight: 600;"><%= booking.getSeatNumbers() %></p>
                            </div>
                        <% } %>

                        <div style="display: flex; gap: 1rem; justify-content: flex-end; flex-wrap: wrap; margin-top: 1rem;">
                            <% if (booking.getStatus().equals("CONFIRMED")) { %>
                                <button data-booking-id="<%= booking.getBookingId() %>" class="btn btn-secondary print-booking-btn">
                                    🖨 Print Ticket
                                </button>
                                <button data-booking-id="<%= booking.getBookingId() %>" class="btn btn-secondary copy-booking-btn">
                                    📋 Copy Details
                                </button>
                                <% if (booking.getJourneyDate().isAfter(java.time.LocalDate.now())) { %>
                                    <button data-booking-id="<%= booking.getBookingId() %>" class="btn btn-danger cancel-booking-btn">
                                        ❌ Cancel Booking
                                    </button>
                                <% } %>
                            <% } else { %>
                                <span style="color: #742a2a; font-style: italic;">This booking has been cancelled</span>
                            <% } %>
                        </div>
                    </div>
                <% } %>
                </div> <%-- End of .bookings-grid --%>

                <div style="background: rgba(102, 126, 234, 0.1); padding: 1.5rem; border-radius: 10px; margin-top: 2rem;">
                    <h3 style="color: #667eea; margin-bottom: 1rem;">📊 Booking Summary</h3>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div style="text-align: center;">
                            <div style="font-size: 2rem; font-weight: bold; color: #667eea;" id="total-bookings-summary"></div>
                            <div style="color: #718096;">Total Bookings</div>
                        </div>
                        <div style="text-align: center;">
                            <div style="font-size: 2rem; font-weight: bold; color: #48bb78;" id="confirmed-bookings-summary"></div>
                            <div style="color: #718096;">Confirmed</div>
                        </div>
                        <div style="text-align: center;">
                            <div style="font-size: 2rem; font-weight: bold; color: #f56565;" id="cancelled-bookings-summary"></div>
                            <div style="color: #718096;">Cancelled</div>
                        </div>
                        <div style="text-align: center;">
                            <div style="font-size: 2rem; font-weight: bold; color: #38a169;">₹<span id="total-amount-summary"></span></div>
                            <div style="color: #718096;">Total Spent</div>
                        </div>
                    </div>
                </div>

            <% } else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">🎫</div>
                    <h3 style="color: #4a5568; margin-bottom: 1rem;">No Bookings Yet</h3>
                    <p style="margin-bottom: 2rem;">You haven't made any train bookings yet. Start your journey by booking your first ticket!</p>
                    <a href="searchTrains" class="btn btn-primary">🔍 Search & Book Trains</a>
                </div>
            <% } %>

            <div style="background: rgba(245, 101, 101, 0.1); padding: 1.5rem; border-radius: 10px; margin-top: 2rem;">
                <h4 style="color: #e53e3e; margin-bottom: 1rem;">📞 Need Help?</h4>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem;">
                    <div>
                        <h5 style="color: #4a5568;">Booking Issues</h5>
                        <p style="color: #718096; margin: 0;">Contact support for booking modifications or cancellations</p>
                    </div>
                    <div>
                        <h5 style="color: #4a5568;">Travel Information</h5>
                        <p style="color: #718096; margin: 0;">Get real-time train status and platform details</p>
                    </div>
                    <div>
                        <h5 style="color: #4a5568;">Customer Support</h5>
                        <p style="color: #718096; margin: 0;">24/7 helpline: 1800-XXX-XXXX</p>
                    </div>
                </div>
            </div>
        </div>

        <footer style="text-align: center; margin-top: 2rem; padding: 1rem; color: rgba(255,255,255,0.8);">
            <p>&copy; 2025 Railway Reservation System. All rights reserved.</p>
        </footer>
    </div>

    <script src="js/script.js"></script>
    <script>
        // DOM Content Loaded Event
        document.addEventListener('DOMContentLoaded', function() {

            // Add event listeners to action buttons
            document.querySelectorAll('.print-booking-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    printBooking(this.getAttribute('data-booking-id'));
                });
            });

            document.querySelectorAll('.copy-booking-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    copyBookingDetails(this.getAttribute('data-booking-id'));
                });
            });

            const cancelButtons = document.querySelectorAll('.cancel-booking-btn');

            cancelButtons.forEach((btn, index) => {

                btn.addEventListener('click', function() {
                    cancelBooking(this.getAttribute('data-booking-id'));
                });
            });

            // Update summary initially
            updateBookingSummary();
        });

        // Filter bookings by status
        function filterBookings(status) {
            const bookingCards = document.querySelectorAll('.booking-card');
            const statusButtons = document.querySelectorAll('.status-btn');

            // Update active status button
            statusButtons.forEach(btn => btn.classList.remove('active'));
            // `event` might not always be available if called directly,
            // safer to pass the element or re-query. For simplicity here, assuming direct call.
            // If calling from HTML, `this` is the button.
            // If called from JS, need to find the button.
            const clickedButton = Array.from(statusButtons).find(btn => btn.textContent.toLowerCase().includes(status.toLowerCase()) || (status === 'all' && btn.textContent.toLowerCase() === 'all'));
            if (clickedButton) {
                clickedButton.classList.add('active');
            }


            // Show/hide booking cards
            bookingCards.forEach(card => {
                if (status === 'all' || card.getAttribute('data-status').toLowerCase() === status.toLowerCase()) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });

            // Update summary after filtering
            updateBookingSummary();
        }

        // Sort bookings
        function sortBookings(criteria) {
            const container = document.querySelector('.bookings-grid');
            if (!container) {
                return;
            }
            const cards = Array.from(container.querySelectorAll('.booking-card:not([style*="none"])')); // Only sort visible cards

            cards.sort((a, b) => {
                let aValue, bValue;

                switch(criteria) {
                    case 'date':
                        aValue = new Date(a.getAttribute('data-journey-date'));
                        bValue = new Date(b.getAttribute('data-journey-date'));
                        return bValue - aValue; // Most recent first
                    case 'amount':
                        aValue = parseFloat(a.getAttribute('data-amount'));
                        bValue = parseFloat(b.getAttribute('data-amount'));
                        return bValue - aValue; // Highest first
                    case 'train':
                        aValue = a.getAttribute('data-train-name').toLowerCase();
                        bValue = b.getAttribute('data-train-name').toLowerCase();
                        return aValue.localeCompare(bValue);
                    default:
                        return 0;
                }
            });

            // Re-append sorted cards
            cards.forEach(card => container.appendChild(card));
        }

        // Update booking summary
        function updateBookingSummary() {
            const visibleCards = document.querySelectorAll('.booking-card[style*="block"], .booking-card:not([style*="none"])');
            const totalBookings = visibleCards.length;
            let confirmedCount = 0;
            let cancelledCount = 0;
            let totalAmount = 0;

            visibleCards.forEach(card => {
                const status = card.getAttribute('data-status');
                const amount = parseFloat(card.getAttribute('data-amount'));

                if (status === 'CONFIRMED') {
                    confirmedCount++;
                    totalAmount += amount;
                } else if (status === 'CANCELLED') {
                    cancelledCount++;
                }
            });

            // Update summary display if elements exist
            const totalBookingsEl = document.getElementById('total-bookings-summary');
            const confirmedBookingsEl = document.getElementById('confirmed-bookings-summary');
            const cancelledBookingsEl = document.getElementById('cancelled-bookings-summary');
            const totalAmountEl = document.getElementById('total-amount-summary');

            if (totalBookingsEl) totalBookingsEl.textContent = totalBookings;
            if (confirmedBookingsEl) confirmedBookingsEl.textContent = confirmedCount;
            if (cancelledBookingsEl) cancelledBookingsEl.textContent = cancelledCount;
            if (totalAmountEl) totalAmountEl.textContent = totalAmount.toFixed(2);
        }

        // Search bookings
        function searchBookings() {
            const searchTerm = document.getElementById('search-bookings').value.toLowerCase();
            const bookingCards = document.querySelectorAll('.booking-card');

            bookingCards.forEach(card => {
                const trainName = card.getAttribute('data-train-name').toLowerCase();
                const bookingId = card.getAttribute('data-booking-id').toLowerCase();

                if (trainName.includes(searchTerm) || bookingId.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });

            updateBookingSummary();
        }

        // Show alert function
        function showAlert(message, type) {
            // Create alert element
            const alertDiv = document.createElement('div');
            alertDiv.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                border-radius: 5px;
                color: white;
                font-weight: bold;
                z-index: 1000;
                animation: slideIn 0.3s ease-out;
                max-width: 300px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            `;

            // Set background color based on type
            switch(type) {
                case 'success':
                    alertDiv.style.backgroundColor = '#48bb78';
                    break;
                case 'error':
                    alertDiv.style.backgroundColor = '#f56565';
                    break;
                case 'info':
                    alertDiv.style.backgroundColor = '#4299e1';
                    break;
                default:
                    alertDiv.style.backgroundColor = '#667eea';
            }

            alertDiv.textContent = message;
            document.body.appendChild(alertDiv);

            // Auto remove after 3 seconds
            setTimeout(() => {
                alertDiv.remove();
            }, 3000);
        }

        function printBooking(bookingId) {
            // Create a printable version of the booking
            const bookingCard = document.querySelector(`[data-booking-id="${bookingId}"]`)?.closest('.booking-card');
            if (bookingCard) {
                const printWindow = window.open('', '_blank');
                printWindow.document.write(`
                    <html>
                    <head>
                        <title>Booking #${bookingId} - E-Ticket</title>
                        <style>
                            body { font-family: Arial, sans-serif; margin: 20px; }
                            .booking-card { border: 2px solid #667eea; padding: 20px; border-radius: 10px; }
                            h3 { color: #667eea; }
                            .detail-group { margin: 10px 0; }
                            .detail-label { font-weight: bold; }
                        </style>
                    </head>
                    <body>
                        <h2>🚂 Railway Reservation System - E-Ticket</h2>
                        ${bookingCard.outerHTML}
                        <p style="margin-top: 20px; font-size: 12px; color: #666;">
                            This is an electronic ticket. Please carry a valid ID proof during travel.
                        </p>
                    </body>
                    </html>
                `);
                printWindow.document.close();
                printWindow.print();
            } else {
                window.print(); // Fallback to print entire page if card not found
            }
        }

        function copyBookingDetails(bookingId) {
            // Corrected querySelector syntax using backticks for template literal
            const bookingCard = document.querySelector(`[data-booking-id="${bookingId}"]`)?.closest('.booking-card');
            if (bookingCard) {
                const text = bookingCard.innerText;
                navigator.clipboard.writeText(text).then(() => {
                    showAlert('Booking details copied to clipboard!', 'success');
                }).catch(() => {
                    showAlert('Failed to copy booking details', 'error');
                });
            }
        }

        function cancelBooking(bookingId) {
            if (confirm('Are you sure you want to cancel this booking? This action cannot be undone.')) {

                // Make AJAX call to cancel the booking
                fetch('CancelBookingServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'bookingId=' + bookingId
                })
                .then(response => {
                    // Check if response is JSON, if not, try to read as text for error debugging
                    const contentType = response.headers.get('content-type');
                    if (contentType && contentType.includes('application/json')) {
                        return response.json();
                    } else {
                        // If not JSON, parse as text and throw error
                        return response.text().then(text => {
                            throw new Error(`Server responded with non-JSON content: ${text}`);
                        });
                    }
                })
                .then(data => {

                    if (data.success) {
                        showAlert('Booking cancelled successfully!', 'success');
                        // Reload the page to show updated status
                        setTimeout(() => {
                            location.reload();
                        }, 1500);
                    } else {
                        showAlert('Error: ' + data.message, 'error');
                    }
                })
                .catch(error => {
                    showAlert('Network error or server issue: ' + error.message, 'error');
                });
            } else {
                console.log('User cancelled the cancellation');
            }
        }
    </script>
</body>
</html>
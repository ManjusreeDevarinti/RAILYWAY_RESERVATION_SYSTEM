package com.railway.servlet;

import com.railway.dao.BookingDAO;
import com.railway.model.User;
import com.railway.util.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

/**
 * Servlet for cancelling bookings
 * Handles AJAX requests to cancel user bookings
 */
@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.bookingDAO = new BookingDAO();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize CancelBookingServlet", e);
        }
    }

    /**
     * Handle POST requests to cancel bookings
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // Get session and check if user is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                out.write("{\"success\": false, \"message\": \"User not logged in\"}");
                return;
            }

            User user = (User) session.getAttribute("user");
            String bookingIdStr = request.getParameter("bookingId");

            // Validate booking ID
            if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
                out.write("{\"success\": false, \"message\": \"Booking ID is required\"}");
                return;
            }

            int bookingId;
            try {
                bookingId = Integer.parseInt(bookingIdStr);
            } catch (NumberFormatException e) {
                out.write("{\"success\": false, \"message\": \"Invalid booking ID format\"}");
                return;
            }

            // Check if booking belongs to the current user and is cancellable
            if (!bookingDAO.isBookingCancellable(bookingId, user.getUserId())) {
                out.write("{\"success\": false, \"message\": \"Booking cannot be cancelled or does not belong to you\"}");
                return;
            }

            // Cancel the booking
            boolean cancelled = bookingDAO.cancelBooking(bookingId);

            if (cancelled) {
                out.write("{\"success\": true, \"message\": \"Booking cancelled successfully\"}");
            } else {
                out.write("{\"success\": false, \"message\": \"Failed to cancel booking. Please try again.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"An error occurred while cancelling the booking\"}");
        } finally {
            out.close();
        }
    }

    /**
     * Handle GET requests - redirect to bookings page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("myBookings.jsp");
    }
}

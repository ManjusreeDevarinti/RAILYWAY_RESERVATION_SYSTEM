package com.railway.servlet;

import com.railway.dao.BookingDAO;
import com.railway.dao.TrainDAO;
import com.railway.model.Booking;
import com.railway.model.Train;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private TrainDAO trainDAO;
    
    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
        trainDAO = new TrainDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String trainIdStr = request.getParameter("trainId");
        if (trainIdStr != null) {
            try {
                int trainId = Integer.parseInt(trainIdStr);
                Train train = trainDAO.getTrainById(trainId);
                if (train != null) {
                    request.setAttribute("train", train);
                    request.getRequestDispatcher("booking.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid train ID
            }
        }
        
        response.sendRedirect("searchTrains");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int userId = (Integer) session.getAttribute("userId");
            int trainId = Integer.parseInt(request.getParameter("trainId"));
            LocalDate journeyDate = LocalDate.parse(request.getParameter("journeyDate"));
            int numberOfPassengers = Integer.parseInt(request.getParameter("numberOfPassengers"));
            String passengerNames = request.getParameter("passengerNames");
            
            // Validate journey date
            if (journeyDate.isBefore(LocalDate.now())) {
                request.setAttribute("error", "Journey date cannot be in the past");
                Train train = trainDAO.getTrainById(trainId);
                request.setAttribute("train", train);
                request.getRequestDispatcher("booking.jsp").forward(request, response);
                return;
            }
            
            Train train = trainDAO.getTrainById(trainId);
            if (train == null) {
                request.setAttribute("error", "Train not found");
                response.sendRedirect("searchTrains");
                return;
            }
            
            if (train.getAvailableSeats() < numberOfPassengers) {
                request.setAttribute("error", "Not enough seats available");
                request.setAttribute("train", train);
                request.getRequestDispatcher("booking.jsp").forward(request, response);
                return;
            }
            
            double totalFare = train.getFare() * numberOfPassengers;
            
            Booking booking = new Booking(userId, trainId, journeyDate, numberOfPassengers);
            booking.setTotalFare(totalFare);
            booking.setPassengerNames(passengerNames);
            booking.setSeatNumbers(generateSeatNumbers(numberOfPassengers));
            
            if (bookingDAO.createBooking(booking) && trainDAO.updateAvailableSeats(trainId, numberOfPassengers)) {
                request.setAttribute("success", "Booking confirmed successfully!");
                request.setAttribute("booking", booking);
                request.setAttribute("train", train);
                request.getRequestDispatcher("bookingConfirmation.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Booking failed. Please try again.");
                request.setAttribute("train", train);
                request.getRequestDispatcher("booking.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check your details.");
            response.sendRedirect("searchTrains");
        }
    }
    
    private String generateSeatNumbers(int numberOfPassengers) {
        StringBuilder seatNumbers = new StringBuilder();
        int startSeat = (int) (Math.random() * 50) + 1;
        
        for (int i = 0; i < numberOfPassengers; i++) {
            if (i > 0) seatNumbers.append(", ");
            seatNumbers.append("S").append(startSeat + i);
        }
        
        return seatNumbers.toString();
    }
}

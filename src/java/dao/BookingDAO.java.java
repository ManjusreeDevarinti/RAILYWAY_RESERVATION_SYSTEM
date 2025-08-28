package com.railway.dao;

import com.railway.model.Booking;
import com.railway.util.DatabaseConnection;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public boolean createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, train_id, journey_date, number_of_passengers, " +
                "total_fare, status, booking_date_time, passenger_names, seat_numbers) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, booking.getUserId());
            statement.setInt(2, booking.getTrainId());
            statement.setDate(3, Date.valueOf(booking.getJourneyDate()));
            statement.setInt(4, booking.getNumberOfPassengers());
            statement.setDouble(5, booking.getTotalFare());
            statement.setString(6, booking.getStatus());
            statement.setTimestamp(7, Timestamp.valueOf(booking.getBookingDateTime()));
            statement.setString(8, booking.getPassengerNames());
            statement.setString(9, booking.getSeatNumbers());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    booking.setBookingId(generatedKeys.getInt(1));
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT booking_id, user_id, train_id, journey_date, number_of_passengers, " +
                "total_fare, status, booking_date_time, passenger_names, seat_numbers " +
                "FROM bookings WHERE user_id = ? ORDER BY booking_date_time DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Booking booking = new Booking();
                booking.setBookingId(resultSet.getInt("booking_id"));
                booking.setUserId(resultSet.getInt("user_id"));
                booking.setTrainId(resultSet.getInt("train_id"));
                booking.setJourneyDate(resultSet.getDate("journey_date").toLocalDate());
                booking.setNumberOfPassengers(resultSet.getInt("number_of_passengers"));
                booking.setTotalFare(resultSet.getDouble("total_fare"));
                booking.setStatus(resultSet.getString("status"));
                booking.setBookingDateTime(resultSet.getTimestamp("booking_date_time").toLocalDateTime());
                booking.setPassengerNames(resultSet.getString("passenger_names"));
                booking.setSeatNumbers(resultSet.getString("seat_numbers"));
                bookings.add(booking);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public Booking getBookingById(int bookingId) {
        String sql = "SELECT booking_id, user_id, train_id, journey_date, number_of_passengers, " +
                "total_fare, status, booking_date_time, passenger_names, seat_numbers " +
                "FROM bookings WHERE booking_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Booking booking = new Booking();
                booking.setBookingId(resultSet.getInt("booking_id"));
                booking.setUserId(resultSet.getInt("user_id"));
                booking.setTrainId(resultSet.getInt("train_id"));
                booking.setJourneyDate(resultSet.getDate("journey_date").toLocalDate());
                booking.setNumberOfPassengers(resultSet.getInt("number_of_passengers"));
                booking.setTotalFare(resultSet.getDouble("total_fare"));
                booking.setStatus(resultSet.getString("status"));
                booking.setBookingDateTime(resultSet.getTimestamp("booking_date_time").toLocalDateTime());
                booking.setPassengerNames(resultSet.getString("passenger_names"));
                booking.setSeatNumbers(resultSet.getString("seat_numbers"));
                return booking;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean cancelBooking(int bookingId) {
        String sql = "UPDATE bookings SET status = 'CANCELLED' WHERE booking_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);
            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean isBookingCancellable(int bookingId, int userId) {
        String sql = "SELECT status, journey_date FROM bookings WHERE booking_id = ? AND user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);
            statement.setInt(2, userId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String status = resultSet.getString("status");
                LocalDate journeyDate = resultSet.getDate("journey_date").toLocalDate();

                // Booking is cancellable if it's confirmed and journey date is in the future
                return "CONFIRMED".equals(status) && journeyDate.isAfter(LocalDate.now());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
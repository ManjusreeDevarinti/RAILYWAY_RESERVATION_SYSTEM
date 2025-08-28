package com.railway.dao;

import com.railway.model.Train;
import com.railway.util.DatabaseConnection;
import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class TrainDAO {
    
    public List<Train> searchTrains(String source, String destination) {
        List<Train> trains = new ArrayList<>();
        String sql = "SELECT train_id, train_number, train_name, source, destination, " +
                    "departure_time, arrival_time, total_seats, available_seats, fare, train_type " +
                    "FROM trains WHERE source = ? AND destination = ? AND available_seats > 0";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, source);
            statement.setString(2, destination);
            
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Train train = new Train();
                train.setTrainId(resultSet.getInt("train_id"));
                train.setTrainNumber(resultSet.getString("train_number"));
                train.setTrainName(resultSet.getString("train_name"));
                train.setSource(resultSet.getString("source"));
                train.setDestination(resultSet.getString("destination"));
                train.setDepartureTime(resultSet.getTime("departure_time").toLocalTime());
                train.setArrivalTime(resultSet.getTime("arrival_time").toLocalTime());
                train.setTotalSeats(resultSet.getInt("total_seats"));
                train.setAvailableSeats(resultSet.getInt("available_seats"));
                train.setFare(resultSet.getDouble("fare"));
                train.setTrainType(resultSet.getString("train_type"));
                trains.add(train);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return trains;
    }
    
    public Train getTrainById(int trainId) {
        String sql = "SELECT train_id, train_number, train_name, source, destination, " +
                    "departure_time, arrival_time, total_seats, available_seats, fare, train_type " +
                    "FROM trains WHERE train_id = ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, trainId);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                Train train = new Train();
                train.setTrainId(resultSet.getInt("train_id"));
                train.setTrainNumber(resultSet.getString("train_number"));
                train.setTrainName(resultSet.getString("train_name"));
                train.setSource(resultSet.getString("source"));
                train.setDestination(resultSet.getString("destination"));
                train.setDepartureTime(resultSet.getTime("departure_time").toLocalTime());
                train.setArrivalTime(resultSet.getTime("arrival_time").toLocalTime());
                train.setTotalSeats(resultSet.getInt("total_seats"));
                train.setAvailableSeats(resultSet.getInt("available_seats"));
                train.setFare(resultSet.getDouble("fare"));
                train.setTrainType(resultSet.getString("train_type"));
                return train;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean updateAvailableSeats(int trainId, int seatsToBook) {
        String sql = "UPDATE trains SET available_seats = available_seats - ? WHERE train_id = ? AND available_seats >= ?";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, seatsToBook);
            statement.setInt(2, trainId);
            statement.setInt(3, seatsToBook);
            
            return statement.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public List<String> getAllStations() {
        List<String> stations = new ArrayList<>();
        String sql = "SELECT DISTINCT source FROM trains UNION SELECT DISTINCT destination FROM trains ORDER BY source";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                stations.add(resultSet.getString("source"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stations;
    }
}

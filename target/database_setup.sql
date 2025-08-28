-- Railway Reservation System Database Setup
-- Execute these SQL commands in MySQL to set up the database

-- Create Database
CREATE DATABASE IF NOT EXISTS railway_reservation;
USE railway_reservation;

-- Create Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Trains Table
CREATE TABLE trains (
    train_id INT AUTO_INCREMENT PRIMARY KEY,
    train_number VARCHAR(10) UNIQUE NOT NULL,
    train_name VARCHAR(100) NOT NULL,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    total_seats INT NOT NULL DEFAULT 100,
    available_seats INT NOT NULL DEFAULT 100,
    fare DECIMAL(10, 2) NOT NULL,
    train_type VARCHAR(20) NOT NULL DEFAULT 'Express',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Bookings Table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    train_id INT NOT NULL,
    journey_date DATE NOT NULL,
    number_of_passengers INT NOT NULL,
    total_fare DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'CONFIRMED',
    booking_date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    passenger_names TEXT NOT NULL,
    seat_numbers VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (train_id) REFERENCES trains(train_id) ON DELETE CASCADE
);

-- Insert Sample Users
INSERT INTO users (username, email, password, first_name, last_name, phone, address) VALUES
('admin', 'admin@railway.com', 'admin123', 'Admin', 'User', '9876543210', 'Railway Head Office, New Delhi'),
('john_doe', 'john@example.com', 'password123', 'John', 'Doe', '9876543211', '123 Main St, Mumbai'),
('jane_smith', 'jane@example.com', 'password123', 'Jane', 'Smith', '9876543212', '456 Oak Ave, Delhi');

-- Insert Sample Trains
INSERT INTO trains (train_number, train_name, source, destination, departure_time, arrival_time, total_seats, available_seats, fare, train_type) VALUES
('12951', 'Mumbai Rajdhani Express', 'Delhi', 'Mumbai', '16:55:00', '08:35:00', 120, 95, 2850.00, 'Rajdhani'),
('12301', 'Howrah Rajdhani Express', 'Delhi', 'Kolkata', '17:00:00', '10:05:00', 120, 87, 2650.00, 'Rajdhani'),
('12621', 'Tamil Nadu Express', 'Delhi', 'Chennai', '22:30:00', '07:40:00', 150, 112, 1890.00, 'Express'),
('12723', 'Telangana Express', 'Delhi', 'Hyderabad', '20:15:00', '14:50:00', 140, 98, 1750.00, 'Express'),
('12925', 'Paschim Express', 'Delhi', 'Mumbai', '15:20:00', '14:05:00', 180, 145, 1250.00, 'Express'),
('12001', 'Bhopal Shatabdi Express', 'Delhi', 'Bhopal', '06:00:00', '14:00:00', 100, 70, 1500.00, 'Shatabdi'),
('12011', 'Kalka Shatabdi Express', 'Delhi', 'Kalka', '07:40:00', '11:45:00', 90, 65, 950.00, 'Shatabdi'),
('12423', 'Dibrugarh Rajdhani Express', 'Delhi', 'Dibrugarh', '16:10:00', '05:30:00', 110, 80, 4100.00, 'Rajdhani'),
('12809', 'Howrah Mail', 'Mumbai', 'Howrah', '21:10:00', '06:00:00', 200, 160, 2100.00, 'Mail'),
('12137', 'Punjab Mail', 'Mumbai', 'Firozpur Cantt', '19:40:00', '05:00:00', 190, 130, 1950.00, 'Mail'),
('12413', 'Pooja Express', 'Ajmer', 'Delhi', '14:10:00', '21:00:00', 160, 120, 800.00, 'Express'),
('12403', 'Prayagraj Express', 'Allahabad', 'Delhi', '21:30:00', '06:00:00', 170, 110, 1050.00, 'Express'),
('12555', 'Gorakhdham Express', 'Gorakhpur', 'Delhi', '20:50:00', '07:00:00', 160, 100, 980.00, 'Express'),
('12440', 'Goa Express', 'Goa', 'Delhi', '11:00:00', '18:30:00', 180, 135, 2300.00, 'Express'),
('12656', 'Navjeevan Express', 'Ahmedabad', 'Chennai', '09:40:00', '18:45:00', 150, 90, 2200.00, 'Express'),
('12834', 'Howrah Hapa Superfast Express', 'Howrah', 'Hapa', '17:40:00', '03:10:00', 130, 75, 2900.00, 'Superfast'),
('12618', 'Mangala Lakshadweep Express', 'Ernakulam', 'Hazrat Nizamuddin', '10:50:00', '13:00:00', 160, 105, 3100.00, 'Express'),
('12704', 'Falaknuma Express', 'Secunderabad', 'Howrah', '15:55:00', '17:40:00', 140, 90, 2500.00, 'Express'),
('12903', 'Golden Temple Mail', 'Mumbai', 'Amritsar', '18:40:00', '05:00:00', 200, 150, 2050.00, 'Mail'),
('12140', 'Nagpur Sewagram Express', 'Nagpur', 'Mumbai', '07:20:00', '21:00:00', 130, 88, 1100.00, 'Express'),
('12391', 'Shramjeevi Express', 'Rajgir', 'Delhi', '12:00:00', '09:00:00', 150, 100, 1150.00, 'Express'),
('12414', 'Jammu Rajdhani Express', 'Jammu Tawi', 'Delhi', '19:40:00', '05:00:00', 100, 60, 2100.00, 'Rajdhani'),
('12029', 'Amritsar Shatabdi Express', 'Delhi', 'Amritsar', '06:45:00', '13:30:00', 90, 55, 1100.00, 'Shatabdi'),
('12901', 'Gujarat Mail', 'Ahmedabad', 'Mumbai', '22:00:00', '06:10:00', 170, 125, 850.00, 'Mail'),
('12322', 'Mumbai Mail', 'Mumbai', 'Kolkata', '22:15:00', '11:30:00', 190, 140, 2000.00, 'Mail'),
('12601', 'Mangaluru Mail', 'Chennai', 'Mangaluru', '20:10:00', '10:00:00', 150, 108, 1550.00, 'Mail'),
('12716', 'Sachkhand Express', 'Amritsar', 'Hazrat Nizamuddin', '05:30:00', '14:00:00', 160, 115, 1000.00, 'Express'),
('12859', 'Gitanjali Express', 'Howrah', 'Mumbai', '13:50:00', '21:20:00', 180, 130, 2350.00, 'Express'),
('12164', 'Mumbai LTT - Chennai Express', 'Mumbai', 'Chennai', '18:40:00', '15:30:00', 140, 92, 1900.00, 'Express'),
('12918', 'Gujarat Sampark Kranti Express', 'Delhi', 'Ahmedabad', '13:55:00', '04:00:00', 120, 78, 1600.00, 'Sampark Kranti');
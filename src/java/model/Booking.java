package com.railway.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Booking {
    private int bookingId;
    private int userId;
    private int trainId;
    private LocalDate journeyDate;
    private int numberOfPassengers;
    private double totalFare;
    private String status;
    private LocalDateTime bookingDateTime;
    private String passengerNames;
    private String seatNumbers;
    
    // Default constructor
    public Booking() {}
    
    // Constructor with essential parameters
    public Booking(int userId, int trainId, LocalDate journeyDate, int numberOfPassengers) {
        this.userId = userId;
        this.trainId = trainId;
        this.journeyDate = journeyDate;
        this.numberOfPassengers = numberOfPassengers;
        this.bookingDateTime = LocalDateTime.now();
        this.status = "CONFIRMED";
    }
    
    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getTrainId() {
        return trainId;
    }
    
    public void setTrainId(int trainId) {
        this.trainId = trainId;
    }
    
    public LocalDate getJourneyDate() {
        return journeyDate;
    }
    
    public void setJourneyDate(LocalDate journeyDate) {
        this.journeyDate = journeyDate;
    }
    
    public int getNumberOfPassengers() {
        return numberOfPassengers;
    }
    
    public void setNumberOfPassengers(int numberOfPassengers) {
        this.numberOfPassengers = numberOfPassengers;
    }
    
    public double getTotalFare() {
        return totalFare;
    }
    
    public void setTotalFare(double totalFare) {
        this.totalFare = totalFare;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public LocalDateTime getBookingDateTime() {
        return bookingDateTime;
    }
    
    public void setBookingDateTime(LocalDateTime bookingDateTime) {
        this.bookingDateTime = bookingDateTime;
    }
    
    public String getPassengerNames() {
        return passengerNames;
    }
    
    public void setPassengerNames(String passengerNames) {
        this.passengerNames = passengerNames;
    }
    
    public String getSeatNumbers() {
        return seatNumbers;
    }
    
    public void setSeatNumbers(String seatNumbers) {
        this.seatNumbers = seatNumbers;
    }
}

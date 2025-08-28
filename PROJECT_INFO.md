# Railway Reservation System Configuration

## Project Information

- **Project Name:** Railway Reservation System
- **Version:** 1.0.0
- **Type:** Web Application (JSP/Servlet)
- **Purpose:** College Mini Project

## Technology Stack

- **Backend:** Java 8+, JSP, Servlets
- **Frontend:** HTML5, CSS3, JavaScript
- **Database:** MySQL 8.0+
- **Server:** Apache Tomcat 9.0+
- **IDE:** IntelliJ IDEA (recommended)

## Database Configuration

- **Database Name:** railway_reservation
- **Default Username:** root
- **Default Password:** (update in DatabaseConnection.java)
- **Default URL:** jdbc:mysql://localhost:3306/railway_reservation

## Server Configuration

- **Default Port:** 8080
- **Context Path:** /railway
- **Session Timeout:** 30 minutes

## Important Files

- **Database Schema:** src/main/resources/database_setup.sql
- **Configuration:** src/main/webapp/WEB-INF/web.xml
- **Styles:** src/main/webapp/css/style.css
- **Scripts:** src/main/webapp/js/script.js

## Default Test Accounts

- john_doe / password123
- jane_smith / password123
- admin / admin123

## Features Implemented

- ✅ User Registration & Login
- ✅ Train Search & Display
- ✅ Ticket Booking
- ✅ Booking Confirmation
- ✅ Responsive Design
- ✅ Input Validation
- ✅ Session Management
- ✅ Database Integration

## Development Status

- **Core Features:** Complete
- **UI/UX:** Complete
- **Database:** Complete
- **Testing:** Basic testing done
- **Documentation:** Complete

## Deployment Notes

1. Ensure MySQL service is running
2. Create database and tables using setup script
3. Update database credentials if needed
4. Deploy to Tomcat server
5. Access via http://localhost:8080/railway

## Educational Objectives Met

- MVC Architecture Implementation
- Database Integration with JDBC
- Session Management
- Input Validation
- Responsive Web Design
- Modern JavaScript Usage
- Error Handling
- Code Organization

This project demonstrates fundamental concepts of Java web development and can be used as a foundation for more advanced features.

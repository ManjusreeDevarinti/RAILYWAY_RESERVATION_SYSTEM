# Railway Reservation System

A comprehensive web-based railway reservation system built using Java, JSP, Servlets, MySQL, HTML, CSS, and JavaScript. This project follows the MVC architecture pattern and is designed for educational purposes.

## Features

### User Features

- **User Registration & Authentication**: Secure user registration and login system
- **Train Search**: Search trains between any two stations
- **Ticket Booking**: Book tickets with passenger details
- **Booking Management**: View and manage bookings
- **E-Ticket Generation**: Digital ticket with booking confirmation
- **Responsive Design**: Mobile-friendly interface

### Technical Features

- **MVC Architecture**: Clean separation of concerns
- **Database Integration**: MySQL database with proper indexing
- **Session Management**: Secure user session handling
- **Input Validation**: Client-side and server-side validation
- **Error Handling**: Comprehensive error management
- **Modern UI/UX**: Beautiful gradient-based design

## Technology Stack

- **Backend**: Java (JDK 8+), JSP, Servlets
- **Frontend**: HTML5, CSS3, JavaScript (ES6)
- **Database**: MySQL 8.0+
- **Server**: Apache Tomcat 9.0+
- **IDE**: IntelliJ IDEA (recommended)
- **Build Tool**: Maven (optional)

## Project Structure

```
rr-pro/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── railway/
│       │           ├── dao/           # Data Access Objects
│       │           │   ├── UserDAO.java
│       │           │   ├── TrainDAO.java
│       │           │   └── BookingDAO.java
│       │           ├── model/         # Model Classes
│       │           │   ├── User.java
│       │           │   ├── Train.java
│       │           │   └── Booking.java
│       │           ├── servlet/       # Servlet Controllers
│       │           │   ├── LoginServlet.java
│       │           │   ├── RegisterServlet.java
│       │           │   ├── TrainSearchServlet.java
│       │           │   ├── BookingServlet.java
│       │           │   └── LogoutServlet.java
│       │           └── util/          # Utility Classes
│       │               └── DatabaseConnection.java
│       ├── webapp/
│       │   ├── WEB-INF/
│       │   │   └── web.xml           # Web application configuration
│       │   ├── css/
│       │   │   └── style.css         # Stylesheet
│       │   ├── js/
│       │   │   └── script.js         # JavaScript functions
│       │   ├── images/               # Image assets
│       │   ├── index.jsp             # Home page
│       │   ├── login.jsp             # Login page
│       │   ├── register.jsp          # Registration page
│       │   ├── dashboard.jsp         # User dashboard
│       │   ├── search.jsp            # Train search page
│       │   ├── booking.jsp           # Booking form
│       │   └── bookingConfirmation.jsp # Booking confirmation
│       └── resources/
│           └── database_setup.sql    # Database schema and sample data
└── lib/                              # External libraries (JDBC driver)
```

## Setup Instructions

### Prerequisites

1. **Java Development Kit (JDK) 8 or higher**
2. **Apache Tomcat 9.0 or higher**
3. **MySQL 8.0 or higher**
4. **IntelliJ IDEA** (recommended) or any Java IDE
5. **MySQL JDBC Driver** (mysql-connector-java-8.0.33.jar)

### Database Setup

1. Install and start MySQL server
2. Create a new database named `railway_reservation`
3. Execute the SQL script from `src/main/resources/database_setup.sql`
4. Update database credentials in `DatabaseConnection.java` if needed

### Project Setup in IntelliJ IDEA

1. **Import Project**:

   - Open IntelliJ IDEA
   - File → Open → Select the `rr-pro` folder
   - Configure as a Web Application project

2. **Configure Tomcat Server**:

   - Run → Edit Configurations → Add New → Tomcat Server → Local
   - Set Tomcat installation directory
   - In Deployment tab, add Artifact (Web Application Exploded)
   - Set Application Context to `/railway` or `/`

3. **Add MySQL JDBC Driver**:

   - Download MySQL Connector/J from MySQL website
   - Copy `mysql-connector-java-8.0.33.jar` to `lib/` folder
   - Add to project classpath: File → Project Structure → Libraries → Add

4. **Configure Project Structure**:
   - File → Project Structure
   - Set Project SDK to your JDK
   - Set Modules → Sources to mark `src/main/java` as Sources
   - Mark `src/main/webapp` as Web Resource Directory

### Running the Application

1. Start MySQL service
2. Deploy and run the project on Tomcat server
3. Access the application at: `http://localhost:8080/railway` (or your configured path)

## Database Schema

### Users Table

- `user_id` (Primary Key)
- `username` (Unique)
- `email` (Unique)
- `password`
- `first_name`, `last_name`
- `phone`, `address`
- `created_at`, `updated_at`

### Trains Table

- `train_id` (Primary Key)
- `train_number` (Unique)
- `train_name`
- `source`, `destination`
- `departure_time`, `arrival_time`
- `total_seats`, `available_seats`
- `fare`, `train_type`

### Bookings Table

- `booking_id` (Primary Key)
- `user_id` (Foreign Key)
- `train_id` (Foreign Key)
- `journey_date`
- `number_of_passengers`
- `total_fare`, `status`
- `passenger_names`, `seat_numbers`
- `booking_date_time`

## Default Login Credentials

**Sample Users** (for testing):

- Username: `john_doe`, Password: `password123`
- Username: `jane_smith`, Password: `password123`
- Username: `admin`, Password: `admin123`

## Key Features Implementation

### Security Features

- Input validation and sanitization
- SQL injection prevention using PreparedStatements
- Session management for user authentication
- Password validation (can be enhanced with hashing)

### User Experience

- Responsive design for mobile and desktop
- Real-time form validation
- Interactive booking process
- Print-friendly e-tickets
- Loading indicators and user feedback

### Database Features

- Optimized queries with indexes
- Foreign key constraints
- Sample data for testing
- Scalable schema design

## Future Enhancements

1. **Security Improvements**:

   - Password hashing (BCrypt)
   - CAPTCHA implementation
   - Two-factor authentication

2. **Payment Integration**:

   - Payment gateway integration
   - Transaction management
   - Refund processing

3. **Advanced Features**:

   - Seat selection interface
   - Train status tracking
   - Email notifications
   - PDF ticket generation
   - Admin panel for train management

4. **Performance Optimization**:
   - Connection pooling
   - Caching mechanisms
   - Query optimization

## Troubleshooting

### Common Issues

1. **Database Connection Error**:

   - Check MySQL service is running
   - Verify credentials in `DatabaseConnection.java`
   - Ensure JDBC driver is in classpath

2. **Tomcat Deployment Issues**:

   - Check Tomcat configuration
   - Verify web.xml syntax
   - Ensure all dependencies are included

3. **JSP Compilation Errors**:
   - Check JSP syntax
   - Verify import statements
   - Ensure Tomcat supports JSP

### Development Tips

1. **Debugging**:

   - Use IDE debugger with breakpoints
   - Check Tomcat logs for errors
   - Enable detailed error messages

2. **Testing**:
   - Test with sample data provided
   - Verify all user flows
   - Test edge cases and error scenarios

## Contributing

This is an educational project. Feel free to:

- Add new features
- Improve existing functionality
- Enhance UI/UX design
- Optimize performance
- Add comprehensive testing

## License

This project is created for educational purposes. Use it for learning and academic projects.

## Contact

For any questions or issues, please create an issue in the project repository or contact the development team.

---

**Note**: This is a college project designed for learning web development with Java technologies. It demonstrates MVC architecture, database integration, and modern web development practices.

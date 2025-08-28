# Railway Reservation System - Setup Guide

## Quick Start Guide

### 1. Prerequisites Installation

#### Java Development Kit (JDK)

- Download and install JDK 8 or higher from Oracle or OpenJDK
- Set JAVA_HOME environment variable
- Verify installation: `java -version`

#### Apache Tomcat Server

- Download Tomcat 9.0 from https://tomcat.apache.org/
- Extract to a folder (e.g., C:\apache-tomcat-9.0.x)
- Set CATALINA_HOME environment variable

#### MySQL Database

- Download and install MySQL 8.0 from https://dev.mysql.com/downloads/
- Set root password during installation
- Start MySQL service

#### MySQL JDBC Driver

- Download mysql-connector-java-8.0.33.jar from MySQL website
- Place it in the `lib/` folder of this project

### 2. Database Setup

1. **Start MySQL service**
2. **Open MySQL Command Line Client or MySQL Workbench**
3. **Execute the following commands:**

```sql
-- Create Database
CREATE DATABASE railway_reservation;
USE railway_reservation;

-- Create Tables (copy from database_setup.sql file)
-- Execute all CREATE TABLE statements
-- Execute all INSERT statements for sample data
```

4. **Verify database setup:**

```sql
SHOW TABLES;
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM trains;
```

### 3. IntelliJ IDEA Project Setup

#### Step 1: Import Project

1. Open IntelliJ IDEA
2. File → Open
3. Select the `rr-pro` folder
4. Choose "Import project from external model" → Select "Web Application"

#### Step 2: Configure Project Structure

1. File → Project Structure (Ctrl+Alt+Shift+S)
2. **Project Settings:**

   - Project: Set Project SDK to your JDK
   - Set Project language level to 8 or higher

3. **Modules:**

   - Sources: Mark `src/main/java` as Sources
   - Resources: Mark `src/main/resources` as Resources
   - Web: Add Web facet, set Web Resource Directory to `src/main/webapp`

4. **Libraries:**
   - Add → Java → Select `lib/mysql-connector-java-8.0.33.jar`
   - Add → From Maven → Search for `javax.servlet-api` version 4.0.1

#### Step 3: Configure Tomcat Server

1. Run → Edit Configurations
2. Add New Configuration → Tomcat Server → Local
3. **Server Tab:**

   - Set Tomcat installation directory
   - Set HTTP port (default: 8080)
   - Set JRE to your JDK

4. **Deployment Tab:**
   - Add Artifact → Web Application: Exploded
   - Set Application context to `/railway` or `/`

#### Step 4: Update Database Configuration

1. Open `src/main/java/com/railway/util/DatabaseConnection.java`
2. Update database credentials if needed:

```java
private static final String URL = "jdbc:mysql://localhost:3306/railway_reservation";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_mysql_password";
```

### 4. Alternative IDE Setup (Eclipse)

#### Step 1: Import Project

1. File → Import → Existing Projects into Workspace
2. Select root directory: `rr-pro`
3. Right-click project → Properties

#### Step 2: Configure Build Path

1. Java Build Path → Libraries → Add External JARs
2. Add `mysql-connector-java-8.0.33.jar`
3. Add Servlet API library

#### Step 3: Configure Server

1. Right-click project → Properties → Project Facets
2. Enable Java and Web facets
3. Configure Tomcat server in Servers view

### 5. Running the Application

#### Method 1: IntelliJ IDEA

1. Click the green Run button or press Shift+F10
2. IntelliJ will start Tomcat and deploy the application
3. Open browser to `http://localhost:8080/railway`

#### Method 2: Manual Deployment

1. Build the project (Build → Build Project)
2. Copy the generated WAR file to Tomcat's `webapps` folder
3. Start Tomcat server
4. Access `http://localhost:8080/railway`

### 6. Testing the Application

#### Default Login Credentials

- **Username:** `john_doe`, **Password:** `password123`
- **Username:** `jane_smith`, **Password:** `password123`
- **Username:** `admin`, **Password:** `admin123`

#### Test Flow

1. **Home Page:** `http://localhost:8080/railway`
2. **Register:** Create a new account
3. **Login:** Use sample credentials
4. **Search Trains:** Search between Delhi and Mumbai
5. **Book Ticket:** Complete a booking
6. **View Confirmation:** Check e-ticket

### 7. Project Structure Verification

Ensure your project structure looks like this:

```
rr-pro/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/railway/
│       │       ├── dao/
│       │       ├── model/
│       │       ├── servlet/
│       │       └── util/
│       ├── webapp/
│       │   ├── WEB-INF/web.xml
│       │   ├── css/style.css
│       │   ├── js/script.js
│       │   └── *.jsp files
│       └── resources/
│           └── database_setup.sql
├── lib/
│   └── mysql-connector-java-8.0.33.jar
└── README.md
```

### 8. Troubleshooting Common Issues

#### Database Connection Issues

```
Error: Unable to connect to database
Solution:
1. Check MySQL service is running
2. Verify credentials in DatabaseConnection.java
3. Ensure database exists and tables are created
```

#### ClassNotFoundException for MySQL Driver

```
Error: com.mysql.cj.jdbc.Driver not found
Solution:
1. Ensure mysql-connector-java-8.0.33.jar is in lib/ folder
2. Add to project classpath
3. Restart server
```

#### JSP Compilation Errors

```
Error: JSP compilation failed
Solution:
1. Check JSP syntax
2. Verify import statements
3. Ensure Servlet API is in classpath
```

#### Server Deployment Issues

```
Error: Application failed to start
Solution:
1. Check web.xml syntax
2. Verify servlet classes are compiled
3. Check Tomcat logs for detailed errors
```

### 9. Development Tips

#### Debugging

- Use IDE debugger with breakpoints
- Check Tomcat console logs
- Enable detailed error logging
- Use browser developer tools

#### Code Organization

- Follow MVC pattern
- Keep database queries in DAO classes
- Validate input on both client and server side
- Use meaningful variable names

#### Best Practices

- Close database connections properly
- Validate user input
- Handle exceptions gracefully
- Use prepared statements to prevent SQL injection

### 10. Next Steps

After successfully running the basic application:

1. **Add More Features:**

   - Admin panel for train management
   - Email notifications
   - Payment gateway integration
   - PDF ticket generation

2. **Enhance Security:**

   - Password hashing
   - CSRF protection
   - Input sanitization
   - Session security

3. **Improve Performance:**

   - Connection pooling
   - Query optimization
   - Caching mechanisms
   - Load balancing

4. **Testing:**
   - Unit tests for DAO classes
   - Integration tests for servlets
   - UI testing with Selenium
   - Load testing

### Support

If you encounter any issues:

1. Check the troubleshooting section above
2. Verify all prerequisites are installed correctly
3. Ensure database is set up properly
4. Check IDE and server configurations

This project is designed for educational purposes and demonstrates fundamental concepts of web development with Java technologies.

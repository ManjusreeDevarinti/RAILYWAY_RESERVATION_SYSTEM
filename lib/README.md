# Library Dependencies

## Required JAR Files

This folder should contain the following JAR files for the Railway Reservation System to work properly:

### 1. MySQL JDBC Driver (Required)

- **File Name:** `mysql-connector-java-8.0.33.jar` (or latest version)
- **Download Link:** https://dev.mysql.com/downloads/connector/j/
- **Alternative:** https://mvnrepository.com/artifact/mysql/mysql-connector-java

### How to Download MySQL JDBC Driver:

#### Option 1: From MySQL Official Website

1. Go to https://dev.mysql.com/downloads/connector/j/
2. Select "Platform Independent"
3. Download the ZIP archive
4. Extract and copy `mysql-connector-java-8.0.33.jar` to this `lib/` folder

#### Option 2: From Maven Repository

1. Go to https://mvnrepository.com/artifact/mysql/mysql-connector-java
2. Select version 8.0.33 or latest
3. Download the JAR file
4. Place it in this `lib/` folder

#### Option 3: Direct Download (Example)

```
https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar
```

### 2. Servlet API (Optional - usually provided by Tomcat)

If you encounter servlet-related compilation issues, you may need:

- **File Name:** `servlet-api.jar`
- **Note:** Usually provided by Tomcat server, so not required if running on Tomcat

## Installation Instructions

1. Download the MySQL JDBC driver JAR file
2. Copy it to this `lib/` folder
3. In IntelliJ IDEA:
   - File → Project Structure → Libraries
   - Click + → Java
   - Select the JAR file from this lib folder
   - Apply changes

## Verification

After adding the JAR file, your lib folder should look like:

```
lib/
├── mysql-connector-java-8.0.33.jar
└── README.md (this file)
```

## Important Notes

- **Version Compatibility:** Use MySQL Connector/J 8.0.x for MySQL 8.0 databases
- **Security:** Always download JAR files from official sources
- **Updates:** Check for newer versions periodically for security updates
- **Licensing:** MySQL Connector/J is GPL licensed

## Troubleshooting

### ClassNotFoundException: com.mysql.cj.jdbc.Driver

- **Cause:** MySQL JDBC driver not in classpath
- **Solution:** Ensure the JAR file is in this lib folder and added to project classpath

### Connection Issues

- **Cause:** Wrong driver version or configuration
- **Solution:**
  1. Use correct driver version for your MySQL version
  2. Check database URL in `DatabaseConnection.java`
  3. Verify MySQL service is running

## Alternative Setup (Maven)

If you prefer using Maven, add this dependency to your `pom.xml`:

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
</dependency>
```

However, for this project structure, manual JAR file placement is recommended for simplicity.

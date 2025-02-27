package com.example.megacitycab.admin_page.dao;

import com.example.megacitycab.admin_page.model.Driver;
import com.example.megacitycab.db.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.io.InputStream;

public class DriverDAO {

    private Connection connection;

    // Constructor to initialize with an existing connection
    public DriverDAO(Connection connection) {
        this.connection = connection;
    }

    // Default constructor
    public DriverDAO() throws SQLException {
        // Get connection from DatabaseConnection class (if no connection passed)
        this.connection = DatabaseConnection.getConnection();  // Ensure that your DatabaseConnection has a proper method
    }

    // Method to save driver to the database
    public boolean saveDriver(Driver driver) {
        boolean success = false;

        if (driver == null) {
            System.err.println("Driver object is null!");
            return false;
        }

        // SQL query to insert driver details into the database
        String query = "INSERT INTO drivers (username, password, email, contact_number, licence_proof, nic_proof, car_license, auto_license, bike_license, address, age, experience) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set parameters for the prepared statement and log them for debugging
            stmt.setString(1, driver.getUsername());
            stmt.setString(2, driver.getPassword());
            stmt.setString(3, driver.getEmail());
            stmt.setString(4, driver.getContactNumber());
            stmt.setBlob(5, driver.getLicenceProof());  // Assuming BLOB column for the file
            stmt.setBlob(6, driver.getNicProof());  // Assuming BLOB column for the file
            stmt.setBoolean(7, driver.isCarLicense());
            stmt.setBoolean(8, driver.isAutoLicense());
            stmt.setBoolean(9, driver.isBikeLicense());
            stmt.setString(10, driver.getAddress());
            stmt.setInt(11, driver.getAge());
            stmt.setInt(12, driver.getExperience());

            // Log parameters to ensure they are correctly set
            System.out.println("Prepared Statement Parameters: ");
            System.out.println("username: " + driver.getUsername());
            System.out.println("password: " + driver.getPassword());
            System.out.println("email: " + driver.getEmail());
            System.out.println("contact_number: " + driver.getContactNumber());
            System.out.println("car_license: " + driver.isCarLicense());
            System.out.println("auto_license: " + driver.isAutoLicense());
            System.out.println("bike_license: " + driver.isBikeLicense());
            System.out.println("address: " + driver.getAddress());
            System.out.println("age: " + driver.getAge());
            System.out.println("experience: " + driver.getExperience());

            // Execute the insert query
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                success = true;
                System.out.println("Driver saved successfully.");
            } else {
                System.err.println("No rows were affected during the save operation.");
            }

        } catch (SQLException e) {
            // Enhanced SQL error logging
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            // General exception handling
            System.err.println("Unexpected Error: " + e.getMessage());
            e.printStackTrace();
        }
        return success;
    }

    // Ensure that the connection is closed properly (if needed outside this class)
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing connection: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
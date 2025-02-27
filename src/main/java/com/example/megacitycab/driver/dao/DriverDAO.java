package com.example.megacitycab.driver.dao;

import com.example.megacitycab.driver.model.Driver;
import com.example.megacitycab.db.DatabaseConnection; // Assuming this class exists
import java.sql.*;

public class DriverDAO {

    private Connection connection;

    // Constructor to initialize with an existing connection
    public DriverDAO(Connection connection) {
        this.connection = connection;
    }

    public Driver getDriverByUsernameAndPassword(String username, String password) {
        Driver driver = null;
        String query = "SELECT * FROM drivers WHERE username = ? AND password = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Assuming your Driver table has fields like username, email, etc.
                driver = new Driver();
                driver.setId(rs.getInt("id"));
                driver.setUsername(rs.getString("username"));
                driver.setEmail(rs.getString("email"));
                driver.setContactNumber(rs.getString("contact_number"));
                driver.setAddress(rs.getString("address"));
                driver.setAge(rs.getInt("age"));
                driver.setExperience(rs.getInt("experience"));
                driver.setCarLicense(rs.getBoolean("car_license"));
                driver.setAutoLicense(rs.getBoolean("auto_license"));
                driver.setBikeLicense(rs.getBoolean("bike_license"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return driver;
    }
}

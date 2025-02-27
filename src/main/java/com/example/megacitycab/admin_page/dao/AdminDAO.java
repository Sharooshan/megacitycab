package com.example.megacitycab.admin_page.dao;

import com.example.megacitycab.admin_page.model.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    private Connection connection;

    public AdminDAO(Connection connection) {
        this.connection = connection;
    }

    // Register a new admin
    public boolean registerAdmin(Admin admin) throws SQLException {
        String query = "INSERT INTO admins (name, email, password, phone, role) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, admin.getName());
            stmt.setString(2, admin.getEmail());
            stmt.setString(3, admin.getPassword()); // Consider hashing this password
            stmt.setString(4, admin.getPhone());
            stmt.setString(5, admin.getRole());
            return stmt.executeUpdate() > 0;
        }
    }

    // Check if admin email already exists
    public boolean adminExists(String email) throws SQLException {
        String query = "SELECT id FROM admins WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Returns true if email exists
        }
    }

    // Admin Login
    public Admin loginAdmin(String email, String password) throws SQLException {
        String query = "SELECT * FROM admins WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password); // Consider verifying hashed passwords
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Admin(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("phone"),
                        rs.getString("role")
                );
            }
        }
        return null;
    }
}

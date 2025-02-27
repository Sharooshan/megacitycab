package com.example.megacitycab.customers_page.util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Static block to load the MySQL driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure MySQL driver is loaded
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load MySQL driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

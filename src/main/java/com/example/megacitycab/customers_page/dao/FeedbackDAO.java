package com.example.megacitycab.customers_page.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class FeedbackDAO {
    public static boolean addFeedback(int customerId, int driverId, int rating, String feedback) {
        boolean status = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            String query = "INSERT INTO driver_feedback (customer_id, driver_id, rating, feedback) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, customerId);
            pstmt.setInt(2, driverId);
            pstmt.setInt(3, rating);
            pstmt.setString(4, feedback);
            int rows = pstmt.executeUpdate();
            if (rows > 0) status = true;
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}

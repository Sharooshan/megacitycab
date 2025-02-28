package com.example.megacitycab.customers_page.dao;


import com.example.megacitycab.customers_page.model.Booking;
import java.sql.*;

public class BookingDAO {

    private String dbURL = "jdbc:mysql://localhost:3306/megacitycab";
    private String dbUser = "root";
    private String dbPass = "";

    // Method to insert booking into the database
    public boolean insertBooking(Booking booking) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            // Establishing connection
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // SQL query to insert the booking
            String sql = "INSERT INTO vehicle_booking (vehicle_id, customer_id, trip_start_date, trip_end_date, " +
                    "trip_time, pickup_location, drop_location, passenger_count, payment_method, total_price, " +
                    "discount_amount, status, created_at, driver_name, driver_mobile) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending', current_timestamp(), ?, ?)";

            ps = conn.prepareStatement(sql);

            // Set values from the Booking object to the SQL query
            ps.setInt(1, booking.getVehicleId());
            ps.setInt(2, booking.getCustomerId());
            ps.setString(3, booking.getTripStartDate());
            ps.setString(4, booking.getTripEndDate());
            ps.setString(5, booking.getTripTime());
            ps.setString(6, booking.getPickupLocation());
            ps.setString(7, booking.getDropLocation());
            ps.setInt(8, booking.getPassengerCount());
            ps.setString(9, booking.getPaymentMethod());
            ps.setDouble(10, booking.getTotalPrice());
            ps.setDouble(11, booking.getDiscountAmount());
            ps.setString(12, booking.getDriverName());
            ps.setString(13, booking.getDriverMobile());

            // Execute the update
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}

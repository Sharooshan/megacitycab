package com.example.megacitycab.admin_page.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AssignVehicleServlet")
public class AssignVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get parameters from the request
            int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));
            int driverId = Integer.parseInt(request.getParameter("driver_id"));

            Connection conn = null;
            PreparedStatement ps1 = null, ps2 = null;

            // SQL queries for both insertion and update
            String insertQuery = "INSERT INTO vehicle_driver_assignment (vehicle_id, id) VALUES (?, ?)";
            String updateQuery = "UPDATE vehicles SET driver_id = ? WHERE vehicle_id = ?";

            try {
                // Establish database connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                conn.setAutoCommit(false);  // Begin transaction

                // Insert into vehicle_driver_assignment
                ps1 = conn.prepareStatement(insertQuery);
                ps1.setInt(1, vehicleId);
                ps1.setInt(2, driverId);
                int result1 = ps1.executeUpdate();

                // Update vehicles table
                ps2 = conn.prepareStatement(updateQuery);
                ps2.setInt(1, driverId);
                ps2.setInt(2, vehicleId);
                int result2 = ps2.executeUpdate();

                // Check if both operations were successful
                if (result1 > 0 && result2 > 0) {
                    conn.commit();  // Commit transaction if successful
                    response.sendRedirect("success.jsp");
                } else {
                    conn.rollback();  // Rollback if any operation fails
                    response.sendRedirect("error.jsp");
                }
            } catch (SQLException e) {
                if (conn != null) {
                    try {
                        conn.rollback();  // Rollback transaction on exception
                    } catch (SQLException rollbackEx) {
                        rollbackEx.printStackTrace();
                    }
                }
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            } finally {
                // Close resources
                try {
                    if (ps1 != null) ps1.close();
                    if (ps2 != null) ps2.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
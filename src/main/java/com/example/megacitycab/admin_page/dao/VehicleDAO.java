package com.example.megacitycab.admin_page.dao;

import com.example.megacitycab.admin_page.model.Vehicle;
import com.example.megacitycab.admin_page.db.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class VehicleDAO {

    private static final Logger LOGGER = Logger.getLogger(VehicleDAO.class.getName());

    public boolean addVehicle(Vehicle vehicle) {
        if (vehicle == null) {
            LOGGER.log(Level.WARNING, "Vehicle object is null.");
            return false;
        }

        String query = "INSERT INTO vehicles (vehicle_type, image, model, color, cc, number_plate) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the parameters for the query
            stmt.setString(1, vehicle.getVehicleType());
            stmt.setString(2, vehicle.getImage());
            stmt.setString(3, vehicle.getModel());
            stmt.setString(4, vehicle.getColor());
            stmt.setString(5, vehicle.getCc());
            stmt.setString(6, vehicle.getNumberPlate());
//            stmt.setString(7, vehicle.getDriverName());
//            stmt.setString(8, vehicle.getDriverMobile());

            int result = stmt.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding vehicle to the database", e);
        }
        return false;
    }
}

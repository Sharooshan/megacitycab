<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Details</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 900px;
            margin-top: 50px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .vehicle-card {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .vehicle-img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Vehicle Details</h1>
    <br/>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT vehicle_id, vehicle_type, image, model, color, cc, number_plate FROM vehicles";

        try {
            // Connect to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            // Loop through the result set and display the vehicle details
            while (rs.next()) {
                String vehicleId = rs.getString("vehicle_id");
                String vehicleType = rs.getString("vehicle_type");
                String image = rs.getString("image");
                String model = rs.getString("model");
                String color = rs.getString("color");
                String cc = rs.getString("cc");
                String numberPlate = rs.getString("number_plate");
    %>

    <!-- Vehicle Card -->
    <div class="vehicle-card">
        <h4><%= vehicleType %> - <%= model %></h4>
        <img src="<%= request.getContextPath() %>/images/<%= image %>" alt="<%= vehicleType %>" class="vehicle-img">
        <p><strong>Color:</strong> <%= color %></p>
        <p><strong>CC:</strong> <%= cc %></p>
        <p><strong>Number Plate:</strong> <%= numberPlate %></p>
        <p><strong>Vehicle ID:</strong> <%= vehicleId %></p>

        <!-- Assign Button Form -->
        <form action="AssignVehicleServlet" method="POST">
            <input type="hidden" name="vehicle_id" value="<%= vehicleId %>">
            <label for="driver_id">Select Driver:</label>
            <select name="driver_id" id="driver_id" required>
                <%
                    // Get list of drivers with matching license type based on vehicle type
                    String driverQuery = "";
                    if (vehicleType.equalsIgnoreCase("Bike")) {
                        driverQuery = "SELECT id, username FROM drivers WHERE bike_license = 1";
                    } else if (vehicleType.equalsIgnoreCase("Car")) {
                        driverQuery = "SELECT id, username FROM drivers WHERE car_license = 1";
                    } else if (vehicleType.equalsIgnoreCase("Auto")) {
                        driverQuery = "SELECT id, username FROM drivers WHERE auto_license = 1";
                    } else {
                        driverQuery = "SELECT id, username FROM drivers"; // In case no match, show all drivers
                    }

                    PreparedStatement driverPs = conn.prepareStatement(driverQuery);
                    ResultSet driverRs = driverPs.executeQuery();

                    while (driverRs.next()) {
                        int driverId = driverRs.getInt("id");
                        String username = driverRs.getString("username");
                %>
                <option value="<%= driverId %>"><%= username %></option>
                <%
                    }
                    driverRs.close();
                    driverPs.close();
                %>
            </select>
            <button type="submit" class="btn btn-primary mt-3">Assign Vehicle</button>
        </form>
    </div>

    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>

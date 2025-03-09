<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Driver Availability Check</title>
    <link rel="stylesheet" href="styles.css"> <!-- Assuming you have a styles.css -->
</head>
<body>
<h1>Driver Availability and Booking Information</h1>

<%
    // Retrieve vehicle_id from the URL
    String vehicleIdParam = request.getParameter("vehicle_id");
    if (vehicleIdParam == null || vehicleIdParam.isEmpty()) {
        out.println("Vehicle ID is missing.");
        return;
    }

    int vehicleId = Integer.parseInt(vehicleIdParam);

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/megacitycab"; // Replace with your DB details
    String username = "root";
    String password = "";  // Replace with your DB password

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Establish connection
        conn = DriverManager.getConnection(url, username, password);
        stmt = conn.createStatement();

        // SQL query to get bookings for the specific vehicle_id
        String sql = "SELECT b.id AS booking_id, b.customer_id, b.vehicle_id, b.trip_start_date, b.trip_end_date, " +
                "b.from_location, b.to_location, b.status, v.vehicle_type, v.model, vd.id, d.username, " +
                "d.availability FROM bookings b " +
                "JOIN vehicle_driver_assignment vd ON b.vehicle_id = vd.vehicle_id " +
                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                "JOIN drivers d ON vd.id = d.id " +
                "WHERE b.vehicle_id = " + vehicleId;  // Filter by the specific vehicle_id

        rs = stmt.executeQuery(sql);

        // Display data in a table format
%>
<table border="1">
    <thead>
    <tr>
        <th>Booking ID</th>
        <th>Customer ID</th>
        <th>Vehicle</th>
        <th>Driver</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>From Location</th>
        <th>To Location</th>
        <th>Status</th>
        <th>Driver Availability</th>
        <th>Action</th> <!-- Added Action column for the button -->
    </tr>
    </thead>
    <tbody>
    <%
        while (rs.next()) {
            int bookingId = rs.getInt("booking_id");
            int customerId = rs.getInt("customer_id");
            String vehicleType = rs.getString("vehicle_type");
            String model = rs.getString("model");
            int driverId = rs.getInt("id");
            String driverName = rs.getString("username");
            String tripStartDate = rs.getString("trip_start_date");
            String tripEndDate = rs.getString("trip_end_date");
            String fromLocation = rs.getString("from_location");
            String toLocation = rs.getString("to_location");
            String status = rs.getString("status");
            String availability = rs.getString("availability");

            // Determine driver availability
            String driverAvailability = "Available";  // Default

            if ("Cancelled".equalsIgnoreCase(status) || "Completed".equalsIgnoreCase(status)) {
                driverAvailability = "Available";  // Available if status is Cancelled or Completed
            } else if ("Accepted".equalsIgnoreCase(status)) {
                // Driver is unavailable during the trip
                driverAvailability = "Unavailable during trip (" + tripStartDate + " to " + tripEndDate + ")";
            }

            // Display booking data in the table
    %>
    <tr>
        <td><%= bookingId %></td>
        <td><%= customerId %></td>
        <td><%= vehicleType + " (" + model + ")" %></td>
        <td><%= driverName %></td>
        <td><%= tripStartDate %></td>
        <td><%= tripEndDate %></td>
        <td><%= fromLocation %></td>
        <td><%= toLocation %></td>
        <td><%= status %></td>
        <td><%= driverAvailability %></td>
        <td>
            <!-- Button to check booking details, passing both booking_id and customer_id to manageBookings.jsp -->
            <form action="manageBookings.jsp" method="get">
                <input type="hidden" name="booking_id" value="<%= bookingId %>">
                <input type="hidden" name="customer_id" value="<%= customerId %>">
                <button type="submit">Check Booking Details</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>

    </tbody>
</table>
<%
    } catch (SQLException e) {
        out.println("Database error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
</body>
</html>

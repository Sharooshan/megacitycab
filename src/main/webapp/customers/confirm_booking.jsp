<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .confirmation-message {
            font-size: 1.2rem;
            margin-top: 20px;
        }
        .error-message {
            color: red;
            font-size: 1rem;
        }
        .btn-custom {
            background-color: #4CAF50;
            color: white;
        }
        .btn-custom:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="my-4">Confirm Your Booking</h1>
    <%
        // Retrieve form data from request
        String vehicleId = request.getParameter("vehicle_id");
        String customerId = request.getParameter("customer_id");
        String tripStartDate = request.getParameter("trip_start_date");
        String tripEndDate = request.getParameter("trip_end_date");
        String fromLocation = request.getParameter("from_location");
        String toLocation = request.getParameter("to_location");
        String tripTime = request.getParameter("trip_time");
        String passengerCount = request.getParameter("passenger_count");
        String paymentMethod = request.getParameter("payment_method");
//        String totalPriceParam = request.getParameter("total_price");
        String totalPrice = request.getParameter("total_price");

        double discount = 0; // You can add logic for discounts if needed

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // Set up connection to database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

            // Prepare SQL insert query
            String query = "INSERT INTO bookings (customer_id, vehicle_id, trip_start_date, trip_end_date, from_location, to_location, trip_time, passenger_count, payment_method, total_price, discount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            // Create PreparedStatement and set the values
            ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);  // Use RETURN_GENERATED_KEYS
            ps.setInt(1, Integer.parseInt(customerId));
            ps.setInt(2, Integer.parseInt(vehicleId));
            ps.setString(3, tripStartDate);
            ps.setString(4, tripEndDate);
            ps.setString(5, fromLocation);
            ps.setString(6, toLocation);
            ps.setString(7, tripTime);
            ps.setInt(8, Integer.parseInt(passengerCount));
            ps.setString(9, paymentMethod);
            ps.setString(10, totalPrice); // Set totalPrice here
            ps.setDouble(11, discount);    // Set discount (if any)

            // Execute the update
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                // Retrieve the generated Booking ID
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int bookingId = rs.getInt(1);
                    out.println("<div class='confirmation-message'>Your booking has been successfully confirmed!</div>");
                    out.println("<div class='confirmation-message'>Booking ID: " + bookingId + "</div>");
                }
            } else {
                out.println("<p class='error-message'>Error: Unable to confirm booking.</p>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p class='error-message'>Database error: " + e.getMessage() + "</p>");
        } finally {
            // Clean up resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    %>
    <a href="index.jsp" class="btn btn-custom">Go to Home</a>
    <a href="bookingHistory.jsp" class="btn btn-outline-primary ms-2">View Booking History</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

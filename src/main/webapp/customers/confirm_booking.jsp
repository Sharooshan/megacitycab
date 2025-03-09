<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .bill-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background: #f9f9f9;
        }
        .bill-header {
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .bill-details {
            font-size: 1rem;
        }
        .bill-total {
            font-size: 1.2rem;
            font-weight: bold;
            text-align: right;
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
<div class="container my-5">
    <div class="bill-container">
        <div class="bill-header">Booking Confirmation & Invoice</div>
        <div class="bill-details">
            <%
                String vehicleId = request.getParameter("vehicle_id");
                String customerId = request.getParameter("customer_id");
                String tripStartDate = request.getParameter("trip_start_date");
                String tripEndDate = request.getParameter("trip_end_date");
                String fromLocation = request.getParameter("from_location");
                String toLocation = request.getParameter("to_location");
                String tripTime = request.getParameter("trip_time");
                String passengerCount = request.getParameter("passenger_count");
                String paymentMethod = request.getParameter("payment_method");
                String totalPrice = request.getParameter("total_price");
                String status = "Pending";
                double discount = 0;

                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int bookingId = -1;
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                    String query = "INSERT INTO bookings (customer_id, vehicle_id, trip_start_date, trip_end_date, from_location, to_location, trip_time, passenger_count, payment_method, total_price, discount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                    ps.setInt(1, Integer.parseInt(customerId));
                    ps.setInt(2, Integer.parseInt(vehicleId));
                    ps.setString(3, tripStartDate);
                    ps.setString(4, tripEndDate);
                    ps.setString(5, fromLocation);
                    ps.setString(6, toLocation);
                    ps.setString(7, tripTime);
                    ps.setInt(8, Integer.parseInt(passengerCount));
                    ps.setString(9, paymentMethod);
                    ps.setString(10, totalPrice);
                    ps.setDouble(11, discount);
                    ps.setString(12, status);
                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        rs = ps.getGeneratedKeys();
                        if (rs.next()) {
                            bookingId = rs.getInt(1);
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='error-message'>Database error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            %>
            <p><strong>Booking ID:</strong> <%= bookingId %></p>
            <p><strong>Customer ID:</strong> <%= customerId %></p>
            <p><strong>Vehicle ID:</strong> <%= vehicleId %></p>
            <p><strong>Trip Date:</strong> <%= tripStartDate %> to <%= tripEndDate %></p>
            <p><strong>From:</strong> <%= fromLocation %></p>
            <p><strong>To:</strong> <%= toLocation %></p>
            <p><strong>Trip Time:</strong> <%= tripTime %></p>
            <p><strong>Passengers:</strong> <%= passengerCount %></p>
            <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
            <p class="bill-total">Total Price: $<%= totalPrice %></p>
            <p><strong>Status:</strong> <%= status %></p>
        </div>
    </div>
    <div class="text-center mt-4">
<%--        <a href="index.jsp" class="btn btn-custom">Go to Home</a>--%>
        <a href="bookingHistory.jsp" class="btn btn-outline-primary ms-2">View Booking History</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

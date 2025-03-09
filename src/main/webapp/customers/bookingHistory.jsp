<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-container {
            margin: 20px auto;
            max-width: 900px;
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
    <h2 class="text-center mb-4">Your Booking History</h2>

    <%
        // Getting the logged-in user ID from the session (Assuming customer is logged in)
        Integer customerId = (Integer) session.getAttribute("customerId");

        if (customerId == null) {
            out.println("<div class='alert alert-danger'>You must be logged in to view your booking history.</div>");
        } else {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Establishing the database connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

                // Query to fetch all bookings for the logged-in customer
                String query = "SELECT * FROM bookings WHERE customer_id = ? ORDER BY trip_start_date DESC";
                ps = conn.prepareStatement(query);
                ps.setInt(1, customerId);
                rs = ps.executeQuery();

                // Check if there are any bookings
                if (rs.next()) {
    %>
    <!-- Display the booking details in a table -->
    <div class="table-container">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Booking ID</th>
                <th>Vehicle ID</th>
                <th>Trip Start Date</th>
                <th>Trip End Date</th>
                <th>From Location</th>
                <th>To Location</th>
                <th>Status</th>
                <th>Total Price</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Loop through all rows in the result set and display the bookings
                do {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getInt("vehicle_id") %></td>
                <td><%= rs.getString("trip_start_date") %></td>
                <td><%= rs.getString("trip_end_date") %></td>
                <td><%= rs.getString("from_location") %></td>
                <td><%= rs.getString("to_location") %></td>
                <td><%= rs.getString("status") %></td>
                <td>$<%= rs.getString("total_price") %></td>
            </tr>
            <%
                } while (rs.next());
            %>
            </tbody>
        </table>
    </div>
    <%
                } else {
                    out.println("<div class='alert alert-info'>No booking history found.</div>");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>An error occurred while retrieving your booking history.</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    %>

    <!-- Back to Home Button -->
    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-custom">Go to Home</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

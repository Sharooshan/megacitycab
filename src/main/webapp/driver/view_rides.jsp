<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.megacitycab.driver.model.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Rides</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<style>
    body {
        background-color: #121212; /* Dark Background */
        color: #ffffff;
    }
    .card {
        background-color: #1e1e1e; /* Dark Card */
        color: #ffffff;
        border: 1px solid #333;
    }
    .list-group-item {
        background-color: #1e1e1e;
        color: #ffffff;
        border-color: #444;
    }
    .list-group-item-action:hover {
        background-color: #333;
    }
    .table {
        background-color: #1e1e1e;
        color: #ffffff;
    }
    .table th, .table td {
        border-color: #444;
    }
    .table-dark {
        background-color: #000000;
    }
    .btn-dark {
        background-color: #333;
        border-color: #444;
    }
    .btn-dark:hover {
        background-color: #555;
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<body class="bg-light">

<div class="container mt-5">
    <!-- Card for Ride History -->
    <div class="card shadow p-4">
        <%
            Driver driver = (Driver) session.getAttribute("driver");

            if (driver != null) {
        %>
        <h2 class="text-center">Welcome, <%= driver.getUsername() %>!</h2>
        <hr>

        <h4>My Ride History</h4>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rsRides = null;
            ResultSet rsVehicles = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

// Handle ride status update
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String rideIdParam = request.getParameter("rideId");
                    String newStatus = request.getParameter("status");

                    if (rideIdParam != null && newStatus != null) {
                        int rideId = Integer.parseInt(rideIdParam);
                        String updateSql = "UPDATE bookings SET status = ? WHERE id = ?";
                        pstmt = conn.prepareStatement(updateSql);
                        pstmt.setString(1, newStatus);
                        pstmt.setInt(2, rideId);
                        pstmt.executeUpdate();

                        // Check if the status is "Rejected" and trigger an alert
                        if ("Cancelled".equalsIgnoreCase(newStatus)) {
                            response.sendRedirect("notify_admin.jsp?rideId=" + rideId);
                        }

                    }
                }

                // Query for ride history
                String sqlRides = "SELECT b.id, b.from_location, b.to_location, b.trip_start_date, b.trip_end_date, b.trip_time, " +
                        "b.passenger_count, b.payment_method, b.total_price, b.discount,  b.status " +
                        "FROM bookings b " +
                        "JOIN vehicle_driver_assignment vda ON b.vehicle_id = vda.vehicle_id " +
                        "WHERE vda.id = ?";
                pstmt = conn.prepareStatement(sqlRides);
                pstmt.setInt(1, driver.getId());
                rsRides = pstmt.executeQuery();
        %>

        <!-- Display Ride History in a Table -->
        <table class="table table-bordered mt-3">
            <thead class="table-dark">
            <tr>
                <th>Booking ID</th>
                <th>From Location</th>
                <th>To Location</th>
                <th>Trip Start Date</th>
                <th>Trip End Date</th>
                <th>Trip Time</th>
                <th>Passenger Count</th>
                <th>Payment Method</th>
                <th>Total Price</th>
                <%--                <th>Discount</th>--%>
                <th>Status</th>
                <th>Update</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasRides = false;
                while (rsRides.next()) {
                    hasRides = true;
            %>
            <tr>
                <td><%= rsRides.getInt("id") %></td>
                <td><%= rsRides.getString("from_location") %></td>
                <td><%= rsRides.getString("to_location") %></td>
                <td><%= rsRides.getTimestamp("trip_start_date") %></td>
                <td><%= rsRides.getTimestamp("trip_end_date") %></td>
                <td><%= rsRides.getString("trip_time") %></td>
                <td><%= rsRides.getInt("passenger_count") %></td>
                <td><%= rsRides.getString("payment_method") %></td>
                <td><%= rsRides.getDouble("total_price") %></td>
                <%--                <td><%= rsRides.getDouble("discount") %></td>--%>
                <td>
                    <% if ("Cancelled".equals(rsRides.getString("status"))) { %>
                    <button class="btn btn-danger notify-admin" data-booking-id="<%= rsRides.getInt("id") %>">
                        Cancelled
                    </button>
                    <% } else { %>
                    <form method="post">
                        <input type="hidden" name="rideId" value="<%= rsRides.getInt("id") %>">
                        <select name="status" class="form-select">
                            <option value="Pending" <%= rsRides.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                            <option value="Accepted" <%= rsRides.getString("status").equals("Accepted") ? "selected" : "" %>>Accepted</option>

                            <option value="Completed" <%= rsRides.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>
                            <option value="Cancelled" <%= rsRides.getString("status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                        </select>
                </td>
                <td>
                    <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </td>
                <% } %>

            </tr>
            <%
                }
                if (!hasRides) {
            %>
            <tr>
                <td colspan="10" class="text-center text-muted">No ride history available</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <%
            // Query for vehicle assignments
            String sqlVehicles = "SELECT v.vehicle_id, v.vehicle_type, v.number_plate, a.assigned_at " +
                    "FROM vehicle_driver_assignment a " +
                    "JOIN vehicles v ON a.vehicle_id = v.vehicle_id " +
                    "WHERE a.id = ?";
            pstmt = conn.prepareStatement(sqlVehicles);
            pstmt.setInt(1, driver.getId());
            rsVehicles = pstmt.executeQuery();
        %>

        <!-- Display Assigned Vehicles in a Table -->
        <table class="table table-bordered mt-3">
            <thead class="table-dark">
            <tr>
                <th>Vehicle ID</th>
                <th>Vehicle Type</th>
                <th>Number Plate</th>
                <th>Assigned At</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasVehicles = false;
                while (rsVehicles.next()) {
                    hasVehicles = true;
            %>
            <tr>
                <td><%= rsVehicles.getInt("vehicle_id") %></td>
                <td><%= rsVehicles.getString("vehicle_type") %></td>
                <td><%= rsVehicles.getString("number_plate") %></td>
                <td><%= rsVehicles.getTimestamp("assigned_at") %></td>
            </tr>
            <%
                }
                if (!hasVehicles) {
            %>
            <tr>
                <td colspan="4" class="text-center text-muted">No vehicles assigned</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rsRides != null) rsRides.close();
                    if (rsVehicles != null) rsVehicles.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <!-- Back to Dashboard -->
        <div class="text-center">
            <a href="driver_dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
        <%
        } else {
        %>
        <p class="text-danger">You are not logged in. Please log in first.</p>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
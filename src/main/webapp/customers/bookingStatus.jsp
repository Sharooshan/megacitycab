<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Check if the user is logged in
    Integer customerId = (Integer) session.getAttribute("customerId");
    if (customerId == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/megacitycab";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    boolean hasCancelledBooking = false; // Flag to check for canceled bookings
    String cancelledVehicleId = ""; // Store vehicle ID for cancelled booking
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Status</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<style>

    .navbar {
        background-color: #1E1E1E !important;
        padding: 15px 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    /* Brand (Always Left-Aligned) */
    .navbar-brand {
        font-size: 1.5rem;
        font-weight: bold;
        color: #FFCC00 !important;
    }

    /* Navbar Links */
    .navbar-nav {
        display: flex;
        align-items: center;
        justify-content: center;
        flex-grow: 1; /* Pushes buttons to the center */
    }

    .navbar-nav .nav-link {
        color: #FFFFFF !important;
        font-size: 1.1rem;
        font-weight: 500;
        margin: 0 10px;
    }

    .navbar-nav .nav-link:hover {
        color: #FFCC00 !important;
    }

    /* Navbar - Logged In */
    .navbar-logged-in {
        background-color: #FFCC00 !important;
    }

    .navbar-logged-in .navbar-brand {
        color: #1E1E1E !important;
    }

    .navbar-logged-in .nav-link {
        color: #1E1E1E !important;
    }

    /* Center Navbar Buttons After Login */
    .navbar-logged-in .navbar-nav {
        justify-content: center;
        width: 100%;
    }

    /* Login Button (Visible Only Before Login) */
    .navbar .login-btn {
        display: block;
    }

    /* Hide Login Button After Login */
    .navbar-logged-in .login-btn {
        display: none;
    }

    /* Buttons */
    .navbar .btn {
        background-color: #FFCC00;
        color: #1E1E1E;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: bold;
        margin: 0 10px;
    }

    .navbar .btn:hover {
        background-color: #D9B000;
        color: #FFFFFF;
    }
</style>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Brand Logo -->
        <a class="navbar-brand" href="#">Mega City Cab</a>

        <!-- Navbar Toggler (Mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp">Home</a>
                </li>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="../customers/register.jsp">Register</a>--%>
                <%--                </li>--%>
            </ul>

            <!-- Right Aligned Links (Login/Logout + Other Buttons) -->
            <div class="d-flex align-items-center">
                <% String customerEmail = (String) session.getAttribute("customerEmail"); %>
<%--                <% Integer customerId = (Integer) session.getAttribute("customerId"); %>--%>

                <% if (customerEmail != null) { %>
                <a class="btn btn-outline-light me-2" href="bookingStatus.jsp">Booking Status</a>
                <a class="btn btn-outline-light me-2" href="Add_feedback.jsp">Add Feedback</a>
                <a class="btn btn-warning text-dark px-3" href="logout">Logout</a>
                <% } else { %>
                <a class="btn btn-warning text-dark px-3" href="login.jsp">Login</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <h2 class="mb-4">Your Booking History</h2>
    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Vehicle ID</th>
            <th>Trip Start Date</th>
            <th>Trip End Date</th>
            <th>From</th>
            <th>To</th>
            <th>Trip Time</th>
            <th>Passengers</th>
            <th>Payment Method</th>
            <th>Total Price</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Query to fetch only the logged-in user's bookings
                String sql = "SELECT id, vehicle_id, trip_start_date, trip_end_date, from_location, to_location, trip_time, passenger_count, payment_method, total_price, status FROM bookings WHERE customer_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, customerId);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    String status = rs.getString("status");
                    int vehicleId = rs.getInt("vehicle_id");

                    if ("Cancelled".equalsIgnoreCase(status)) {
                        hasCancelledBooking = true; // Set flag if there is a cancelled booking
                        cancelledVehicleId = String.valueOf(vehicleId); // Store vehicle ID
                    }
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= vehicleId %></td>
            <td><%= rs.getDate("trip_start_date") %></td>
            <td><%= rs.getDate("trip_end_date") %></td>
            <td><%= rs.getString("from_location") %></td>
            <td><%= rs.getString("to_location") %></td>
            <td><%= rs.getString("trip_time") %></td>
            <td><%= rs.getInt("passenger_count") %></td>
            <td><%= rs.getString("payment_method") %></td>
            <td><%= rs.getDouble("total_price") %></td>
            <td><%= status %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        </tbody>
    </table>

    <%-- Display message if there is a cancelled booking --%>
    <% if (hasCancelledBooking) { %>
    <div class="alert alert-warning mt-3">
        <strong>Notice:</strong> Your ride with Vehicle ID <%= cancelledVehicleId %> is currently on hold because the assigned driver rejected your booking. Our team is assigning a new driver, and you will receive a call from our admin within 2 hours. Please wait for further updates.
    </div>
    <% } %>
</div>
</body>
</html>

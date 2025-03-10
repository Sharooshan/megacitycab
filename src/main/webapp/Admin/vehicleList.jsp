<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle List</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        max-width: 1200px;
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
    body {
        background-color: #ffffff;
        color: #000000;
        font-family: Arial, sans-serif;
    }
    .sidebar {
        width: 250px;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        background-color: #000000;
        color: #ffffff;
        padding-top: 20px;
    }
    .sidebar a {
        display: block;
        color: #ffffff;
        padding: 15px;
        text-decoration: none;
        transition: 0.3s;
    }
    .sidebar a:hover {
        background-color: #555;
    }
    .content {
        margin-left: 260px;
        padding: 20px;
    }
    .card {
        border: none;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    .btn-dark {
        background-color: #212529; /* Dark color */
        border-color: #212529;
        color: #fff;
        transition: background-color 0.3s ease, border-color 0.3s ease;
    }

    .btn-dark:hover {
        background-color: #343a40; /* Slightly lighter dark shade */
        border-color: #343a40;
    }

</style>
<!-- Sidebar Navigation -->
<div class="sidebar">
    <h4 class="text-center">MegaCityCab - Admin</h4>
    <a href="AdminDashboard.jsp">Dashboard</a>
    <a href="assigning.jsp" >Assigning Drivers</a>
    <a href="register.jsp" >Register Drivers</a>
    <a href="admin_register.jsp">Register Admins</a>
    <a href="viewRejections.jsp">Check Ride Rejections</a>
    <a href="vehicleList.jsp">Manage Vehicles</a>
    <a href="manageBookings.jsp">Manage Bookings</a>
    <a href="driver_available_check.jsp">Driver Availability</a>
    <a href="manage_feedback.jsp">Manage Feedback</a>
    <a href="AddVehicle.jsp">Manage Vehicles</a>

    <a href="AdminLogoutServlet">Logout</a>
</div>



<body>

<%--<!-- Bootstrap Navbar -->--%>
<%--<nav class="navbar navbar-expand-lg navbar-dark bg-dark">--%>
<%--    <div class="container-fluid">--%>
<%--        <a class="navbar-brand" href="#">MegaCityCab - Admin</a>--%>
<%--        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">--%>
<%--            <span class="navbar-toggler-icon"></span>--%>
<%--        </button>--%>
<%--        <div class="collapse navbar-collapse" id="navbarNav">--%>
<%--            <ul class="navbar-nav ms-auto">--%>
<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link active" href="AdminDashboard.jsp">Dashboard</a>--%>
<%--                </li>--%>
<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link" href="AddVehicle.jsp">Manage Vehicles</a>--%>
<%--                </li>--%>
<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link" href="ManageAdmins.jsp">Manage Admins</a>--%>
<%--                </li>--%>
<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link" href="ManageDrivers.jsp">Manage Drivers</a>--%>
<%--                </li>--%>
<%--                <li class="nav-item">--%>
<%--                    <a class="nav-link" href="AdminLogoutServlet">Logout</a>--%>
<%--                </li>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>

<div class="container">
    <h1>Vehicle List</h1>
    <br/>
    <h2>Available Vehicles</h2>

    <%
        // Connect to the database and fetch vehicle data
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM vehicles"; // Adjust your table name here
        try {
            // Assuming you've set up the database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            // Loop through the result set to display vehicle details
            while (rs.next()) {
                String vehicleId = rs.getString("vehicle_id");
                String vehicleType = rs.getString("vehicle_type");
                String image = rs.getString("image");
                String model = rs.getString("model");
                String color = rs.getString("color");
                String cc = rs.getString("cc");
                String numberPlate = rs.getString("number_plate");
//                String driverName = rs.getString("driver_name");
//                String driverMobile = rs.getString("driver_mobile");
//                String driverGender = rs.getString("driver_gender");
    %>
    <div class="vehicle-card">
        <h4><%= vehicleType %> - <%= model %></h4>
        <img src="images/<%= image %>" alt="<%= vehicleType %>" class="vehicle-img">
        <p><strong>Color:</strong> <%= color %></p>
        <p><strong>CC:</strong> <%= cc %></p>
        <p><strong>Number Plate:</strong> <%= numberPlate %></p>
<%--        <p><strong>Driver:</strong> <%= driverName %> </p>--%>
<%--        <p><strong>Contact:</strong> <%= driverMobile %></p>--%>

        <!-- Action buttons (Edit, Delete, Copy) -->
        <div class="action-btns">
            <a href="editVehicle.jsp?vehicle_id=<%= vehicleId %>" class="btn btn-dark">Edit</a>
            <a href="deleteVehicle.jsp?vehicle_id=<%= vehicleId %>" class="btn btn-danger">Delete</a>
<%--            <a href="copyVehicle.jsp?vehicle_id=<%= vehicleId %>" class="btn btn-info">Copy</a>--%>
        </div>
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

<!-- Bootstrap 5 JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>

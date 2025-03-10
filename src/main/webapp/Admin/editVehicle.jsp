<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vehicle</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
        h1 {
            color: #0b0d10;
        }
    </style>
</head>

<body>

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




<div class="container">
    <h1>Edit Vehicle</h1>
    <br/>
    <%
        String vehicleId = request.getParameter("vehicle_id");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM vehicles WHERE vehicle_id = ?"; // Assuming vehicle_id is the unique identifier

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            ps = conn.prepareStatement(query);
            ps.setString(1, vehicleId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String vehicleType = rs.getString("vehicle_type");
                String model = rs.getString("model");
                String color = rs.getString("color");
                String cc = rs.getString("cc");
                String numberPlate = rs.getString("number_plate");
    %>
    <form action="updateVehicle.jsp" method="post">
        <input type="hidden" name="vehicle_id" value="<%= vehicleId %>">
        <div class="mb-3">
            <label for="vehicleType" class="form-label">Vehicle Type</label>
            <input type="text" class="form-control" id="vehicleType" name="vehicle_type" value="<%= vehicleType %>" required>
        </div>
        <div class="mb-3">
            <label for="model" class="form-label">Model</label>
            <input type="text" class="form-control" id="model" name="model" value="<%= model %>" required>
        </div>
        <div class="mb-3">
            <label for="color" class="form-label">Color</label>
            <input type="text" class="form-control" id="color" name="color" value="<%= color %>" required>
        </div>
        <div class="mb-3">
            <label for="cc" class="form-label">CC</label>
            <input type="text" class="form-control" id="cc" name="cc" value="<%= cc %>" required>
        </div>
        <div class="mb-3">
            <label for="numberPlate" class="form-label">Number Plate</label>
            <input type="text" class="form-control" id="numberPlate" name="number_plate" value="<%= numberPlate %>" required>
        </div>
        <button type="submit" class="btn btn-dark">Update Vehicle</button>
    </form>
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

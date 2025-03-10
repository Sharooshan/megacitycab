<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.megacitycab.driver.model.Driver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Dashboard</title>
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
<body class="bg-light">

<div class="container mt-5">
    <!-- Card for Driver Info -->
    <div class="card shadow p-4">
        <%
            Driver driver = (Driver) session.getAttribute("driver");

            if (driver != null) {
        %>
        <h2 class="text-center">Welcome, <%= driver.getUsername() %>!</h2>
        <hr>

        <!-- Driver Details -->
        <div class="row">
            <div class="col-md-6">
                <h4>Driver Information</h4>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Username:</strong> <%= driver.getUsername() %></li>
                    <li class="list-group-item"><strong>Email:</strong> <%= driver.getEmail() %></li>
                    <li class="list-group-item"><strong>Contact Number:</strong> <%= driver.getContactNumber() %></li>
                    <li class="list-group-item"><strong>Address:</strong> <%= driver.getAddress() %></li>
                    <li class="list-group-item"><strong>Age:</strong> <%= driver.getAge() %></li>
                    <li class="list-group-item"><strong>Experience:</strong> <%= driver.getExperience() %> years</li>
                    <li class="list-group-item"><strong>Car License:</strong> <%= driver.isCarLicense() ? "Yes" : "No" %></li>
                    <li class="list-group-item"><strong>Auto License:</strong> <%= driver.isAutoLicense() ? "Yes" : "No" %></li>
                    <li class="list-group-item"><strong>Bike License:</strong> <%= driver.isBikeLicense() ? "Yes" : "No" %></li>
                </ul>
            </div>

            <div class="col-md-6">
                <h4>Actions</h4>
                <div class="list-group">
                    <a href="D_view_vehicles.jsp?driver_id=<%= driver.getId() %>" class="list-group-item list-group-item-action">View Vehicles</a>
                    <a href="edit_profile.jsp?driver_id=<%= driver.getId() %>" class="list-group-item list-group-item-action">Edit Profile</a>
                    <a href="view_rides.jsp?driver_id=<%= driver.getId() %>" class="list-group-item list-group-item-action">View My Rides</a>

                    <a href="logout" class="list-group-item list-group-item-action text-danger">Logout</a>
                </div>
            </div>
        </div>

        <!-- Assigned Vehicle Details -->
        <hr>
        <h4>Assigned Vehicle Details</h4>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

                // SQL query to fetch assigned vehicle details based on driver_id in the vehicles table
                String sql = "SELECT v.vehicle_type, v.number_plate, a.assigned_at " +
                        "FROM vehicle_driver_assignment a " +
                        "JOIN vehicles v ON a.vehicle_id = v.vehicle_id " +
                        "WHERE v.driver_id = ?";  // Filter based on driver_id in vehicles table
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, driver.getId());  // Set the driver's ID from session
                rs = pstmt.executeQuery();

        %>

        <!-- Display Assigned Vehicles in a Table -->
        <table class="table table-bordered mt-3">
            <thead class="table-dark">
            <tr>
                <th>Vehicle Type</th>
                <th>Number Plate</th>
                <th>Assigned At</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasAssignedVehicle = false;
                while (rs.next()) {
                    hasAssignedVehicle = true;
            %>
            <tr>
                <td><%= rs.getString("vehicle_type") %></td>
                <td><%= rs.getString("number_plate") %></td>
                <td><%= rs.getTimestamp("assigned_at") %></td>
            </tr>
            <%
                }
                if (!hasAssignedVehicle) {
            %>
            <tr>
                <td colspan="3" class="text-center text-muted">No assigned vehicles</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <%
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <p class="text-danger">Error fetching vehicle details.</p>
        <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }}
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

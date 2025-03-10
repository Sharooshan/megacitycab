<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>
<%
    // Check if the admin is logged in
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminEmail") == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
    String adminEmail = (String) adminSession.getAttribute("adminEmail");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
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
    </style>
</head>
<body>

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

<!-- Main Content -->
<div class="content">
    <div class="alert alert-success text-center">
        <h4>Welcome, Admin!</h4>
        <p>You are logged into the MegaCityCab Admin Dashboard.</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="card text-center p-3">
                <h5>Assigning Drivers</h5>
                <a href="assigning.jsp" class="btn btn-dark">Go</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center p-3">
                <h5>Register Drivers</h5>
                <a href="register.jsp" class="btn btn-dark">Go</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center p-3">
                <h5>Manage Feedback</h5>
                <a href="manage_feedback.jsp" class="btn btn-dark">Go</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

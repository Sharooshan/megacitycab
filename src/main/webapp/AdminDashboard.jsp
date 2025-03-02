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
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #343a40 !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .dashboard-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">MegaCityCab - Admin</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="AdminDashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AddVehicle.jsp">Manage Vehicles</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ManageAdmins.jsp">Manage Admins</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="admin_register.jsp">Manage Drivers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdminLogoutServlet">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Dashboard Content -->
<div class="container dashboard-container">
    <div class="alert alert-success text-center">
        <h4>Welcome, <%= adminEmail %>!</h4>
        <p>You are logged into the MegaCityCab Admin Dashboard.</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Assigning drivers</h5>
                    <p class="card-text">Add, update, or remove admin accounts.</p>
                    <a href="assigning.jsp" class="btn btn-primary">Go</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Register drivers</h5>
                    <p class="card-text">Add, update, or remove admin accounts.</p>
                    <a href="register.jsp" class="btn btn-primary">Go</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Register Admins</h5>
                    <p class="card-text">View and manage registered drivers.</p>
                    <a href="admin_register.jsp" class="btn btn-primary">Go</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Check Ride Rejections</h5>
                    <p class="card-text">View rejected rides and manage notifications.</p>
                    <a href="viewRejections.jsp" class="btn btn-danger">Go</a>
                </div>
            </div>
        </div>


        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Manage Vehicles</h5>
                    <p class="card-text">View and manage vehicle listings.</p>
                    <a href="vehicleList.jsp" class="btn btn-primary">Go</a>
                </div>
            </div>
        </div>


        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Add New Vehicle</h5>
                    <p class="card-text">View and manage vehicle listings.</p>
                    <a href="AddVehicle.jsp" class="btn btn-primary">Go</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

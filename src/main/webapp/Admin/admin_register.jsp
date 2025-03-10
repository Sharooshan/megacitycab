<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Registration</title>
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
<div class="container mt-5">
  <h2 class="text-center">Admin Registration</h2>

  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
  <% } %>

  <form action="adminRegister" method="post">
    <div class="mb-3">
      <label class="form-label">Name:</label>
      <input type="text" class="form-control" name="name" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Email:</label>
      <input type="email" class="form-control" name="email" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Password:</label>
      <input type="password" class="form-control" name="password" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Phone:</label>
      <input type="text" class="form-control" name="phone" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Role:</label>
      <select class="form-control" name="role" required>
        <option value="Super Admin">Super Admin</option>
        <option value="Driver">Driver</option>
      </select>
    </div>
    <button type="submit" class="btn btn-dark btn-block">Register</button>
  </form>

  <div class="mt-3 text-center">
<%--    <p>Already have an account? <a href="AdminLogin.jsp">Go to Login</a></p>--%>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

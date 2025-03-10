<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>
<%
  // Check if the admin is logged in
  HttpSession adminSession = request.getSession(false);
  if (adminSession == null || adminSession.getAttribute("adminEmail") == null) {
    response.sendRedirect("AdminLogin.jsp");
    return;
  }

  String adminEmail = (String) adminSession.getAttribute("adminEmail");

  // Database connection and query to get rejections
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
    stmt = conn.createStatement();
    String query = "SELECT * FROM notifications WHERE message LIKE 'Driver has rejected booking%'"; // Filter rejections
    rs = stmt.executeQuery(query);
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Rejected Rides</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
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



<div class="container mt-5">
  <h3 class="text-center">Rejected Rides</h3>
  <div class="alert alert-info text-center">
    <p>Here is the list of all rides that have been rejected by drivers.</p>
  </div>

  <!-- Table for displaying rejections -->
  <table class="table table-striped">
    <thead>
    <tr>
      <th>Booking ID</th>
      <th>Rejection Message</th>
      <th>Date</th>
      <th>Assign Ride</th>
    </tr>
    </thead>
    <tbody>
    <%
      while (rs.next()) {
        int bookingId = rs.getInt("booking_id");
        String rejectionMessage = rs.getString("message");
        String createdAt = rs.getString("created_at");
    %>
    <tr>
      <td><%= bookingId %></td>
      <td><%= rejectionMessage %></td>
      <td><%= createdAt %></td>
      <td>
        <a href="assigning.jsp?booking_id=<%= bookingId %>" class="btn btn-dark btn-sm">Assign Ride</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>

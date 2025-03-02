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
        <a href="assigning.jsp?booking_id=<%= bookingId %>" class="btn btn-primary btn-sm">Assign Ride</a>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>

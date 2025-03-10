<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>

<%
  // Check if admin is logged in
  HttpSession adminSession = request.getSession(false);
  if (adminSession == null || adminSession.getAttribute("adminEmail") == null) {
    response.sendRedirect("AdminLogin.jsp");
    return;
  }

  // Get booking_id from URL
  String bookingIdParam = request.getParameter("booking_id");
  int bookingId = 0;
  if (bookingIdParam != null) {
    bookingId = Integer.parseInt(bookingIdParam);
  } else {
    response.sendRedirect("RejectedRides.jsp");
    return;
  }

  // License type: auto or bike
  String requiredLicense = request.getParameter("license_type"); // 'auto' or 'bike'

  // Database connection
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

    // Fetch booking details
    String query = "SELECT * FROM bookings WHERE id = ?";
    pstmt = conn.prepareStatement(query);
    pstmt.setInt(1, bookingId);
    rs = pstmt.executeQuery();
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Assign Ride</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h3 class="text-center">Assign Ride</h3>

  <div class="card p-3">
    <h5>Booking Details</h5>
    <%
      if (rs != null && rs.next()) {
    %>
    <p><strong>Booking ID:</strong> <%= rs.getInt("id") %></p>
    <p><strong>Customer ID:</strong> <%= rs.getInt("customer_id") %></p>
    <p><strong>From:</strong> <%= rs.getString("from_location") %></p>
    <p><strong>To:</strong> <%= rs.getString("to_location") %></p>
    <p><strong>Trip Date:</strong> <%= rs.getString("trip_start_date") %> to <%= rs.getString("trip_end_date") %></p>
    <p><strong>Passengers:</strong> <%= rs.getInt("passenger_count") %></p>
    <p><strong>Payment Method:</strong> <%= rs.getString("payment_method") %></p>
    <p><strong>Total Price:</strong> $<%= rs.getDouble("total_price") %></p>

    <!-- Assign Driver Form -->
    <form action="processAssignRide.jsp" method="POST">
      <input type="hidden" name="booking_id" value="<%= bookingId %>">
      <div class="mb-3">
        <label for="driver_id" class="form-label">Select Driver:</label>
        <select name="driver_id" id="driver_id" class="form-control" required>
          <option value="">-- Choose Driver --</option>
          <%
            // Fetch available drivers based on the required license type (auto or bike)
            String licenseCondition = "";
            if ("auto".equals(requiredLicense)) {
              licenseCondition = "AND auto_license = 1"; // Drivers with auto license
            } else if ("bike".equals(requiredLicense)) {
              licenseCondition = "AND bike_license = 1"; // Drivers with bike license
            }

            Statement stmt2 = conn.createStatement();
            String driverQuery = "SELECT id, username FROM drivers WHERE availability = 'Available' " + licenseCondition;
            ResultSet rsDrivers = stmt2.executeQuery(driverQuery);

            while (rsDrivers.next()) {
          %>
          <option value="<%= rsDrivers.getInt("id") %>"><%= rsDrivers.getString("username") %></option>
          <%
            }
            rsDrivers.close();
            stmt2.close();
          %>
        </select>
      </div>
      <button type="submit" class="btn btn-success">Assign Ride</button>
    </form>
    <%
    } else {
    %>
    <p class="text-danger">No booking found for the given ID.</p>
    <%
      }
    %>
  </div>
</div>
</body>
</html>

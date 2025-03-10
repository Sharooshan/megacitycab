<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

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
<div class="container table-container">
    <h2 class="text-center mb-4">Manage Bookings</h2>

    <!-- Filter form -->
    <form method="get" action="manage_bookings.jsp">
        <div class="mb-3">
            <label for="booking_id" class="form-label">Booking ID:</label>
            <input type="text" class="form-control" id="booking_id" name="booking_id" placeholder="Enter Booking ID" value="<%= request.getParameter("booking_id") %>">
        </div>
        <div class="mb-3">
            <label for="customer_id" class="form-label">Customer ID:</label>
            <input type="text" class="form-control" id="customer_id" name="customer_id" placeholder="Enter Customer ID" value="<%= request.getParameter("customer_id") %>">
        </div>
<%--        <button type="submit" class="btn btn-primary">Filter</button>--%>
    </form>

    <br/>

    <form method="post" action="manage_bookings_action.jsp">
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
            <tr>
                <th>Select</th>
                <th>ID</th>
                <th>Customer Name</th>
                <th>NIC</th>
                <th>Phone</th>
                <th>Vehicle ID</th>
                <th>Trip Start Date</th>
                <th>Trip End Date</th>
                <th>From</th>
                <th>To</th>
                <th>Trip Time</th>
                <th>Passengers</th>
                <th>Payment Method</th>
                <th>Total Price</th>
                <th>Driver Name</th>
                <th>Driver Phone</th>
                <th>Driver Email</th>
                <th>Driver Address</th>
<%--                <th>Status</th>--%>
            </tr>
            </thead>
            <tbody>
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                String bookingIdFilter = request.getParameter("booking_id"); // Get the booking ID filter
                String customerIdFilter = request.getParameter("customer_id"); // Get the customer ID filter

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

                    // Modify the query to filter by booking_id and customer_id if provided
                    String query = "SELECT b.id, c.name AS customer_name, c.nic, c.phone, " +
                            "b.vehicle_id, b.trip_start_date, b.trip_end_date, " +
                            "b.from_location, b.to_location, b.trip_time, " +
                            "b.passenger_count, b.payment_method, " +
                            "b.total_price, b.status, " +
                            "d.username AS driver_name, d.contact_number AS driver_phone, " +
                            "d.email AS driver_email, d.address AS driver_address " +
                            "FROM bookings b " +
                            "JOIN customers c ON b.customer_id = c.id " +
                            "LEFT JOIN vehicle_driver_assignment vda ON b.vehicle_id = vda.vehicle_id " +
                            "LEFT JOIN drivers d ON vda.id = d.id";

                    // Apply the filters based on booking_id and customer_id if they exist
                    if (bookingIdFilter != null && !bookingIdFilter.isEmpty()) {
                        query += " WHERE b.id = ?";
                    }
                    if (customerIdFilter != null && !customerIdFilter.isEmpty()) {
                        if (bookingIdFilter != null && !bookingIdFilter.isEmpty()) {
                            query += " AND c.id = ?";
                        } else {
                            query += " WHERE c.id = ?";
                        }
                    }

                    PreparedStatement preparedStatement = con.prepareStatement(query);

                    // Set the parameters for the prepared statement
                    int parameterIndex = 1;
                    if (bookingIdFilter != null && !bookingIdFilter.isEmpty()) {
                        preparedStatement.setString(parameterIndex++, bookingIdFilter);
                    }
                    if (customerIdFilter != null && !customerIdFilter.isEmpty()) {
                        preparedStatement.setString(parameterIndex++, customerIdFilter);
                    }

                    rs = preparedStatement.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><input type="checkbox" name="selectedBookings" value="<%= rs.getInt("id") %>"></td>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("customer_name") %></td>
                <td><%= rs.getString("nic") %></td>
                <td><a href="tel:<%= rs.getString("phone") %>" class="btn btn-dark">Call <%= rs.getString("phone") %></a></td>
                <td><%= rs.getInt("vehicle_id") %></td>
                <td><%= rs.getDate("trip_start_date") %></td>
                <td><%= rs.getDate("trip_end_date") %></td>
                <td><%= rs.getString("from_location") %></td>
                <td><%= rs.getString("to_location") %></td>
                <td><%= rs.getString("trip_time") %></td>
                <td><%= rs.getInt("passenger_count") %></td>
                <td><%= rs.getString("payment_method") %></td>
                <td><%= rs.getDouble("total_price") %></td>
                <td><%= rs.getString("driver_name") %></td>
                <td><a href="tel:<%= rs.getString("driver_phone") %>" class="btn btn-success">Call</a></td>
                <td><a href="mailto:<%= rs.getString("driver_email") %>" class="btn btn-info">Email</a></td>
                <td><%= rs.getString("driver_address") %></td>
<%--                <td>--%>
<%--                    <select name="status_<%= rs.getInt("id") %>" class="form-select">--%>
<%--                        <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>--%>
<%--                        <option value="Accepted" <%= rs.getString("status").equals("Accepted") ? "selected" : "" %>>Accepted</option>--%>
<%--                        <option value="Rejected" <%= rs.getString("status").equals("Rejected") ? "selected" : "" %>>Rejected</option>--%>
<%--                        <option value="On-Ride" <%= rs.getString("status").equals("On-Ride") ? "selected" : "" %>>On-Ride</option>--%>
<%--                        <option value="Cancelled" <%= rs.getString("status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>--%>
<%--                        <option value="Completed" <%= rs.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>--%>
<%--                    </select>--%>
<%--                </td>--%>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                }
            %>
            </tbody>
        </table>
        <button type="submit" name="delete" class="btn btn-danger">Delete Selected</button>
<%--        <button type="submit" name="update" class="btn btn-primary">Update Status</button>--%>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

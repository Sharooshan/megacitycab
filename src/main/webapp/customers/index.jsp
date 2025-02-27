<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .navbar {
            margin-bottom: 30px;
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
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">JSP App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../customers/register.jsp">Register</a>
                </li>
                <li class="nav-item">
                    <% String customerEmail = (String) session.getAttribute("customerEmail"); %>
                    <% if (customerEmail != null) { %>
                    <a class="nav-link" href="logout">Logout</a>
                    <% } else { %>
                    <a class="nav-link" href="login.jsp">Login</a>
                    <% } %>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <h1>Welcome to the Customer Page</h1>
    <p>
        <% if (customerEmail != null) { %>
        Hello, <%= customerEmail %>! You are logged in.
        <% } else { %>
        You are not logged in. Please log in to access more features.
        <% } %>
    </p>

    <h2 class="mt-5">Select a Service</h2>
    <div class="btn-group mb-3">
        <button class="btn btn-primary" onclick="showVehicles('uber')">Uber (Colombo City)</button>
        <button class="btn btn-success" onclick="showVehicles('rental')">Rental Service (Colombo to Other Districts)</button>
    </div>

    <div id="vehicle-list">
        <h3>Available Vehicles</h3>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String serviceType = request.getParameter("serviceType"); // Get selected service type
            String query = "SELECT * FROM vehicles"; // Default to showing all vehicles

            if ("rental".equals(serviceType)) {
                query = "SELECT * FROM vehicles WHERE vehicle_type = 'Car'"; // Show only cars for rental
            }

            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String vehicleId = rs.getString("vehicle_id");
                    String vehicleType = rs.getString("vehicle_type");
                    String image = rs.getString("image");
                    String model = rs.getString("model");
                    String color = rs.getString("color");
                    String cc = rs.getString("cc");
                    String numberPlate = rs.getString("number_plate");
        %>
        <div class="vehicle-card">
            <h4><%= vehicleType %> - <%= model %></h4>
            <img src="<%= request.getContextPath() %>/images/<%= image %>" alt="<%= vehicleType %>" class="vehicle-img">
            <p><strong>Color:</strong> <%= color %></p>
            <p><strong>CC:</strong> <%= cc %></p>
            <p><strong>Number Plate:</strong> <%= numberPlate %></p>
            <% if (customerEmail != null) { %>
            <a href="book_vehicle.jsp?vehicle_id=<%= vehicleId %>" class="btn btn-success">Take Now</a>
            <% } %>
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
</div>

<script>
    function showVehicles(service) {
        window.location.href = "customer_page.jsp?serviceType=" + service;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>

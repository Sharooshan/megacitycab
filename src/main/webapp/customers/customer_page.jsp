<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffffff; /* Dark Gray background for high contrast */
            color: #1E1E1E; /* White text for readability */
            font-family: Arial, sans-serif; /* Clean font for better design */
        }

        .container {
            max-width: 1700px;
            margin-top: 50px;
            background-color: #FFFFFF; /* White background for the container */
            padding: 30px;
            border-radius: 12px; /* Slightly rounded corners */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); /* Subtle shadow for depth */
        }

        h1 {
            color: #FFCC00; /* Yellow for headings to keep consistent theme */
            font-size: 2rem; /* Larger font size for prominence */
            font-weight: bold;
        }

        .vehicle-card {
            margin-bottom: 20px;
            background-color: #ffffff; /* Dark Gray background for each vehicle card */
            color: #1E1E1E; /* White text for readability */
            border-radius: 12px; /* Rounded corners */
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Soft shadow for cards */
        }

        .vehicle-img {
            width: 650px;
            height: 500px;
            object-fit: cover;
            border-radius: 10px;
        }



        .navbar {
            background-color: #1E1E1E !important;
            padding: 15px 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Brand (Always Left-Aligned) */
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #FFCC00 !important;
        }

        /* Navbar Links */
        .navbar-nav {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-grow: 1; /* Pushes buttons to the center */
        }

        .navbar-nav .nav-link {
            color: #FFFFFF !important;
            font-size: 1.1rem;
            font-weight: 500;
            margin: 0 10px;
        }

        .navbar-nav .nav-link:hover {
            color: #FFCC00 !important;
        }

        /* Navbar - Logged In */
        .navbar-logged-in {
            background-color: #FFCC00 !important;
        }

        .navbar-logged-in .navbar-brand {
            color: #1E1E1E !important;
        }

        .navbar-logged-in .nav-link {
            color: #1E1E1E !important;
        }

        /* Center Navbar Buttons After Login */
        .navbar-logged-in .navbar-nav {
            justify-content: center;
            width: 100%;
        }

        /* Login Button (Visible Only Before Login) */
        .navbar .login-btn {
            display: block;
        }

        /* Hide Login Button After Login */
        .navbar-logged-in .login-btn {
            display: none;
        }

        /* Buttons */
        .navbar .btn {
            background-color: #FFCC00;
            color: #1E1E1E;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: bold;
            margin: 0 10px;
        }

        .navbar .btn:hover {
            background-color: #D9B000;
            color: #FFFFFF;
        }
        .d-flex .btn {
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 8px; /* Rounded corners for buttons */
            font-weight: bold;
        }

        .d-flex .btn-primary {
            background-color: #1E1E1E; /* Dark Gray primary button */
            color: #FFCC00; /* Yellow text */
            border: 2px solid #FFCC00; /* Yellow border */
        }

        .d-flex .btn-primary:hover {
            background-color: #FFCC00; /* Yellow on hover */
            color: #1E1E1E; /* Dark Gray text */
        }

        .d-flex .btn-success {
            background-color: #FFCC00; /* Yellow secondary button */
            color: #1E1E1E; /* Dark Gray text */
            border: 2px solid #1E1E1E; /* Dark Gray border */
        }

        .d-flex .btn-success:hover {
            background-color: #1E1E1E; /* Dark Gray on hover */
            color: #FFCC00; /* Yellow text */
        }

    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Brand Logo -->
        <a class="navbar-brand" href="index.jsp">Mega City Cab</a>

        <!-- Navbar Toggler (Mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp">Home</a>
                </li>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="../customers/register.jsp">Register</a>--%>
                <%--                </li>--%>
            </ul>

            <!-- Right Aligned Links (Login/Logout + Other Buttons) -->
            <div class="d-flex align-items-center">
                <% String customerEmail = (String) session.getAttribute("customerEmail"); %>
                <% Integer customerId = (Integer) session.getAttribute("customerId"); %>

                <% if (customerEmail != null) { %>
                <a class="btn btn-outline-light me-2" href="bookingStatus.jsp">Booking Status</a>
                <a class="btn btn-outline-light me-2" href="Add_feedback.jsp">Add Feedback</a>
                <a class="btn btn-warning text-dark px-3" href="logout">Logout</a>
                <% } else { %>
                <a class="btn btn-warning text-dark px-3" href="login.jsp">Login</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>


<div class="container">

        <h1 class="text-center" style="color: #FFCC00;">Welcome to the Customer Page</h1>

        <div class="card" style="background-color: #ffffff; color: #1E1E1E; border: 2px solid #FFCC00; border-radius: 10px; padding: 20px; margin-top: 30px;">
            <p class="text-center">
                <% if (customerEmail != null && customerId != null) { %>
                <span style="font-size: 1.2rem;">Hello, <%= customerEmail %>!</span>
                <br>Your Customer ID: <%= customerId %>
                <br>You are logged in.
                <% } else { %>
                <span style="font-size: 1.2rem;">You are not logged in.</span>
                <br>Please log in to access more features.
                <% } %>
            </p>

    </div>


    <div class="d-flex gap-2">
        <a href="customer_page.jsp?serviceType=uber" class="btn btn-primary">Uber (Colombo City)</a>
        <a href="customer_page.jsp?serviceType=rental" class="btn btn-success">Rental Service (Outside Colombo)</a>
    </div>


    <div class="row">
        <%
            String serviceType = request.getParameter("serviceType");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                String query = "SELECT * FROM vehicles v WHERE NOT EXISTS ( " +
                        "SELECT 1 FROM bookings b WHERE b.vehicle_id = v.vehicle_id " +
                        "AND b.status = 'Accepted' AND CURDATE() BETWEEN b.trip_start_date AND b.trip_end_date)";
                if ("rental".equals(serviceType)) {
                    query += " AND v.vehicle_type = 'Car'";
                }
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
        <div class="col-md-6">
            <div class="card vehicle-card">
                <img src="<%= request.getContextPath() %>/images/<%= image %>" class="card-img-top vehicle-img" alt="<%= vehicleType %>">
                <div class="card-body">
                    <h5 class="card-title"><%= vehicleType %> - <%= model %></h5>
                    <p class="card-text"><strong>Color:</strong> <%= color %></p>
                    <p class="card-text"><strong>CC:</strong> <%= cc %></p>
                    <p class="card-text"><strong>Number Plate:</strong> <%= numberPlate %></p>
                    <% if (customerEmail != null) { %>
                    <a href="book_vehicle.jsp?vehicle_id=<%= vehicleId %>&serviceType=<%= serviceType %>&customer_id=<%= customerId %>" class="btn btn-warning">Take Now</a>
                    <% } %>
                </div>
            </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>

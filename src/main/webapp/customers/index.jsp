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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        /* General Styles */
        body {
            background: #1E1E1E;
            font-family: 'Poppins', sans-serif;
            color: #FFFFFF;
        }

        /* Container */
        .container {
            max-width: 1800px;
            margin: 50px auto; /* Center the container horizontally and add a top margin */
            background-color: #D3D3D3;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            color: #1E1E1E;

            /* Flexbox properties to center content */
            display: flex;
            justify-content: center; /* Horizontally centers the content */
            align-items: center; /* Vertically centers the content */
            flex-direction: column; /* Ensures the content stacks vertically if needed */
            height: 50vh; /* Ensures full viewport height for vertical centering */
        }


        /* Navbar - Default (Logged Out) */
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


        /* Vehicle Cards */
        .vehicle-card {
            background: #262626;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s;
            color: #FFFFFF;
        }

        .vehicle-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
        }

        .vehicle-img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            border: 3px solid #FFCC00;
        }

        /* Buttons */
        .btn-group .btn {
            padding: 12px 20px;
            font-weight: 600;
            border-radius: 8px;
        }

        .btn-primary {
            background-color: #FFCC00;
            color: #1E1E1E;
            border: none;
        }

        .btn-primary:hover {
            background-color: #D9B000;
            color: #FFFFFF;
        }

        .btn-success {
            background-color: #00796B;
            border: none;
        }

        .btn-success:hover {
            background-color: #005A4E;
        }

        /* List Group */
        .list-group-item {
            background-color: transparent;
            color: #FFFFFF;
            border: none;
            font-size: 1.1rem;
        }

        /* Moving Text Banner */
        .moving-text-container {
            width: 100%;
            overflow: hidden;
            background: #FFCC00;
            padding: 10px 0;
            color: #1E1E1E;
            font-size: 1.2rem;
            font-weight: bold;
            text-align: center;
            position: relative;
            white-space: nowrap;
        }

        .moving-text {
            display: inline-block;
            white-space: nowrap;
            animation: marquee 15s linear infinite;
        }

        @keyframes marquee {
            from {
                transform: translateX(100%);
            }
            to {
                transform: translateX(-100%);
            }
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
<!-- Moving text (Marquee effect) -->
<div class="moving-text-container">
    <p class="moving-text">
        🚖 Welcome to Mega City Cab - The Best Taxi Service in Colombo! Book your ride now and travel comfortably. 🚖
    </p>
</div>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Brand Logo -->
        <a class="navbar-brand" href="#">Mega City Cab</a>

        <!-- Navbar Toggler (Mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#">Home</a>
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

        <div class="btn-group mb-3">
            <button class="btn btn-primary" onclick="showVehicles('uber')">Uber (Colombo City)</button>
            <button class="btn btn-success" onclick="showVehicles('rental')">Rental Service (Colombo to Other Districts)</button>
        </div>

    </div>

<%--    <div id="vehicle-list">--%>
<%--        <h3>Available Vehicles</h3>--%>
<%--        <%--%>
<%--            Connection conn = null;--%>
<%--            PreparedStatement ps = null;--%>
<%--            ResultSet rs = null;--%>

<%--            String serviceType = request.getParameter("serviceType"); // Get selected service type--%>
<%--            String query = "SELECT * FROM vehicles"; // Default to showing all vehicles--%>

<%--            if ("rental".equals(serviceType)) {--%>
<%--                query = "SELECT * FROM vehicles WHERE vehicle_type = 'Car'"; // Show only cars for rental--%>
<%--            }--%>

<%--            try {--%>
<%--                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");--%>
<%--                ps = conn.prepareStatement(query);--%>
<%--                rs = ps.executeQuery();--%>

<%--                while (rs.next()) {--%>
<%--                    String vehicleId = rs.getString("vehicle_id");--%>
<%--                    String vehicleType = rs.getString("vehicle_type");--%>
<%--                    String image = rs.getString("image");--%>
<%--                    String model = rs.getString("model");--%>
<%--                    String color = rs.getString("color");--%>
<%--                    String cc = rs.getString("cc");--%>
<%--                    String numberPlate = rs.getString("number_plate");--%>
<%--        %>--%>
<%--        <div class="vehicle-card">--%>
<%--            <h4><%= vehicleType %> - <%= model %></h4>--%>
<%--            <img src="<%= request.getContextPath() %>/images/<%= image %>" alt="<%= vehicleType %>" class="vehicle-img">--%>
<%--            <p><strong>Color:</strong> <%= color %></p>--%>
<%--            <p><strong>CC:</strong> <%= cc %></p>--%>
<%--            <p><strong>Number Plate:</strong> <%= numberPlate %></p>--%>
<%--            <% if (customerEmail != null) { %>--%>
<%--&lt;%&ndash;            <a href="book_vehicle.jsp?vehicle_id=<%= vehicleId %>&customer_id=<%= customerId %>" class="btn btn-success">Take Now</a>&ndash;%&gt;--%>

<%--            <% } %>--%>
<%--        </div>--%>
<%--        <%--%>
<%--                }--%>
<%--            } catch (SQLException e) {--%>
<%--                e.printStackTrace();--%>
<%--            } finally {--%>
<%--                try {--%>
<%--                    if (rs != null) rs.close();--%>
<%--                    if (ps != null) ps.close();--%>
<%--                    if (conn != null) conn.close();--%>
<%--                } catch (SQLException e) {--%>
<%--                    e.printStackTrace();--%>
<%--                }--%>
<%--            }--%>
<%--        %>--%>
<%--    </div>--%>
</div>

<script>
    function showVehicles(service) {
        var customerId = <%= customerId != null ? customerId : "null" %>;
        if (customerId !== "null") {
            window.location.href = "customer_page.jsp?serviceType=" + service + "&customerId=" + customerId;
        } else {
            alert("Please log in first.");
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>

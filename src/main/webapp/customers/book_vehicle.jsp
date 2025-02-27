<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Vehicle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .container {
            max-width: 900px; margin-top: 50px; background-color: #ffffff;
            padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 { color: #007bff; }
        .vehicle-card {
            margin-bottom: 20px; border: 1px solid #ddd; padding: 15px;
            border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .vehicle-img { max-width: 100%; height: auto; border-radius: 10px; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">JSP App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <h1>Book a Vehicle</h1>

    <%
        String vehicle_id = request.getParameter("vehicle_id");
        String serviceType = request.getParameter("serviceType");
        if (vehicle_id != null && !vehicle_id.isEmpty()) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String query = "SELECT * FROM vehicles WHERE vehicle_id = ?";
            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                ps = conn.prepareStatement(query);
                ps.setString(1, vehicle_id);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String vehicleType = rs.getString("vehicle_type");
                    String image = rs.getString("image");
                    String model = rs.getString("model");
                    String color = rs.getString("color");
                    String cc = rs.getString("cc");
                    String numberPlate = rs.getString("number_plate");
                    String driverId = rs.getString("driver_id");

                    String driverName = "";
                    String driverMobile = "";
                    if (driverId != null) {
                        PreparedStatement driverStmt = conn.prepareStatement("SELECT * FROM drivers WHERE id = ?");
                        driverStmt.setString(1, driverId);
                        ResultSet driverRs = driverStmt.executeQuery();
                        if (driverRs.next()) {
                            driverName = driverRs.getString("username");
                            driverMobile = driverRs.getString("contact_number");
                        }
                    }
    %>

    <div class="vehicle-card">
        <h4><%= vehicleType %> - <%= model %></h4>
        <img src="<%= request.getContextPath() %>/images/<%= image %>" alt="<%= vehicleType %>" class="vehicle-img">
        <p><strong>Color:</strong> <%= color %></p>
        <p><strong>CC:</strong> <%= cc %></p>
        <p><strong>Number Plate:</strong> <%= numberPlate %></p>
        <p><strong>Driver Name:</strong> <%= driverName %></p>
        <p><strong>Driver Mobile:</strong> <%= driverMobile %></p>

        <form action="confirm_booking.jsp" method="post" id="bookingForm">
            <input type="hidden" name="vehicle_id" value="<%= vehicle_id %>">

            <label>From Location:</label>
            <select name="from_location" id="fromLocation" class="form-control" onchange="calculatePrice()">
                <% if (serviceType.equalsIgnoreCase("rental")) { %>
                <option value="Colombo">Colombo</option>
                <option value="Kandy">Kandy</option>
                <option value="Galle">Galle</option>
                <option value="Anuradhapura">Anuradhapura</option>
                <option value="Jaffna">Jaffna</option>
                <% } else if (serviceType.equalsIgnoreCase("uber")) { %>
                <option value="Pettah">Pettah</option>
                <option value="Wellawatte">Wellawatte</option>
                <option value="Bambalapitiya">Bambalapitiya</option>
                <option value="Nugegoda">Nugegoda</option>
                <option value="Dehiwala">Dehiwala</option>
                <% } %>
            </select>

            <label>To Location:</label>
            <select name="to_location" id="toLocation" class="form-control" onchange="calculatePrice()">
                <% if (serviceType.equalsIgnoreCase("rental")) { %>
                <option value="Kandy">Kandy</option>
                <option value="Galle">Galle</option>
                <option value="Jaffna">Jaffna</option>
                <option value="Anuradhapura">Anuradhapura</option>
                <option value="Trincomalee">Trincomalee</option>
                <% } else if (serviceType.equalsIgnoreCase("uber")) { %>
                <option value="Pettah">Pettah</option>
                <option value="Wellawatte">Wellawatte</option>
                <option value="Bambalapitiya">Bambalapitiya</option>
                <option value="Nugegoda">Nugegoda</option>
                <option value="Dehiwala">Dehiwala</option>
                <% } %>
            </select>

            <label>Trip Date:</label>
            <input type="date" name="trip_date" required class="form-control">

            <label>Trip Time:</label>
            <input type="time" name="trip_time" required class="form-control">

            <label>Passenger Count:</label>
            <input type="number" name="passenger_count" required class="form-control"
                   min="1" max="<%= vehicleType.equalsIgnoreCase("Bike") ? 1 : vehicleType.equalsIgnoreCase("Auto") ? 3 : 4 %>">

            <label>Payment Method:</label>
            <select name="payment_method" class="form-control">
                <% if (serviceType.equalsIgnoreCase("rental")) { %>
                <option value="Online Payment">Online Payment</option>
                <% } else if (serviceType.equalsIgnoreCase("uber")) { %>
                <option value="Cash on Hand (LKR)">Cash on Hand (LKR)</option>
                <% } %>
            </select>
            <div id="totalPriceDiv">
                <p>Total Price: <span id="totalPrice">0</span> LKR</p>
            </div>

            <!-- Discount Section -->
            <div id="discountDiv" style="display:none; padding-top: 10px;">
                <p><strong>Discount Applied: <span id="discountAmount">0.00</span> LKR</strong></p>
            </div>

            <button type="submit" class="btn btn-success">Confirm Booking</button>
        </form>
    </div>

    <script>
        var priceList = {
            rental: {
                "Colombo-Kandy": 5000,
                "Colombo-Galle": 4000,
                "Colombo-Anuradhapura": 7000,
                "Colombo-Jaffna": 8000,
                // Add more routes here...
            },
            uber: {
                "Pettah-Wellawatte": 1000,
                "Pettah-Bambalapitiya": 800,
                // Add more routes here...
            }
        };

        function calculatePrice() {
            var fromLocation = document.getElementById('fromLocation').value;
            var toLocation = document.getElementById('toLocation').value;
            var serviceType = "<%= serviceType %>";
            var discountAmount = 0;

            if (fromLocation && toLocation) {
                var routeKey = fromLocation + "-" + toLocation;
                var totalPrice = 0;

                if (serviceType === "rental" && priceList.rental[routeKey]) {
                    totalPrice = priceList.rental[routeKey];
                } else if (serviceType === "uber" && priceList.uber[routeKey]) {
                    totalPrice = priceList.uber[routeKey];
                }

                // Apply discount for rental if the booking is more than 1 day
                var tripDate = document.getElementsByName("trip_date")[0].value;
                var tripDateObj = new Date(tripDate);
                var today = new Date();
                var differenceInDays = Math.ceil((tripDateObj - today) / (1000 * 3600 * 24));

                if (serviceType === "rental" && differenceInDays > 1) {
                    discountAmount = (totalPrice * 0.10); // 10% discount
                    totalPrice -= discountAmount; // Subtract the discount
                    document.getElementById("discountDiv").style.display = "block";
                    document.getElementById("discountAmount").innerText = discountAmount.toFixed(2);
                } else {
                    document.getElementById("discountDiv").style.display = "none"; // Hide discount section if not eligible
                }

                document.getElementById("totalPrice").innerText = totalPrice.toFixed(2);
            }
        }

        window.onload = calculatePrice;
    </script>

    <% } } catch (SQLException e) { e.printStackTrace(); } finally {
        if (rs != null) try { rs.close(); } catch (SQLException se) {}
        if (ps != null) try { ps.close(); } catch (SQLException se) {}
        if (conn != null) try { conn.close(); } catch (SQLException se) {}
    }} %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

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
                <% String customerEmail = (String) session.getAttribute("customerEmail"); %>
                <% Integer customerId = (Integer) session.getAttribute("customerId"); %>

                <% if (customerEmail != null) { %>
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

    <h4><%= vehicleType %> - <%= model %></h4>
    <img src="<%= request.getContextPath() %>/images/<%= image %>" alt="<%= vehicleType %>" class="vehicle-img">
    <p><strong>Color:</strong> <%= color %></p>
    <p><strong>CC:</strong> <%= cc %></p>
    <p><strong>Number Plate:</strong> <%= numberPlate %></p>
    <p><strong>Driver Name:</strong> <%= driverName %></p>
    <p><strong>Driver Mobile:</strong> <%= driverMobile %></p>

    <form action="confirm_booking.jsp" method="post" id="bookingForm">
        <input type="hidden" name="vehicle_id" value="<%= vehicle_id %>">
        <input type="hidden" name="customer_id" value="<%= customerId %>"> <!-- Pass customer ID here -->
        <!-- Add hidden input for total price -->
        <input type="hidden" name="total_price" id="totalPriceHidden">
        <label>Trip Date (start):</label>
        <input type="date" id="trip_start_date" name="trip_start_date" required class="form-control">

        <script>
            document.getElementById("trip_start_date").setAttribute("min", new Date().toISOString().split('T')[0]);
        </script>

        <label>Trip Date (end):</label>
        <input type="date" id="trip_end_date" name="trip_end_date" required class="form-control">

        <script>
            document.getElementById("trip_start_date").addEventListener("change", function () {
                let startDate = document.getElementById("trip_start_date").value;
                document.getElementById("trip_end_date").min = startDate; // Set min date for end date
            });

            document.getElementById("trip_end_date").addEventListener("change", function () {
                let startDate = new Date(document.getElementById("trip_start_date").value);
                let endDate = new Date(document.getElementById("trip_end_date").value);

                if (endDate < startDate) {
                    alert("End date must be after the start date!");
                    document.getElementById("trip_end_date").value = ""; // Clear invalid input
                }
            });
        </script>
        <label>From Location:</label>
        <select name="from_location" id="fromLocation" class="form-control" onchange="calculatePrice()">
            <% if (serviceType.equalsIgnoreCase("rental")) { %>
            <option value="Colombo">Colombo</option>
            <option value="Kandy">Kandy</option>
            <option value="Galle">Galle</option>
            <option value="Anuradhapura">Anuradhapura</option>
            <option value="Jaffna">Jaffna</option>
            <option value="Nuwara Eliya">Nuwara Eliya</option>
            <option value="Batticaloa">Batticaloa</option>
            <option value="Trincomalee">Trincomalee</option>
            <option value="Matara">Matara</option>
            <option value="Badulla">Badulla</option>
            <option value="Kurunegala">Kurunegala</option>
            <% } else if (serviceType.equalsIgnoreCase("uber")) { %>
            <option value="Pettah">Pettah</option>
            <option value="Wellawatte">Wellawatte</option>
            <option value="Bambalapitiya">Bambalapitiya</option>
            <option value="Nugegoda">Nugegoda</option>
            <option value="Dehiwala">Dehiwala</option>
            <option value="Mount Lavinia">Mount Lavinia</option>
            <option value="Maharagama">Maharagama</option>
            <option value="Kottawa">Kottawa</option>
            <option value="Malabe">Malabe</option>
            <option value="Ratmalana">Ratmalana</option>
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
            <option value="Nuwara Eliya">Nuwara Eliya</option>
            <option value="Batticaloa">Batticaloa</option>
            <option value="Matara">Matara</option>
            <option value="Badulla">Badulla</option>
            <option value="Kurunegala">Kurunegala</option>
            <% } else if (serviceType.equalsIgnoreCase("uber")) { %>
            <option value="Pettah">Pettah</option>
            <option value="Wellawatte">Wellawatte</option>
            <option value="Bambalapitiya">Bambalapitiya</option>
            <option value="Nugegoda">Nugegoda</option>
            <option value="Dehiwala">Dehiwala</option>
            <option value="Mount Lavinia">Mount Lavinia</option>
            <option value="Maharagama">Maharagama</option>
            <option value="Kottawa">Kottawa</option>
            <option value="Malabe">Malabe</option>
            <option value="Ratmalana">Ratmalana</option>
            <% } %>
        </select>



        <label>Trip Time:</label>
        <input type="time" id="trip_time" name="trip_time" required class="form-control">

        <script>
            const timeInput = document.getElementById("trip_time");
            timeInput.setAttribute("min", "06:00");
            timeInput.setAttribute("max", "19:00");
        </script>


        <label>Passenger Count:</label>
        <input type="number" name="passenger_count" required class="form-control"
               min="1" max="<%= vehicleType.equalsIgnoreCase("Bike") ? 1 : vehicleType.equalsIgnoreCase("Auto") ? 3 : 4 %>">

        <label>Payment Method:</label>
        <select name="payment_method" class="form-control">
            <option value="Online Payment">Online Payment</option>
        </select>

        <div id="totalPriceDiv">
            <p>Total Price: <span id="totalPrice">0</span> LKR</p>
        </div>

        <!-- Discount Section -->
        <div id="discountDiv" style="display:none; padding-top: 10px;">
            <p><strong>Discount Applied: <span id="discountAmount">0.00</span> LKR</strong></p>
        </div>

        <button type="submit" class="btn btn-success">Confirm Booking</button>

        <script>
            var priceList = {
                rental: {
                    "Colombo-Kandy": 5000,
                    "Colombo-Galle": 4000,
                    "Colombo-Anuradhapura": 7000,
                    "Colombo-Jaffna": 8000,
                    "Colombo-Nuwara Eliya": 5500,
                    "Colombo-Batticaloa": 7500,
                    "Colombo-Trincomalee": 7200,
                    "Colombo-Matara": 4500,
                    "Colombo-Badulla": 6000,
                    "Colombo-Kurunegala": 3500,
                    "Kandy-Galle": 2000,
                    "Kandy-Anuradhapura": 4500,
                    "Kandy-Jaffna": 6000,
                    "Galle-Kandy": 2000,
                    "Galle-Trincomalee": 3500,
                    "Badulla-Kandy": 3500,
                    // Add all other combinations...
                },
                uber: {
                    "Pettah-Wellawatte": 1000,
                    "Pettah-Bambalapitiya": 800,
                    "Colombo-Fort": 700,
                    "Colombo-Malabe": 1500,
                    "Colombo-Nugegoda": 1200,
                    "Colombo-Ratmalana": 1600,
                    "Colombo-Dehiwala": 1100,
                    "Colombo-Mount Lavinia": 1300,
                    "Colombo-Maharagama": 1400,
                    "Colombo-Kottawa": 1700,
                    "Wellawatte-Bambalapitiya": 700,
                    "Nugegoda-Maharagama": 900,
                    "Malabe-Kottawa": 1200,
                    // Add all other combinations...
                }
            };


            function calculatePrice() {
            var fromLocation = document.getElementById('fromLocation').value;
            var toLocation = document.getElementById('toLocation').value;
            var serviceType = "<%= serviceType %>";
            var discountAmount = 0;

            if (fromLocation && toLocation) {
                var routeKey = fromLocation + "-" + toLocation;
                var basePrice = 0;

                if (serviceType === "rental" && priceList.rental[routeKey]) {
                    basePrice = priceList.rental[routeKey];
                } else if (serviceType === "uber" && priceList.uber[routeKey]) {
                    basePrice = priceList.uber[routeKey];
                }

                var totalPrice = basePrice;
                var tripStartDate = document.getElementById("trip_start_date").value;
                var tripEndDate = document.getElementById("trip_end_date").value;

                if (tripStartDate && tripEndDate) {
                    var startDateObj = new Date(tripStartDate);
                    var endDateObj = new Date(tripEndDate);
                    var timeDiff = endDateObj - startDateObj;
                    var dayDiff = timeDiff / (1000 * 3600 * 24) + 1; // Include the starting day

                    totalPrice = basePrice * dayDiff; // Multiply by the number of days

                    if (dayDiff > 1) {
                        discountAmount = totalPrice * 0.1; // 10% discount for multi-day rentals
                        totalPrice -= discountAmount;
                    }
                }

                // Update the displayed total price
                document.getElementById('totalPrice').innerText = totalPrice.toFixed(2);
                document.getElementById('totalPriceHidden').value = totalPrice.toFixed(2); // Update the hidden field for total price
                if (discountAmount > 0) {
                    document.getElementById('discountDiv').style.display = 'block';
                    document.getElementById('discountAmount').innerText = discountAmount.toFixed(2);
                } else {
                    document.getElementById('discountDiv').style.display = 'none';
                }
            }
        }

    </script>


    <%
                } else {
                    out.println("<p>Vehicle not found.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Clean up resources
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }}}
    %>
</div>
</body>
</html>

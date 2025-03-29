<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%@ page import="com.example.megacitycab.driver.dao.Vehicle" %>

<%
  List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
  String driverId = request.getAttribute("driverId").toString();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Driver's Vehicles</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 20px;
    }

    .vehicle-card {
      display: inline-block;
      width: 200px;
      margin: 10px;
      padding: 10px;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      text-align: center;
      transition: transform 0.2s;
    }

    .vehicle-card:hover {
      transform: scale(1.05);
    }

    .vehicle-img {
      width: 100%;
      height: 120px;
      object-fit: cover;
      border-radius: 8px;
    }

    .vehicle-card h4 {
      font-size: 16px;
      color: #333;
      margin: 10px 0;
    }

    .error {
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>

<h2>Vehicles for Driver ID: <%= driverId %></h2>

<%
  if (vehicles == null || vehicles.isEmpty()) {
%>
<p class="error">No vehicles found for this driver.</p>
<%
} else {
%>
<div class="vehicle-cards-container">
  <%
    for (Vehicle vehicle : vehicles) {
  %>
  <div class="vehicle-card">
    <h4><%= vehicle.getVehicleType() %> - <%= vehicle.getModel() %></h4>
    <img src="<%= request.getContextPath() %>/images/<%= vehicle.getImage() %>" alt="<%= vehicle.getVehicleType() %>" class="vehicle-img">
    <p>Color: <%= vehicle.getColor() %></p>
    <p>CC: <%= vehicle.getCc() %></p>
    <p>Plate: <%= vehicle.getNumberPlate() %></p>
  </div>
  <%
    }
  %>
</div>
<%
  }
%>

</body>
</html>

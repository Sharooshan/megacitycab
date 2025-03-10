<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>

<%
    // Retrieve the driver_id from the request
    String driverId = request.getParameter("driver_id");

    // Validate driver_id input
    if (driverId == null || driverId.isEmpty()) {
        response.sendRedirect("error.jsp?message=Driver ID is required");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String dbURL = "jdbc:mysql://localhost:3306/megacitycab";
    String dbUser = "root";
    String dbPassword = "";

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Query to get vehicles for the driver
        String sql = "SELECT * FROM vehicles WHERE driver_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(driverId));
        rs = pstmt.executeQuery();

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
    // If no vehicles are found
    if (!rs.isBeforeFirst()) {
%>
<p class="error">No vehicles found for this driver.</p>
<%
} else {
%>
<div class="vehicle-cards-container">
    <%
        // Loop through the result set and display each vehicle in a card format
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
        <p>Color: <%= color %></p>
        <p>CC: <%= cc %></p>
        <p>Plate: <%= numberPlate %></p>
    </div>
    <%
        }
    %>
</div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?message=" + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vehicle</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #007bff;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Edit Vehicle</h1>
    <br/>
    <%
        String vehicleId = request.getParameter("vehicle_id");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM vehicles WHERE vehicle_id = ?"; // Assuming vehicle_id is the unique identifier

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            ps = conn.prepareStatement(query);
            ps.setString(1, vehicleId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String vehicleType = rs.getString("vehicle_type");
                String model = rs.getString("model");
                String color = rs.getString("color");
                String cc = rs.getString("cc");
                String numberPlate = rs.getString("number_plate");
    %>
    <form action="updateVehicle.jsp" method="post">
        <input type="hidden" name="vehicle_id" value="<%= vehicleId %>">
        <div class="mb-3">
            <label for="vehicleType" class="form-label">Vehicle Type</label>
            <input type="text" class="form-control" id="vehicleType" name="vehicle_type" value="<%= vehicleType %>" required>
        </div>
        <div class="mb-3">
            <label for="model" class="form-label">Model</label>
            <input type="text" class="form-control" id="model" name="model" value="<%= model %>" required>
        </div>
        <div class="mb-3">
            <label for="color" class="form-label">Color</label>
            <input type="text" class="form-control" id="color" name="color" value="<%= color %>" required>
        </div>
        <div class="mb-3">
            <label for="cc" class="form-label">CC</label>
            <input type="text" class="form-control" id="cc" name="cc" value="<%= cc %>" required>
        </div>
        <div class="mb-3">
            <label for="numberPlate" class="form-label">Number Plate</label>
            <input type="text" class="form-control" id="numberPlate" name="number_plate" value="<%= numberPlate %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Vehicle</button>
    </form>
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

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Vehicle</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <h1>Vehicle Updated</h1>
    <br/>
    <%
        String vehicleId = request.getParameter("vehicle_id");
        String vehicleType = request.getParameter("vehicle_type");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        String cc = request.getParameter("cc");
        String numberPlate = request.getParameter("number_plate");

        Connection conn = null;
        PreparedStatement ps = null;

        String query = "UPDATE vehicles SET vehicle_type = ?, model = ?, color = ?, cc = ?, number_plate = ? WHERE vehicle_id = ?";

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            ps = conn.prepareStatement(query);
            ps.setString(1, vehicleType);
            ps.setString(2, model);
            ps.setString(3, color);
            ps.setString(4, cc);
            ps.setString(5, numberPlate);
            ps.setString(6, vehicleId);

            int result = ps.executeUpdate();

            if (result > 0) {
    %>
    <div class="alert alert-success">Vehicle details updated successfully!</div>
    <%
    } else {
    %>
    <div class="alert alert-danger">Error updating vehicle details.</div>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <a href="VehicleList.jsp" class="btn btn-primary">Back to Vehicle List</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>

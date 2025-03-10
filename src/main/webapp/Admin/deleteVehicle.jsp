<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Vehicle</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <h1>Delete Vehicle</h1>
    <br/>
    <%
        String vehicleId = request.getParameter("vehicle_id");

        Connection conn = null;
        PreparedStatement ps = null;
        String query = "DELETE FROM vehicles WHERE vehicle_id = ?";

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            ps = conn.prepareStatement(query);
            ps.setString(1, vehicleId);

            int result = ps.executeUpdate();

            if (result > 0) {
    %>
    <div class="alert alert-success">Vehicle deleted successfully!</div>
    <%
    } else {
    %>
    <div class="alert alert-danger">Error deleting vehicle.</div>
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

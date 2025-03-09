<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Bookings Action</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2 class="text-center mb-4">Manage Bookings Action</h2>
    <%
        // Database connection variables
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        // Get the request parameters for action
        String[] selectedBookings = request.getParameterValues("selectedBookings");
        String updateAction = request.getParameter("update");
        String deleteAction = request.getParameter("delete");

        try {
            // Load database driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

            // Process the update action (update booking status)
            if (updateAction != null && selectedBookings != null) {
                for (String bookingId : selectedBookings) {
                    String status = request.getParameter("status_" + bookingId);
                    // Prepare SQL update query
                    String updateQuery = "UPDATE bookings SET status = ? WHERE id = ?";
                    stmt = con.prepareStatement(updateQuery);
                    stmt.setString(1, status);
                    stmt.setInt(2, Integer.parseInt(bookingId));
                    stmt.executeUpdate();
                }
                out.println("<div class='alert alert-success'>Booking statuses updated successfully.</div>");
            }

            // Process the delete action (delete selected bookings)
            if (deleteAction != null && selectedBookings != null) {
                for (String bookingId : selectedBookings) {
                    // Prepare SQL delete query
                    String deleteQuery = "DELETE FROM bookings WHERE id = ?";
                    stmt = con.prepareStatement(deleteQuery);
                    stmt.setInt(1, Integer.parseInt(bookingId));
                    stmt.executeUpdate();
                }
                out.println("<div class='alert alert-danger'>Selected bookings deleted successfully.</div>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>An error occurred while processing your request.</div>");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <!-- Button to go back to the manage bookings page -->
    <a href="manage_bookings.jsp" class="btn btn-primary">Go Back</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

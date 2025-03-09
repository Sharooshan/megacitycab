<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Submission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container my-5">
    <h2 class="text-center">Feedback Submitted</h2>
    <%
        String customerId = request.getParameter("customer_id");
        String driverId = request.getParameter("driver_id");
        String rating = request.getParameter("rating");
        String feedback = request.getParameter("feedback");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Establishing database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

            // SQL query to insert the feedback into the 'feedback' table
            String query = "INSERT INTO feedback (customer_id, driver_id, rating, feedback) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(query);

            // Setting parameters to prevent SQL injection
            ps.setInt(1, Integer.parseInt(customerId));  // Set customer ID
            ps.setInt(2, Integer.parseInt(driverId));     // Set driver ID
            ps.setInt(3, Integer.parseInt(rating));       // Set rating
            ps.setString(4, feedback);                    // Set feedback text

            // Execute the query and check if the feedback was inserted
            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<div class='alert alert-success'>Your feedback has been submitted successfully!</div>");
            } else {
                out.println("<div class='alert alert-danger'>An error occurred while submitting your feedback.</div>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>An error occurred: " + e.getMessage() + "</div>");
        } finally {
            // Closing the database resources
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    %>
    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-outline-primary">Go to Home</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

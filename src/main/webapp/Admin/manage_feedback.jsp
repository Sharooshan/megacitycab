<%@ page import="java.sql.*, javax.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Feedback</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <style>

    </style>

</head>
<style>
    .feedback-container {
        float: right; /* Moves the container to the right */
        width: 50%; /* Adjust width as needed */
        margin-left: auto;
        margin-right: 20px; /* Adds some spacing from the right edge */
    }

    @media (max-width: 768px) {
        .feedback-container {
            width: 100%; /* Full width on smaller screens */
            float: none;
            margin: 0 auto;
        }
    }


    .feedback-card {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        background-color: #f9f9f9;
    }
    .rating {
        color: gold;
    }
    .feedback-actions {
        margin-top: 10px;
    }
    .reply-input {
        width: 100%;
        margin-top: 10px;
        padding: 10px;
        font-size: 1em;
    }
    body {
        background-color: #f8f9fa;
    }
    .container {
        max-width: 1200px;
        margin-top: 50px;
        background-color: #ffffff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .vehicle-card {
        margin-bottom: 20px;
        border: 1px solid #ddd;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .vehicle-img {
        max-width: 100%;
        height: auto;
        border-radius: 10px;
    }
    body {
        background-color: #ffffff;
        color: #000000;
        font-family: Arial, sans-serif;
    }
    .sidebar {
        width: 250px;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        background-color: #000000;
        color: #ffffff;
        padding-top: 20px;
    }
    .sidebar a {
        display: block;
        color: #ffffff;
        padding: 15px;
        text-decoration: none;
        transition: 0.3s;
    }
    .sidebar a:hover {
        background-color: #555;
    }
    .content {
        margin-left: 260px;
        padding: 20px;
    }
    .card {
        border: none;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
</style>
<!-- Sidebar Navigation -->
<div class="sidebar">
    <h4 class="text-center">MegaCityCab - Admin</h4>
    <a href="AdminDashboard.jsp">Dashboard</a>
    <a href="assigning.jsp" >Assigning Drivers</a>
    <a href="register.jsp" >Register Drivers</a>
    <a href="admin_register.jsp">Register Admins</a>
    <a href="viewRejections.jsp">Check Ride Rejections</a>
    <a href="vehicleList.jsp">Manage Vehicles</a>
    <a href="manageBookings.jsp">Manage Bookings</a>
    <a href="driver_available_check.jsp">Driver Availability</a>
    <a href="manage_feedback.jsp">Manage Feedback</a>
    <a href="AddVehicle.jsp">Manage Vehicles</a>

    <a href="AdminLogoutServlet">Logout</a>
</div>



<body>
<h1>Manage Customer Feedback</h1>

<%
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String deleteFeedbackId = request.getParameter("delete_id");
    String replyFeedbackId = request.getParameter("reply_id");
    String replyText = request.getParameter("reply_text");

    // Deleting feedback
    if (deleteFeedbackId != null) {
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            String deleteQuery = "DELETE FROM feedback WHERE id = ?";
            ps = conn.prepareStatement(deleteQuery);
            ps.setInt(1, Integer.parseInt(deleteFeedbackId));
            ps.executeUpdate();
            out.println("<div class='alert alert-success'>Feedback deleted successfully!</div>");
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>Error deleting feedback: " + e.getMessage() + "</div>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Admin replying to feedback
    if (replyFeedbackId != null && replyText != null && !replyText.isEmpty()) {
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            String replyQuery = "UPDATE feedback SET reply = ? WHERE id = ?";
            ps = conn.prepareStatement(replyQuery);
            ps.setString(1, replyText);
            ps.setInt(2, Integer.parseInt(replyFeedbackId));
            ps.executeUpdate();
            out.println("<div class='alert alert-success'>Replied to feedback successfully!</div>");
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>Error replying to feedback: " + e.getMessage() + "</div>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Fetch feedback data
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
        String feedbackQuery = "SELECT f.id AS feedback_id, f.rating, f.feedback, f.reply, f.created_at, " +
                "c.name AS customer_name, c.email AS customer_email, c.phone AS customer_phone, " +
                "d.username AS driver_username, d.email AS driver_email, d.contact_number AS driver_contact " +
                "FROM feedback f " +
                "JOIN customers c ON f.customer_id = c.id " +
                "JOIN drivers d ON f.driver_id = d.id " +
                "ORDER BY f.created_at DESC";
        ps = conn.prepareStatement(feedbackQuery);
        rs = ps.executeQuery();
%>

<!-- Feedback List -->
<div class="feedback-list">
    <%
        while (rs.next()) {
    %>
    <div class="feedback-card">
        <p><strong>Customer:</strong> <%= rs.getString("customer_name") %> (Email: <%= rs.getString("customer_email") %>, Phone: <%= rs.getString("customer_phone") %>)</p>
        <p><strong>Driver:</strong> <%= rs.getString("driver_username") %> (Email: <%= rs.getString("driver_email") %>, Contact: <%= rs.getString("driver_contact") %>)</p>
        <p class="rating">Rating: <%= rs.getInt("rating") %> <i class="fas fa-star"></i></p>
        <p><strong>Feedback:</strong> <%= rs.getString("feedback") %></p>
        <p><strong>Reply:</strong> <%= rs.getString("reply") != null ? rs.getString("reply") : "No reply yet" %></p>
        <p><small>Feedback given on: <%= rs.getString("created_at") %></small></p>

        <!-- Feedback Actions (Reply and Delete) -->
        <div class="feedback-actions">
            <form action="manage_feedback.jsp" method="POST">
                <!-- Reply Section -->
                <input type="hidden" name="reply_id" value="<%= rs.getInt("feedback_id") %>">
                <textarea name="reply_text" class="reply-input" placeholder="Reply to this feedback"></textarea>
                <button type="submit" class="btn btn-success">Reply</button>
            </form>
            <br>
            <!-- Delete Section -->
<%--            <a href="manage_feedback.jsp?delete_id=<%= rs.getInt(" class="btn btn-danger">Delete</a>--%>
        </div>
    </div>
    <%
        }
    %>
</div>

<%
    } catch (SQLException e) {
        out.println("<div class='alert alert-danger'>Error fetching feedbacks: " + e.getMessage() + "</div>");
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
</body>
</html>

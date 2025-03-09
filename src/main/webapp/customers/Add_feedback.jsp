<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Feedback</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .feedback-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background: #f9f9f9;
        }
        .btn-custom {
            background-color: #4CAF50;
            color: white;
        }
        .btn-custom:hover {
            background-color: #45a049;
        }
        .feedback-card {
            background: #fff;
            padding: 15px;
            border: 1px solid #ddd;
            margin-bottom: 10px;
            border-radius: 8px;
        }
        .feedback-card .rating {
            font-size: 1.2em;
            color: gold;
        }
        .reply-section {
            margin-top: 10px;
            padding: 10px;
            border-left: 2px solid #ccc;
            background: #f9f9f9;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <div class="feedback-container">
        <h3 class="text-center">Submit Your Feedback</h3>

        <%
            Integer customerId = (Integer) session.getAttribute("customerId");

            if (customerId == null) {
                out.println("<div class='alert alert-danger'>You must be logged in to submit feedback.</div>");
            } else {
                // Fetching available drivers from the 'drivers' table
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
        %>
        <form action="submitFeedback.jsp" method="POST">
            <div class="mb-3">
                <label for="driver" class="form-label">Select Driver</label>
                <select id="driver" name="driver_id" class="form-select" required>
                    <option value="">-- Select Driver --</option>
                    <%
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                            String driverQuery = "SELECT id, username FROM drivers WHERE availability = 'Available' ORDER BY id ASC";
                            ps = conn.prepareStatement(driverQuery);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                String driverUsername = rs.getString("username");
                                int driverId = rs.getInt("id");
                    %>
                    <option value="<%= driverId %>"><%= driverUsername %></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<div class='alert alert-danger'>An error occurred while retrieving drivers.</div>");
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                                if (conn != null) conn.close();
                            } catch (SQLException ex) {
                                ex.printStackTrace();
                            }
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="stars" class="form-label">Rating</label>
                <select id="stars" name="rating" class="form-select" required>
                    <option value="">-- Select Rating (1-5 Stars) --</option>
                    <option value="1">1 Star</option>
                    <option value="2">2 Stars</option>
                    <option value="3">3 Stars</option>
                    <option value="4">4 Stars</option>
                    <option value="5">5 Stars</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="feedback" class="form-label">Your Feedback</label>
                <textarea id="feedback" name="feedback" class="form-control" rows="4" required></textarea>
            </div>

            <input type="hidden" name="customer_id" value="<%= customerId %>">
            <div class="text-center">
                <button type="submit" class="btn btn-custom">Submit Feedback</button>
            </div>
        </form>
        <%
            }
        %>
    </div>

    <!-- Section to display all feedbacks for all drivers -->
    <div class="mt-5">
        <h4 class="text-center">All Customer Feedbacks</h4>

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Establish database connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

                // SQL query to fetch feedback, customer, driver, and reply details
                String feedbackQuery = "SELECT f.id AS feedback_id, f.rating, f.feedback, f.reply, f.created_at, " +
                        "c.name AS customer_name, c.email AS customer_email, c.phone AS customer_phone, " +
                        "d.username AS driver_username, d.email AS driver_email, d.contact_number AS driver_contact " +
                        "FROM feedback f " +
                        "JOIN customers c ON f.customer_id = c.id " +
                        "JOIN drivers d ON f.driver_id = d.id " +
                        "ORDER BY f.created_at DESC";
                ps = conn.prepareStatement(feedbackQuery);

                // Execute the query
                rs = ps.executeQuery();

                // Loop through the result set and display feedback details
                while (rs.next()) {
                    String feedback = rs.getString("feedback");
                    String reply = rs.getString("reply");
                    int rating = rs.getInt("rating");
                    String createdAt = rs.getString("created_at");
                    String customerName = rs.getString("customer_name");
                    String customerEmail = rs.getString("customer_email");
                    String customerPhone = rs.getString("customer_phone");
                    String driverUsername = rs.getString("driver_username");
                    String driverEmail = rs.getString("driver_email");
                    String driverContact = rs.getString("driver_contact");
        %>

        <!-- Display feedback and customer/driver details -->
        <div class="feedback-card mb-4 p-3" style="border: 1px solid #ddd; border-radius: 8px;">
            <p><strong>Customer:</strong> <%= customerName %> (Email: <%= customerEmail %>, Phone: <%= customerPhone %>)</p>
            <p><strong>Driver:</strong> <%= driverUsername %> (Email: <%= driverEmail %>, Contact: <%= driverContact %>)</p>
            <p class="rating">Rating: <%= rating %> <i class="fas fa-star"></i></p>
            <p><strong>Feedback:</strong> <%= feedback %></p>
            <p><small>Feedback given on: <%= createdAt %></small></p>

            <%
                if (reply != null && !reply.trim().isEmpty()) {
            %>
            <!-- Display reply if available -->
            <div class="reply-section">
                <p><strong>Reply:</strong> <%= reply %></p>
            </div>
            <%
            } else {
            %>
            <!-- Option to add reply (Only admin or driver can do this) -->
            <p><strong>No reply yet.</strong></p>
            <%
                }
            %>
        </div>

        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>An error occurred while retrieving feedbacks: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>

    </div>

    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-outline-primary">Go to Home</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

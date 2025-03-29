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



        .navbar {
            background-color: #1E1E1E !important;
            padding: 15px 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Brand (Always Left-Aligned) */
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #FFCC00 !important;
        }

        /* Navbar Links */
        .navbar-nav {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-grow: 1; /* Pushes buttons to the center */
        }

        .navbar-nav .nav-link {
            color: #FFFFFF !important;
            font-size: 1.1rem;
            font-weight: 500;
            margin: 0 10px;
        }

        .navbar-nav .nav-link:hover {
            color: #FFCC00 !important;
        }

        /* Navbar - Logged In */
        .navbar-logged-in {
            background-color: #FFCC00 !important;
        }

        .navbar-logged-in .navbar-brand {
            color: #1E1E1E !important;
        }

        .navbar-logged-in .nav-link {
            color: #1E1E1E !important;
        }

        /* Center Navbar Buttons After Login */
        .navbar-logged-in .navbar-nav {
            justify-content: center;
            width: 100%;
        }

        /* Login Button (Visible Only Before Login) */
        .navbar .login-btn {
            display: block;
        }

        /* Hide Login Button After Login */
        .navbar-logged-in .login-btn {
            display: none;
        }

        /* Buttons */
        .navbar .btn {
            background-color: #FFCC00;
            color: #1E1E1E;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: bold;
            margin: 0 10px;
        }

        .navbar .btn:hover {
            background-color: #D9B000;
            color: #FFFFFF;
        }

        /* Feedback Section */
        .feedback-container {
            max-width: 1650px; /* Expanded width for a larger container */
            margin: auto;
            padding: 25px; /* Increased padding for a more spacious design */
            border: 3px solid #FFCC00; /* Yellow border */
            border-radius: 12px; /* Rounded corners for a modern look */
            background: #FFFFFF; /* Dark Gray background for high contrast */
            color: black; /* White text for readability */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); /* Subtle shadow for depth */
            font-size: 1rem; /* Slightly larger text for better readability */
        }

        .feedback-container h3 {
            color: #FFCC00; /* Yellow for headings to keep consistent theme */
            margin-bottom: 15px;
        }

        .feedback-container p {
            margin-bottom: 15px;
            line-height: 1.5;
        }


        .btn-custom {
            background-color: #FFCC00;
            color: #1E1E1E;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: bold;
        }


        .btn-custom:hover {
            background-color: #D9B000;
            color: #FFFFFF;
        }

        /* Feedback Cards */
        .feedback-card {
            background: #fff;
            padding: 20px; /* Increased padding for expanded card */
            border: 3px solid #FFCC00; /* Yellow border */
            margin-bottom: 20px; /* Increased margin for spacing */
            border-radius: 12px; /* Slightly larger border radius for smoother edges */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Added subtle shadow for a lifted effect */
        }


        .feedback-card .rating {
            font-size: 1.2em;
            color: gold;
        }

        /* Reply Section */
        .reply-section {
            margin-top: 10px;
            padding: 10px;
            border-left: 2px solid #ccc;
            background: #f9f9f9;
        }

        /* Moving Text Banner */
        .moving-text-banner {
            background-color: #FFCC00;
            color: #1E1E1E;
            padding: 10px;
            font-size: 1.2rem;
            text-align: center;
            animation: scrollText 20s linear infinite;
        }

        /* Scrolling Text Animation */
        @keyframes scrollText {
            0% { transform: translateX(100%); }
            100% { transform: translateX(-100%); }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Brand Logo -->
        <a class="navbar-brand" href="index.jsp">Mega City Cab</a>

        <!-- Navbar Toggler (Mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp">Home</a>
                </li>
                <%--                <li class="nav-item">--%>
                <%--                    <a class="nav-link" href="../customers/register.jsp">Register</a>--%>
                <%--                </li>--%>
            </ul>

            <!-- Right Aligned Links (Login/Logout + Other Buttons) -->
            <div class="d-flex align-items-center">
                <% String customerEmail = (String) session.getAttribute("customerEmail"); %>
<%--                <% Integer customerId = (Integer) session.getAttribute("customerId"); %>--%>

                <% if (customerEmail != null) { %>
                <a class="btn btn-outline-light me-2" href="bookingStatus.jsp">Booking Status</a>
                <a class="btn btn-outline-light me-2" href="Add_feedback.jsp">Add Feedback</a>
                <a class="btn btn-warning text-dark px-3" href="logout">Logout</a>
                <% } else { %>
                <a class="btn btn-warning text-dark px-3" href="login.jsp">Login</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>
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
                    customerEmail = rs.getString("customer_email");
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
        <a href="index.jsp" class="btn btn-custom">Go to Home</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

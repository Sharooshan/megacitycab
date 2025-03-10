<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<style>
    label {
        display: block;
        margin: 8px 0 4px;
    }
    input[type="text"] {
        padding: 8px;
        width: 300px;
        margin-bottom: 10px;
    }
    input[type="submit"] {
        background-color: #0b0d10;
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #0b0d10;
    }
    div {
        padding: 10px;
        margin-top: 10px;
    }
</style>

<%
    // Retrieve the driver_id from the request
    String id = request.getParameter("driver_id");

    // Validate driver_id input
    if (id == null || id.isEmpty()) {
        response.sendRedirect("edit_profile.jsp?error=Driver ID is required");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String dbURL = "jdbc:mysql://localhost:3306/megacitycab";
    String dbUser = "root";
    String dbPassword = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // If the form is submitted to update the profile
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            // Retrieve updated data from the form
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contact_number");
            String address = request.getParameter("address");
            String age = request.getParameter("age");
            String experience = request.getParameter("experience");

            // Validate the input fields
            if (username == null || username.isEmpty() || email == null || email.isEmpty() ||
                    contactNumber == null || contactNumber.isEmpty() || address == null || address.isEmpty() ||
                    age == null || age.isEmpty() || experience == null || experience.isEmpty()) {
                response.sendRedirect("edit_profile.jsp?driver_id=" + id + "&error=All fields are required");
                return;
            }

            // Update the driver details in the database
            String sql = "UPDATE drivers SET username=?, email=?, contact_number=?, address=?, age=?, experience=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, contactNumber);
            pstmt.setString(4, address);
            pstmt.setInt(5, Integer.parseInt(age));
            pstmt.setInt(6, Integer.parseInt(experience));
            pstmt.setInt(7, Integer.parseInt(id));

            int updated = pstmt.executeUpdate();

            if (updated > 0) {
                response.sendRedirect("edit_profile.jsp?driver_id=" + id + "&message=Profile updated successfully");
            } else {
                response.sendRedirect("edit_profile.jsp?driver_id=" + id + "&error=Update failed");
            }
        } else {
            // Retrieve current driver details from the database
            String sql = "SELECT * FROM drivers WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Extract driver details from the result set
                String username = rs.getString("username");
                String email = rs.getString("email");
                String contactNumber = rs.getString("contact_number");
                String address = rs.getString("address");
                int age = rs.getInt("age");
                int experience = rs.getInt("experience");

                // Display the driver details in a form for editing
%>
<h2>Edit Profile for Driver ID: <%= id %></h2>
<form action="edit_profile.jsp" method="POST">
    <input type="hidden" name="driver_id" value="<%= id %>">
    <input type="hidden" name="action" value="update">
    <label>Username: <input type="text" name="username" value="<%= username %>"></label><br>
    <label>Email: <input type="text" name="email" value="<%= email %>"></label><br>
    <label>Contact Number: <input type="text" name="contact_number" value="<%= contactNumber %>"></label><br>
    <label>Address: <input type="text" name="address" value="<%= address %>"></label><br>
    <label>Age: <input type="text" name="age" value="<%= age %>"></label><br>
    <label>Experience: <input type="text" name="experience" value="<%= experience %>"></label><br>
    <input type="submit" value="Update Profile">
</form>
<%
            } else {
                response.sendRedirect("edit_profile.jsp?driver_id=" + id + "&error=Driver not found");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("edit_profile.jsp?driver_id=" + id + "&error=" + e.getMessage());
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

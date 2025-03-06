<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Give Feedback</title>
</head>
<body>
<h2>Give Feedback to Drivers</h2>

<form action="${pageContext.request.contextPath}/customers/SubmitFeedbackController" method="post">
    <label>Select Driver:</label>
    <select name="driver_id" required>
        <%
            Connection con = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
                stmt = con.prepareStatement("SELECT id, username FROM drivers ORDER BY id ASC");
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <option value="<%= rs.getInt("id") %>"><%= rs.getString("username") %></option>
        <%
                }
            } catch (Exception e) {
                out.println("<p style='color: red;'>Database Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (con != null) try { con.close(); } catch (SQLException ignored) {}
            }
        %>
    </select>
    <br>

    <label>Star Rating:</label>
    <select name="rating" required>
        <option value="1">1 Star</option>
        <option value="2">2 Stars</option>
        <option value="3">3 Stars</option>
        <option value="4">4 Stars</option>
        <option value="5">5 Stars</option>
    </select>
    <br>

    <label>Feedback:</label>
    <textarea name="feedback" required></textarea>
    <br>

    <input type="submit" value="Submit Feedback">
</form>
</body>
</html>

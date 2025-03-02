<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
  String rideIdParam = request.getParameter("rideId");
  if (rideIdParam != null) {
    int rideId = Integer.parseInt(rideIdParam);
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

      // Insert notification into admin notifications table
      String sql = "INSERT INTO notifications (booking_id, message) VALUES (?, ?)";
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, rideId);
      pstmt.setString(2, "Driver has rejected booking ID: " + rideId);
      pstmt.executeUpdate();

      out.println("<script>alert('Admin has been notified about the rejection.'); window.location.href='view_rides.jsp';</script>");
    } catch (Exception e) {
      e.printStackTrace();
      out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    } finally {
      try {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  } else {
    out.println("<script>alert('Invalid request. No ride ID provided.'); window.location.href='view_rides.jsp';</script>");
  }
%>

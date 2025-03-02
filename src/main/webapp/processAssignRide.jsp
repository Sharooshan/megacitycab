<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, jakarta.servlet.http.HttpSession" %>

<%
    // Check if admin is logged in
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminEmail") == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }

    // Get the booking_id and driver_id from the request
    String bookingIdParam = request.getParameter("booking_id");
    String driverIdParam = request.getParameter("driver_id");

    if (bookingIdParam == null || driverIdParam == null) {
        response.sendRedirect("RejectedRides.jsp");
        return;
    }

    int bookingId = Integer.parseInt(bookingIdParam);
    int driverId = Integer.parseInt(driverIdParam);

    // Database connection
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");

        // Update booking status and assign driver
        String updateBookingQuery = "UPDATE bookings SET driver_id = ?, status = 'Assigned' WHERE id = ?";
        pstmt = conn.prepareStatement(updateBookingQuery);
        pstmt.setInt(1, driverId);
        pstmt.setInt(2, bookingId);
        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
            // Optionally update the driver's availability
            String updateDriverQuery = "UPDATE drivers SET availability = 'Not Available' WHERE id = ?";
            pstmt = conn.prepareStatement(updateDriverQuery);
            pstmt.setInt(1, driverId);
            pstmt.executeUpdate();

            // Redirect to success page or booking details
            response.sendRedirect("BookingDetails.jsp?booking_id=" + bookingId);
        } else {
            // Handle the case where the booking update fails
            response.sendRedirect("RejectedRides.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

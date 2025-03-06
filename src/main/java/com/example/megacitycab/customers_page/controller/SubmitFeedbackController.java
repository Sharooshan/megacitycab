package com.example.megacitycab.customers_page.controller;




import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/customers/SubmitFeedbackController")
public class SubmitFeedbackController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int customerId = (int) session.getAttribute("customer_id"); // Get logged-in customer ID
        int driverId = Integer.parseInt(request.getParameter("driver_id"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String feedback = request.getParameter("feedback");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab", "root", "");
            String query = "INSERT INTO driver_feedback (customer_id, driver_id, rating, feedback) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, customerId);
            pstmt.setInt(2, driverId);
            pstmt.setInt(3, rating);
            pstmt.setString(4, feedback);
            pstmt.executeUpdate();
            con.close();
            response.sendRedirect("feedback_success.jsp"); // Redirect after success
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

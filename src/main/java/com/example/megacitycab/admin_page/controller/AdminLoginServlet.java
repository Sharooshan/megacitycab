package com.example.megacitycab.admin_page.controller;

import com.example.megacitycab.db.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/Admin/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection(); // Get new connection
            if (conn == null) {
                throw new Exception("Database connection is NULL!");
            }

            String query = "SELECT * FROM admins WHERE email = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // If using plaintext passwords (not recommended)
                if (password.equals(storedPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("adminEmail", email);
                    response.sendRedirect("AdminDashboard.jsp");
                } else {
                    request.setAttribute("error", "Incorrect Password!");
                    request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Email Not Found!");
                request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("AdminLogin.jsp").forward(request, response);
        } finally {
            // Close resources properly
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close(); // Close connection here
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

package com.example.megacitycab.admin_page.controller;

import com.example.megacitycab.admin_page.dao.AdminDAO;
import com.example.megacitycab.admin_page.model.Admin;
import com.example.megacitycab.db.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/adminRegister")
public class AdminRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        Admin admin = new Admin(name, email, password, phone, role);

        try {
            Connection conn = DatabaseConnection.getConnection();
            AdminDAO adminDAO = new AdminDAO(conn);
            boolean success = adminDAO.registerAdmin(admin);

            if (success) {
                response.sendRedirect("AdminLogin.jsp?message=Registration Successful!");
            } else {
                request.setAttribute("error", "Registration Failed!");
                request.getRequestDispatcher("admin_register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("admin_register.jsp").forward(request, response);
        }
    }
}

package com.example.megacitycab.driver.controller;

import com.example.megacitycab.driver.dao.DriverDAO;
import com.example.megacitycab.driver.model.Driver;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.example.megacitycab.db.DatabaseConnection.connection;

@WebServlet("/driver/driver_login")
public class DriverLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Initialize the DriverDAO to fetch driver details
        DriverDAO driverDAO = new DriverDAO(connection);
        Driver driver = driverDAO.getDriverByUsernameAndPassword(username, password);

        // Check if driver credentials are correct
        if (driver != null) {
            // Create a new session or use the existing one
            HttpSession session = request.getSession();
            session.setAttribute("driver", driver);  // Store driver object in session

            // Set attributes to be accessed in the dashboard page
            request.setAttribute("driverName", driver.getUsername());
            request.setAttribute("username", driver.getUsername());
            request.setAttribute("email", driver.getEmail());
            request.setAttribute("contactNumber", driver.getContactNumber());
            request.setAttribute("address", driver.getAddress());
            request.setAttribute("age", driver.getAge());
            request.setAttribute("experience", driver.getExperience());
            request.setAttribute("carLicense", driver.isCarLicense());
            request.setAttribute("autoLicense", driver.isAutoLicense());
            request.setAttribute("bikeLicense", driver.isBikeLicense());

            // Redirect to the driver dashboard page
            response.sendRedirect(request.getContextPath() + "/driver/driver_dashboard.jsp");

        } else {
            // Invalid login credentials, show error message and forward back to login page
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("/jsp/driver_login.jsp").forward(request, response);
        }
    }
}

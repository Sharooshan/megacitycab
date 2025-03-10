package com.example.megacitycab.admin_page.controller;

import com.example.megacitycab.admin_page.dao.DriverDAO;
import com.example.megacitycab.admin_page.model.Driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/Admin/DriverServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)  // 10MB max file size
public class DriverServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve form data
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contactNumber");
            String address = request.getParameter("address");
            int age = Integer.parseInt(request.getParameter("age"));
            int experience = Integer.parseInt(request.getParameter("experience"));

            // Correctly handle radio buttons for licenses
            boolean carLicense = "true".equals(request.getParameter("carLicense"));
            boolean autoLicense = "true".equals(request.getParameter("autoLicense"));
            boolean bikeLicense = "true".equals(request.getParameter("bikeLicense"));

            // Handle file uploads
            Part licenceProofPart = request.getPart("licenceProof");
            Part nicProofPart = request.getPart("nicProof");

            // Validate file types
            String licenceProofType = licenceProofPart.getContentType();
            String nicProofType = nicProofPart.getContentType();
            if (!(licenceProofType.matches("image/.+") || licenceProofType.equals("application/pdf"))
                    || !(nicProofType.matches("image/.+") || nicProofType.equals("application/pdf"))) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid file types. Only images and PDFs are allowed.");
                return;
            }

            InputStream licenceProofInputStream = licenceProofPart.getInputStream();
            InputStream nicProofInputStream = nicProofPart.getInputStream();

            // Call DAO to save driver details
            DriverDAO driverDAO = new DriverDAO();
            boolean success = driverDAO.saveDriver(new Driver(username, password, email, contactNumber,
                    licenceProofInputStream, nicProofInputStream, carLicense, autoLicense, bikeLicense,
                    address, age, experience));

            if (success) {
                response.sendRedirect("success.jsp");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error saving driver details. Please try again later.");
            }
        } catch (NumberFormatException e) {
            // Catch number parsing issues (age and experience)
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Error: Invalid number format for age or experience. " + e.getMessage());
        } catch (Exception e) {
            // General exception handling
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An unexpected error occurred: " + e.getMessage());
        }
    }
}

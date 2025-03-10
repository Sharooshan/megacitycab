package com.example.megacitycab.admin_page.controller;

import com.example.megacitycab.admin_page.dao.VehicleDAO;
import com.example.megacitycab.admin_page.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.Paths;

@WebServlet("/Admin/AddVehicleServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddVehicleServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "images";  // Folder inside webapp to store images

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form fields
        String vehicleType = request.getParameter("vehicleType");
        String model = request.getParameter("model");
        String color = request.getParameter("color");
        String cc = request.getParameter("cc");
        String numberPlate = request.getParameter("numberPlate");
        String driverName = request.getParameter("driverName");
        String driverMobile = request.getParameter("driverMobile");

        // Handle file upload
        Part filePart = request.getPart("image");
        String imageFileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            imageFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();  // Keep original filename

            // Get the absolute path to save the file
            String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();  // Create directory if it doesn't exist
            }

            // Save file to the server
            String filePath = uploadPath + File.separator + imageFileName;
            try (InputStream inputStream = filePart.getInputStream();
                 FileOutputStream outputStream = new FileOutputStream(filePath)) {
                int bytesRead;
                byte[] buffer = new byte[1024];
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
        }

        // Debugging Output
        System.out.println("Vehicle Type: " + vehicleType);
        System.out.println("Model: " + model);
        System.out.println("Color: " + color);
        System.out.println("CC: " + cc);
        System.out.println("Number Plate: " + numberPlate);
        System.out.println("Driver Name: " + driverName);
        System.out.println("Driver Mobile: " + driverMobile);
        System.out.println("Image File: " + imageFileName);

        // Create a new Vehicle object
        Vehicle vehicle = new Vehicle(vehicleType, imageFileName, model, color, cc, numberPlate);

        // Save vehicle to database using DAO
        VehicleDAO vehicleDAO = new VehicleDAO();
        boolean isAdded = vehicleDAO.addVehicle(vehicle);

        if (isAdded) {
            response.sendRedirect("vehicleList.jsp");  // Redirect to vehicle list page after success
        } else {
            response.getWriter().println("Failed to add vehicle.");
        }
    }
}
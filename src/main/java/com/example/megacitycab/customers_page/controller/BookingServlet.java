package com.example.megacitycab.customers_page.controller;

import com.example.megacitycab.customers_page.dao.BookingDAO;
import com.example.megacitycab.customers_page.model.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data from the request
        int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));
        int customerId = Integer.parseInt(request.getParameter("customer_id"));
        String tripStartDate = request.getParameter("trip_start_date");
        String tripEndDate = request.getParameter("trip_end_date");
        String tripTime = request.getParameter("trip_time");
        String pickupLocation = request.getParameter("pickup_location");
        String dropLocation = request.getParameter("drop_location");
        int passengerCount = Integer.parseInt(request.getParameter("passenger_count"));
        String paymentMethod = request.getParameter("payment_method");
        double totalPrice = Double.parseDouble(request.getParameter("total_price"));
        double discountAmount = Double.parseDouble(request.getParameter("discount_amount"));
        String driverName = request.getParameter("driver_name");
        String driverMobile = request.getParameter("driver_mobile");

        // Create a Booking object
        Booking booking = new Booking(vehicleId, customerId, tripStartDate, tripEndDate, tripTime, pickupLocation,
                dropLocation, passengerCount, paymentMethod, totalPrice, discountAmount, driverName, driverMobile);

        // Call the DAO to insert the booking
        BookingDAO bookingDAO = new BookingDAO();
        boolean isInserted = bookingDAO.insertBooking(booking);

        // Set success or failure message
        if (isInserted) {
            request.setAttribute("message", "Booking confirmed successfully!");
            // Redirect to confirmation JSP
            response.sendRedirect("booking_confirmation.jsp");
        } else {
            request.setAttribute("message", "There was an error processing your booking. Please try again.");
            // Redirect to error page JSP
            response.sendRedirect("booking_error.jsp");
        }
    }
}

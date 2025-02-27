package com.example.megacitycab.customers_page.controller;

import com.example.megacitycab.db.DatabaseConnection;
import com.example.megacitycab.customers_page.model.Customer;
import com.example.megacitycab.customers_page.model.CustomerDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/customers/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Initialize DAO to check login credentials
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.loginCustomer(email, password);

        if (customer != null) {
            // If the customer exists, store customer details in session
            HttpSession session = request.getSession();
            session.setAttribute("customerEmail", email); // Store only the email or customer info in session

            // Redirect to home page (or dashboard)
            response.sendRedirect("index.jsp");
        } else {
            // If login failed, set an error message to display on login page
            request.setAttribute("errorMessage", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

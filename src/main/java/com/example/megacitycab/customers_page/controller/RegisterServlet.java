package com.example.megacitycab.customers_page.controller;



import com.example.megacitycab.customers_page.model.Customer;
import com.example.megacitycab.customers_page.model.CustomerDAO;


import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customers/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String nic = request.getParameter("nic");

        Customer customer = new Customer(name, email, password, address, phone, nic);
        CustomerDAO customerDAO = new CustomerDAO();

        if (customerDAO.registerCustomer(customer)) {
            response.sendRedirect("success.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}

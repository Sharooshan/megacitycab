<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #f8f9fa);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            max-width: 400px;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h2 {
            font-weight: 700;
            color: #333;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            box-shadow: none;
        }
        .btn-primary {
            background: #007bff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-primary:hover {
            background: #0056b3;
        }
        .text-center a {
            color: #007bff;
            font-weight: 600;
        }
        .text-center a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Customer Registration</h2>

    <!-- Error Message -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="register" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" class="form-control" id="name" name="name" required>
            <span id="nameError" class="error"></span>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <span id="emailError" class="error"></span>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <span id="passwordError" class="error"></span>
        </div>
        <div class="form-group">
            <label for="address">Address:</label>
            <textarea class="form-control" id="address" name="address" required></textarea>
            <span id="addressError" class="error"></span>
        </div>
        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="text" class="form-control" id="phone" name="phone" required>
            <span id="phoneError" class="error"></span>
        </div>
        <div class="form-group">
            <label for="nic">NIC:</label>
            <input type="text" class="form-control" id="nic" name="nic" required>
            <span id="nicError" class="error"></span>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Register</button>
    </form>

    <div class="mt-3 text-center">
        <p>Already have an account? <a href="login.jsp">Go to Login</a></p>
    </div>
</div>

<!-- Bootstrap 5 JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

<!-- JavaScript Form Validation -->
<script>
    function validateForm() {
        let isValid = true;

        // Name Validation
        let name = document.getElementById("name").value;
        let namePattern = /^[A-Za-z\s]{3,}$/;
        if (!namePattern.test(name)) {
            document.getElementById("nameError").innerText = "Name must be at least 3 characters and contain only letters.";
            isValid = false;
        } else {
            document.getElementById("nameError").innerText = "";
        }

        // Email Validation
        let email = document.getElementById("email").value;
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailPattern.test(email)) {
            document.getElementById("emailError").innerText = "Invalid email format.";
            isValid = false;
        } else {
            document.getElementById("emailError").innerText = "";
        }

        // Password Validation
        let password = document.getElementById("password").value;
        let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        if (!passwordPattern.test(password)) {
            document.getElementById("passwordError").innerText = "Password must be at least 8 characters with one uppercase, one lowercase, one number, and one special character.";
            isValid = false;
        } else {
            document.getElementById("passwordError").innerText = "";
        }

        // Address Validation
        let address = document.getElementById("address").value;
        if (address.trim() === "") {
            document.getElementById("addressError").innerText = "Address cannot be empty.";
            isValid = false;
        } else {
            document.getElementById("addressError").innerText = "";
        }

        // Phone Validation (Sri Lankan format)
        let phone = document.getElementById("phone").value;
        let phonePattern = /^(07[01245678])\d{7}$/;
        if (!phonePattern.test(phone)) {
            document.getElementById("phoneError").innerText = "Enter a valid Sri Lankan phone number (07XXXXXXXX).";
            isValid = false;
        } else {
            document.getElementById("phoneError").innerText = "";
        }

        // NIC Validation (Old: 9 digits + V/X, New: 12 digits)
        let nic = document.getElementById("nic").value;
        let nicPattern = /^([0-9]{9}[VX]|[0-9]{12})$/;
        if (!nicPattern.test(nic)) {
            document.getElementById("nicError").innerText = "Enter a valid NIC (Old: 9 digits + V/X, New: 12 digits).";
            isValid = false;
        } else {
            document.getElementById("nicError").innerText = "";
        }

        return isValid;
    }
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        // JavaScript Validation
        function validateForm() {
            // Validate username (Alphanumeric, 4-20 characters)
            var username = document.forms["driverForm"]["username"].value;
            if (!/^[a-zA-Z0-9]{4,20}$/.test(username)) {
                alert("Username must be alphanumeric and between 4 to 20 characters.");
                return false;
            }

            // Validate email format
            var email = document.forms["driverForm"]["email"].value;
            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            if (!email.match(emailPattern)) {
                alert("Please enter a valid email address.");
                return false;
            }

            // Validate contact number (Sri Lankan format, starts with 07 or 09, 10 digits)
            var contactNumber = document.forms["driverForm"]["contactNumber"].value;
            var phonePattern = /^(07|09)\d{8}$/;
            if (!contactNumber.match(phonePattern)) {
                alert("Please enter a valid Sri Lankan contact number.");
                return false;
            }

            // Validate age (must be 18 or older)
            var age = document.forms["driverForm"]["age"].value;
            if (age < 18) {
                alert("Driver must be at least 18 years old.");
                return false;
            }

            // Validate experience (must be at least 1 year)
            var experience = document.forms["driverForm"]["experience"].value;
            if (experience < 1) {
                alert("Experience must be at least 1 year.");
                return false;
            }

            // Validate password (at least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character)
            var password = document.forms["driverForm"]["password"].value;
            var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!password.match(passwordPattern)) {
                alert("Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character.");
                return false;
            }

            // Validate file upload (check file extensions for License and NIC Proof)
            var fileExtensionPattern = /(\.pdf|\.jpg|\.jpeg|\.png)$/i;
            var licenceProof = document.forms["driverForm"]["licenceProof"].value;
            var nicProof = document.forms["driverForm"]["nicProof"].value;
            if (!fileExtensionPattern.test(licenceProof)) {
                alert("License Proof must be in PDF, JPG, or PNG format.");
                return false;
            }
            if (!fileExtensionPattern.test(nicProof)) {
                alert("NIC Proof must be in PDF, JPG, or PNG format.");
                return false;
            }

            // Validate License Selection (At least one license must be selected)
            var carLicense = document.forms["driverForm"]["carLicense"].value;
            var autoLicense = document.forms["driverForm"]["autoLicense"].value;
            var bikeLicense = document.forms["driverForm"]["bikeLicense"].value;

            if (carLicense == "false" && autoLicense == "false" && bikeLicense == "false") {
                alert("Please select at least one license type (Car, Auto, or Bike).");
                return false;
            }


        }
    </script>
</head>
<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        max-width: 1200px;
        margin-top: 50px;
        background-color: #ffffff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .vehicle-card {
        margin-bottom: 20px;
        border: 1px solid #ddd;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .vehicle-img {
        max-width: 100%;
        height: auto;
        border-radius: 10px;
    }
    body {
        background-color: #ffffff;
        color: #000000;
        font-family: Arial, sans-serif;
    }
    .sidebar {
        width: 250px;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        background-color: #000000;
        color: #ffffff;
        padding-top: 20px;
    }
    .sidebar a {
        display: block;
        color: #ffffff;
        padding: 15px;
        text-decoration: none;
        transition: 0.3s;
    }
    .sidebar a:hover {
        background-color: #555;
    }
    .content {
        margin-left: 260px;
        padding: 20px;
    }
    .card {
        border: none;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    .btn-dark {
        background-color: #212529; /* Dark color */
        border-color: #212529;
        color: #fff;
        transition: background-color 0.3s ease, border-color 0.3s ease;
    }

    .btn-dark:hover {
        background-color: #343a40; /* Slightly lighter dark shade */
        border-color: #343a40;
    }

</style>

<!-- Sidebar Navigation -->
<div class="sidebar">
    <h4 class="text-center">MegaCityCab - Admin</h4>
    <a href="AdminDashboard.jsp">Dashboard</a>
    <a href="assigning.jsp" >Assigning Drivers</a>
    <a href="register.jsp" >Register Drivers</a>
    <a href="admin_register.jsp">Register Admins</a>
    <a href="viewRejections.jsp">Check Ride Rejections</a>
    <a href="vehicleList.jsp">Manage Vehicles</a>
    <a href="manageBookings.jsp">Manage Bookings</a>
    <a href="driver_available_check.jsp">Driver Availability</a>
    <a href="manage_feedback.jsp">Manage Feedback</a>
    <a href="AddVehicle.jsp">Manage Vehicles</a>

    <a href="AdminLogoutServlet">Logout</a>
</div>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4">
        <h2 class="text-center">Driver Registration</h2>
        <form name="driverForm" action="DriverServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

            <!-- Username -->
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <!-- Contact Number -->
            <div class="mb-3">
                <label class="form-label">Contact Number</label>
                <input type="text" name="contactNumber" class="form-control" required>
            </div>

            <!-- Address -->
            <div class="mb-3">
                <label class="form-label">Address</label>
                <input type="text" name="address" class="form-control" required>
            </div>

            <!-- Age -->
            <div class="mb-3">
                <label class="form-label">Age</label>
                <input type="number" name="age" class="form-control" required>
            </div>

            <!-- Experience -->
            <div class="mb-3">
                <label class="form-label">Experience (Years)</label>
                <input type="number" name="experience" class="form-control" required>
            </div>

            <!-- License Options -->
            <div class="mb-3">
                <label class="form-label">Car License</label><br>
                <input type="radio" name="carLicense" value="true"> Yes
                <input type="radio" name="carLicense" value="false" checked> No
            </div>

            <div class="mb-3">
                <label class="form-label">Auto License</label><br>
                <input type="radio" name="autoLicense" value="true"> Yes
                <input type="radio" name="autoLicense" value="false" checked> No
            </div>

            <div class="mb-3">
                <label class="form-label">Bike License</label><br>
                <input type="radio" name="bikeLicense" value="true"> Yes
                <input type="radio" name="bikeLicense" value="false" checked> No
            </div>


            <!-- File Uploads -->
            <div class="mb-3">
                <label class="form-label">License Proof (PDF, JPG, PNG)</label>
                <input type="file" name="licenceProof" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
            </div>

            <div class="mb-3">
                <label class="form-label">NIC Proof (PDF, JPG, PNG)</label>
                <input type="file" name="nicProof" class="form-control" accept=".pdf,.jpg,.jpeg,.png" required>
            </div>

            <!-- Submit Button -->
            <div class="text-center">
                <input type="submit" value="Register" class="btn btn-dark">
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

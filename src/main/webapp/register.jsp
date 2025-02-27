<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4">
        <h2 class="text-center">Driver Registration</h2>
        <form action="DriverServlet" method="post" enctype="multipart/form-data">

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
                <input type="submit" value="Register" class="btn btn-primary">
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

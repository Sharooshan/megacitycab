<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Vehicle</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }

    .container {
      max-width: 600px;
      margin-top: 50px;
      background-color: #ffffff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h2 {
      color: #007bff;
      text-align: center;
      margin-bottom: 30px;
    }

    .form-label {
      font-weight: bold;
    }

    .form-control {
      margin-bottom: 20px;
    }

    .btn-primary {
      width: 100%;
      padding: 12px;
    }

    .btn-primary:hover {
      background-color: #0056b3;
    }

    .navbar {
      margin-bottom: 30px;
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">MegaCityCab - Admin</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" href="AdminDashboard.jsp">Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="AddVehicle.jsp">Manage Vehicles</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ManageAdmins.jsp">Manage Admins</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ManageDrivers.jsp">Manage Drivers</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="AdminLogoutServlet">Logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <h2>Add New Vehicle</h2>
  <form action="AddVehicleServlet" method="post" enctype="multipart/form-data">
    <div class="mb-3">
      <label for="vehicleType" class="form-label">Vehicle Type:</label>
      <select name="vehicleType" id="vehicleType" class="form-control" required>
        <option value="Car">Car</option>
        <option value="Bike">Bike</option>
        <option value="Auto">Auto</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="model" class="form-label">Model:</label>
      <input type="text" name="model" id="model" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="color" class="form-label">Color:</label>
      <input type="text" name="color" id="color" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="cc" class="form-label">CC:</label>
      <input type="text" name="cc" id="cc" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="numberPlate" class="form-label">Number Plate:</label>
      <input type="text" name="numberPlate" id="numberPlate" class="form-control" required>
    </div>

    <div class="mb-3">
      <label for="image" class="form-label">Upload Image:</label>
      <input type="file" name="image" id="image" class="form-control" required>
    </div>

    <button type="submit" class="btn btn-primary">Add Vehicle</button>
  </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>

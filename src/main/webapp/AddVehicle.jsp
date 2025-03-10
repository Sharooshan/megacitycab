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
      <select name="vehicleType" id="vehicleType" class="form-control" required onchange="changeModelOptions()">
        <option value="Car">Car</option>
        <option value="Bike">Bike</option>
        <option value="Auto">Auto</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="model" class="form-label">Model:</label>
      <select name="model" id="model" class="form-control" required>
        <!-- Default Options -->
        <option value="" disabled selected>Select Model</option>
      </select>
    </div>

    <div class="mb-3">
      <label for="color" class="form-label">Color:</label>
      <select name="color" id="color" class="form-control" required>
        <option value="Red">Red</option>
        <option value="Green">Green</option>
        <option value="Black">Black</option>
        <option value="Yellow">Yellow</option>
        <option value="Blue">Blue</option>
        <option value="White">White</option> <!-- Extra color option -->
      </select>
    </div>

    <div class="mb-3">
      <label for="cc" class="form-label">CC:</label>
      <input type="number" name="cc" id="cc" class="form-control" min="100" max="500" required>
    </div>

    <div class="mb-3">
      <label for="numberPlate" class="form-label">Number Plate:</label>
      <input type="text" name="numberPlate" id="numberPlate" class="form-control"
             pattern="^WP\s[a-zA-Z]{3}[0-9]{4}$"
             title="Example: WP ABC1234" required>
      <small class="form-text text-muted">Example: WP ABC1234</small>
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

<script>
  // JavaScript to handle dynamic model options based on vehicle type
  function changeModelOptions() {
    const vehicleType = document.getElementById("vehicleType").value;
    const modelSelect = document.getElementById("model");

    // Clear current options
    modelSelect.innerHTML = "<option value='' disabled selected>Select Model</option>";

    let models = [];

    // Set models based on vehicle type
    if (vehicleType === "Car") {
      models = ["Toyota Corolla", "Honda Civic", "BMW 3 Series", "Audi A4"];
    } else if (vehicleType === "Bike") {
      models = ["Yamaha R15", "Honda CBR500R", "KTM Duke 390"];
    } else if (vehicleType === "Auto") {
      models = ["Tata Nano", "Maruti Suzuki Alto", "Honda Activa"];
    }

    // Populate the model options
    models.forEach(model => {
      const option = document.createElement("option");
      option.value = model;
      option.text = model;
      modelSelect.appendChild(option);
    });
  }
</script>

</body>
</html>

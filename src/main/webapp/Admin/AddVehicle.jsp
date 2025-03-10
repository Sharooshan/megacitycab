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
      max-width: 1200px;
      margin-top: 50px;
      background-color: #ffffff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h2 {
      color: #0b0d10;
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



<body>

<%--<!-- Navbar -->--%>
<%--<nav class="navbar navbar-expand-lg navbar-light bg-light">--%>
<%--  <div class="container-fluid">--%>
<%--    <a class="navbar-brand" href="#">MegaCityCab - Admin</a>--%>
<%--    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">--%>
<%--      <span class="navbar-toggler-icon"></span>--%>
<%--    </button>--%>
<%--    <div class="collapse navbar-collapse" id="navbarNav">--%>
<%--      <ul class="navbar-nav ms-auto">--%>
<%--        <li class="nav-item">--%>
<%--          <a class="nav-link active" href="AdminDashboard.jsp">Dashboard</a>--%>
<%--        </li>--%>
<%--        <li class="nav-item">--%>
<%--          <a class="nav-link" href="AddVehicle.jsp">Manage Vehicles</a>--%>
<%--        </li>--%>
<%--        <li class="nav-item">--%>
<%--          <a class="nav-link" href="ManageAdmins.jsp">Manage Admins</a>--%>
<%--        </li>--%>
<%--        <li class="nav-item">--%>
<%--          <a class="nav-link" href="ManageDrivers.jsp">Manage Drivers</a>--%>
<%--        </li>--%>
<%--        <li class="nav-item">--%>
<%--          <a class="nav-link" href="AdminLogoutServlet">Logout</a>--%>
<%--        </li>--%>
<%--      </ul>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</nav>--%>

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

    <button type="submit" class="btn btn-dark">Add Vehicle</button>
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

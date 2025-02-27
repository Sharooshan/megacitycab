<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Registration</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center">Admin Registration</h2>

  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
  <% } %>

  <form action="adminRegister" method="post">
    <div class="mb-3">
      <label class="form-label">Name:</label>
      <input type="text" class="form-control" name="name" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Email:</label>
      <input type="email" class="form-control" name="email" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Password:</label>
      <input type="password" class="form-control" name="password" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Phone:</label>
      <input type="text" class="form-control" name="phone" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Role:</label>
      <select class="form-control" name="role" required>
        <option value="Super Admin">Super Admin</option>
        <option value="Driver">Driver</option>
      </select>
    </div>
    <button type="submit" class="btn btn-primary btn-block">Register</button>
  </form>

  <div class="mt-3 text-center">
    <p>Already have an account? <a href="AdminLogin.jsp">Go to Login</a></p>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style> .btn-dark {
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
<body class="bg-light">

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card shadow-lg p-4">
        <h3 class="text-center text-dark">Admin Login</h3>

        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
          <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="AdminLoginServlet" method="post">
          <div class="mb-3">
            <label class="form-label">Email:</label>
            <input type="email" class="form-control" name="email" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Password:</label>
            <input type="password" class="form-control" name="password" required>
          </div>
          <button type="submit" class="btn btn-dark w-100">Login</button>
        </form>

        <div class="text-center mt-3">
<%--          <a href="../customers/index.jsp" class="text-decoration-none">Back to Home</a>--%>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>

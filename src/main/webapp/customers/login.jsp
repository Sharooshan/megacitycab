<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #1E1E1E;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(255, 204, 0, 0.3);
            text-align: center;
        }
        h2 {
            color: #FFCC00;
            font-weight: bold;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #FFCC00;
        }
        .btn-custom {
            background: #FFCC00;
            color: #1E1E1E;
            font-weight: bold;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background: #E6B800;
        }
        .text-center a {
            color: #FFCC00;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <h2 class="text-center">Login</h2>
        <!-- Error Message -->
        <p class="text-center text-danger">
            ${errorMessage}
        </p>
        <form id="loginForm" action="login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control" name="email" id="email" required>
                <span class="error" id="emailError"></span>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" name="password" id="password" required>
                <span class="error" id="passwordError"></span>
            </div>
            <button type="submit" class="btn btn-custom btn-block w-100">Login</button>
        </form>
        <div class="mt-3 text-center">
            <p>Don't have an account? <a href="../customers/register.jsp">Register here</a></p>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.getElementById("loginForm").addEventListener("submit", function(event) {
        let isValid = true;

        // Email Validation
        let email = document.getElementById("email").value;
        let emailError = document.getElementById("emailError");
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailPattern.test(email)) {
            emailError.textContent = "Please enter a valid email address.";
            isValid = false;
        } else {
            emailError.textContent = "";
        }

        // Password Validation
        let password = document.getElementById("password").value;
        let passwordError = document.getElementById("passwordError");
        if (password.length < 6) {
            passwordError.textContent = "Password must be at least 6 characters long.";
            isValid = false;
        } else {
            passwordError.textContent = "";
        }

        if (!isValid) {
            event.preventDefault(); // Prevent form submission if validation fails
        }
    });
</script>
</body>
</html>

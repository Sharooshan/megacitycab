<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
        }
        .error-message {
            color: red;
            font-size: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h2>Error Occurred</h2>
<p class="error-message">
    <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error occurred. Please try again later." %>
</p>
<a href="../customers/index.jsp">Go Back to Home</a>
</body>
</html>

<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="styles.css">
<script>
// Function to send ID to full_details.jsp using POST
function sendIdToFullDetails(id) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "full_details.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send("id=" + encodeURIComponent(id));
    console.log(encodeURIComponent(id));
}

// Function to handle login success and redirect accordingly
function handleLoginSuccess(id, password) {
    if (id === "456" && password === "1234") {
        window.location.href = "admin.jsp";
    } else {
        sendIdToFullDetails(id);
        window.location.href = "home.html?id=" + id;
    }
}

// Function to handle form submission
function handleFormSubmit(event) {
    event.preventDefault(); // Prevent the default form submission
    var id = document.getElementById("id").value;
    var password = document.getElementById("password").value;
    handleLoginSuccess(id, password);
}
</script>
</head>
<body>
<% 
    String dbUrl = "jdbc:mysql://localhost:3306/jdbc";
    String dbUser = "root";
    String dbPassword = "UmaMahesh@9";
    String errorMessage = null;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String idStr = request.getParameter("id");
        String password = request.getParameter("password");
        int id = -1;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            errorMessage = "Invalid ID format";
        }
        if (errorMessage == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                    String query = "SELECT * FROM emp_login WHERE id = ? AND password = ?";
                    try (PreparedStatement stmt = connection.prepareStatement(query)) {
                        stmt.setInt(1, id);
                        stmt.setString(2, password);
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                // Use JavaScript to handle redirection and POST request
                                out.println("<script>handleLoginSuccess('" + id + "', '" + password + "');</script>");
                                return;
                            } else {
                                errorMessage = "Invalid credentials";
                            }
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                errorMessage = "Database connection error: " + e.getMessage();
            }
        }
    }
%>
<center>
<h1>Grocery Store Management.</h1>
<br>
    <div class="container">
        <h2>Login Form</h2>
        <form method="post" action="index.jsp" onsubmit="handleFormSubmit(event)">
            <label for="id">Enter your ID:</label>
            <input type="text" id="id" name="id" required>
            
            <label for="password">Enter your Password:</label>
            <input type="text" id="password" name="password" required>
            <input type="submit" value="Submit">
            <a href="about.html">About Us</a> 
        </form>
        <% if (errorMessage != null) { %>
            <p style="color:red;"><%= errorMessage %></p>
        <% } %>
    </div>
</center>
</body>
</html>

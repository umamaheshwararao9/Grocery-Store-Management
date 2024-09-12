<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<link rel="stylesheet" type="text/css" href="styles.css">
<style>
    .button {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 5px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
    }
    .button.red {
        background-color: red;
    }
</style>
</head>
<body>
<%
    String dbUrl = "jdbc:mysql://localhost:3306/jdbc";
    String dbUser = "root";
    String dbPassword = "UmaMahesh@9";
    String errorMessage = null;
    String successMessage = null;

    // Check if a flag button was clicked
    String flagId = request.getParameter("flagId");
    String action = request.getParameter("action");
    if (flagId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                if ("add".equals(action)) {
                    // Insert flag ID into the flag table
                    String insertQuery = "INSERT INTO flag (id) VALUES (?) ON DUPLICATE KEY UPDATE id = id";
                    try (PreparedStatement stmt = connection.prepareStatement(insertQuery)) {
                        stmt.setString(1, flagId);
                        stmt.executeUpdate();
                    }
                    successMessage = "ID " + flagId + " flagged successfully!";
                } else if ("remove".equals(action)) {
                    // Remove flag ID from the flag table
                    String deleteQuery = "DELETE FROM flag WHERE id = ?";
                    try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
                        stmt.setString(1, flagId);
                        stmt.executeUpdate();
                    }
                    successMessage = "ID " + flagId + " unflagged successfully!";
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            errorMessage = "Error updating flag: " + e.getMessage();
        }
    }

    // Fetch employee data for display
    List<Map<String, Object>> employees = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
            // Query to get employee details and count of orders in the last 24 hours
            String query = "SELECT e.id, e.name, e.age, COALESCE(COUNT(o.order_id), 0) AS order_count, " +
                           "IF(f.id IS NOT NULL, 1, 0) AS is_flagged " +
                           "FROM emp e " +
                           "LEFT JOIN emporders o ON e.id = o.emp_id AND o.time >= NOW() - INTERVAL 1 DAY " +
                           "LEFT JOIN flag f ON e.id = f.id " +
                           "GROUP BY e.id, e.name, e.age";
            try (Statement stmt = connection.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {
                while (rs.next()) {
                    Map<String, Object> employee = new HashMap<>();
                    employee.put("id", rs.getInt("id"));
                    employee.put("name", rs.getString("name"));
                    employee.put("age", rs.getInt("age"));
                    employee.put("order_count", rs.getInt("order_count"));
                    employee.put("is_flagged", rs.getInt("is_flagged"));
                    employees.add(employee);
                }
            }
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        errorMessage = "Error fetching employee data: " + e.getMessage();
    }
%>
<center>
<h1>Admin Page</h1>
<br>
<div class="container">
    <h2>Employee Details</h2>
    <% if (errorMessage != null) { %>
        <p style="color:red;"><%= errorMessage %></p>
    <% } %>
    <% if (successMessage != null) { %>
        <p style="color:green;"><%= successMessage %></p>
    <% } %>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Number of Orders (Last 24 Hours)</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Map<String, Object> emp : employees) { %>
                <tr id="row<%= emp.get("id") %>">
                    <td><%= emp.get("id") %></td>
                    <td><%= emp.get("name") %></td>
                    <td><%= emp.get("age") %></td>
                    <td><%= emp.get("order_count") %></td>
                    <td>
                        <form action="admin.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="flagId" value="<%= emp.get("id") %>">
                            <% if (Integer.parseInt(emp.get("is_flagged").toString()) > 0) { %>
                                <input type="hidden" name="action" value="remove">
                                <button type="submit" class="button red">Unflag</button>
                            <% } else { %>
                                <input type="hidden" name="action" value="add">
                                <button type="submit" class="button">Flag</button>
                            <% } %>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
    <br>
    <a href="index.jsp">Back to Login</a>
</div>
</center>
</body>
</html>

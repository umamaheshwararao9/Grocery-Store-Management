<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get ID from request parameter
    String idStr = request.getParameter("id");

    // Only proceed if ID is provided
    if (idStr != null) {
        try {
            // Convert ID to integer
            int id = Integer.parseInt(idStr);

            // Database connection details
            String dbUrl = "jdbc:mysql://localhost:3306/jdbc";
            String dbUser = "root";
            String dbPassword = "UmaMahesh@9";

            // Database connection and query
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                    String query = "SELECT name, age FROM emp WHERE id = ?";
                    try (PreparedStatement stmt = connection.prepareStatement(query)) {
                        stmt.setInt(1, id);
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                // Process the data if needed
                                String name = rs.getString("name");
                                int age = rs.getInt("age");
                                // Use 'name' and 'age' as needed, or perform other actions
                            } else {
                                // Handle case where no data is found
                            }
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                // Handle exceptions as needed
            }
        } catch (NumberFormatException e) {
            // Handle invalid ID format
        }
    }
%>

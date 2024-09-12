<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String id = request.getParameter("id");

    // Database connection parameters
    String url = "jdbc:mysql://localhost/your_database";
    String user = "your_username";
    String password = "your_password";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);
        String query = "DELETE FROM flag WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, id);
        int rowsAffected = stmt.executeUpdate();
        
        stmt.close();
        conn.close();
        
        if (rowsAffected > 0) {
            response.getWriter().write("Success");
        } else {
            response.getWriter().write("Failed");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("Error");
    }
%>

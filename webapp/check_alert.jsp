<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    response.setContentType("application/json");
    
    
    String id = request.getParameter("id");

    // Database connection parameters
    String url = "jdbc:mysql://localhost/jdbc";
    String user = "root";
    String password = "UmaMahesh@9";
    out.println(id);
    boolean exists = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);
        String query = "SELECT COUNT(*) FROM flag WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, id);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            exists = rs.getInt(1) > 0;
        }
        
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    out.print("{\"exists\": " + exists + "}");
%>

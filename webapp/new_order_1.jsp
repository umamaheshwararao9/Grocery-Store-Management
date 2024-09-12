<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>

<%
    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/jdbc";
    String dbUsername = "root";
    String dbPassword = "UmaMahesh@9";
    // Initialize variables
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String query = request.getParameter("data") != null ? request.getParameter("data") : "";
    
    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        
        // Create a statement
        stmt = conn.createStatement();
        
        // Prepare SQL query with search filter
        String sql = "SELECT id, name, price FROM items WHERE name LIKE '" + query + "%'";
        rs = stmt.executeQuery(sql);
        
        // Create an ArrayList to store item details
        ArrayList<JSONObject> itemList = new ArrayList<>();
       
        // Process the result set
        while (rs.next()) {
            JSONObject item = new JSONObject();
            item.put("id", rs.getInt("id"));
            item.put("name", rs.getString("name"));
            item.put("price", rs.getDouble("price"));
            itemList.add(item);
        }
        
        // Convert ArrayList to JSON array
        JSONArray jsonArray = new JSONArray(itemList);
        // Create JSON response
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("items", jsonArray);
        // Set the response content type and output the JSON
        response.setContentType("application/json");
        response.getWriter().print(jsonResponse.toString());
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
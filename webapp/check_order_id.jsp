<%@ page import="java.io.*, java.sql.*, java.util.ArrayList, org.json.JSONObject" %>
<%
    // Database credentials
    String dbURL = "jdbc:mysql://localhost:3306/your_database_name"; // replace with your database URL
    String dbUser = "root";
    String dbPassword = "UmaMahesh@9";

    // Create JSON response object
    JSONObject jsonResponse = new JSONObject();
    
    // Initialize ArrayList to store existing ord_id values
    ArrayList<Integer> existingIds = new ArrayList<>();
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Create SQL statement
        stmt = conn.createStatement();
        String sql = "SELECT ord_id FROM orders";
        
        // Execute query
        rs = stmt.executeQuery(sql);

        // Process result set and populate ArrayList
        while (rs.next()) {
            existingIds.add(rs.getInt("ord_id"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    // Generate a random number that is not in the ArrayList
    int randomNumber;
    boolean isUnique = false;

    while (!isUnique) {
    	randomNumber = (int) (10000000 + Math.random() * 90000000);; // Adjust the range if needed
        if (!existingIds.contains(randomNumber)) {
            isUnique = true;
            jsonResponse.put("number", randomNumber);
        }
    }

    // Set response content type to JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    // Write JSON response
    response.getWriter().write(jsonResponse.toString());
%>

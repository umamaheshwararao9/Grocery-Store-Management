<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>
<%@ page contentType="application/json" %>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/jdbc";
    String dbUser = "root";
    String dbPassword = "UmaMahesh@9";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT order_id, emp_id, total, time FROM emporders");

        JSONArray jsonArray = new JSONArray();
        while (rs.next()) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("order_id", rs.getInt("order_id"));
            jsonObject.put("emp_id", rs.getInt("emp_id"));
            jsonObject.put("total", rs.getFloat("total"));
            jsonObject.put("time", rs.getTime("time").toString()); // Convert time to string for JSON
            jsonArray.put(jsonObject);
        }
        out.print(jsonArray.toString());
    } catch (Exception e) {
        out.print("{\"error\": \"" + e.getMessage() + "\"}");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Items</title>
    <style>
        .message-box {
            width: 50%;
            height: 80%;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            margin: 10% auto;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            font-size: 1.5em;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <%
            String idParam = request.getParameter("id");
            boolean idExists = false;

            if (idParam != null && !idParam.trim().isEmpty()) {
                String jdbcUrl = "jdbc:mysql://localhost:3306/jdbc"; // Replace with your DB URL
                String jdbcUser = "root"; // Replace with your DB username
                String jdbcPassword = "UmaMahesh@9"; // Replace with your DB password
                
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver"); // Make sure to include MySQL JDBC driver in your classpath
                    conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);

                    // Check if the id exists in the table
                    String checkSql = "SELECT COUNT(*) FROM flag WHERE id = ?";
                    stmt = conn.prepareStatement(checkSql);
                    stmt.setString(1, idParam);
                    rs = stmt.executeQuery();
                    
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        idExists = (count > 0);
                    }

                    // If the id exists, delete it
                    if (idExists) {
                        String deleteSql = "DELETE FROM flag WHERE id = ?";
                        stmt = conn.prepareStatement(deleteSql);
                        stmt.setString(1, idParam);
                        int rowsAffected = stmt.executeUpdate();

                        if (rowsAffected > 0) {
                            out.println("<p>ID " + idParam + " has been successfully moved the items</p>");
                        } else {
                            out.println("<p>Failed to remove ID " + idParam + ".</p>");
                        }
                    } else {
                        out.println("<p>ID " + idParam + " does not exist in the flag table.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            } else {
                out.println("<p>No ID provided in the URL.</p>");
            }
        %>
    </div>
</body>
</html>

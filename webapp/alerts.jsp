<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Alert Page</title>
    <style>
        .alert-box {
            width: 100%;
            height: 80%;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            margin: 10% auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .alert-box p {
            font-size: 3em; /* Increased font size */
            margin: 0;
        }
        .alert-box button {
            margin-top: 20px;
            font-size: 1.5em;
            padding: 10px 20px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
        }
        .alert-box button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%
        String idParam = request.getParameter("id");
        boolean showAlert = false;

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
                String sql = "SELECT COUNT(*) FROM flag WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, idParam);
                rs = stmt.executeQuery();
                
                if (rs.next()) {
                    int count = rs.getInt(1);
                    showAlert = (count > 0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
    
    <div class="alert-box">
        <%
            if (showAlert) {
        %>
            <p>Change the items</p>
            <button onclick="window.location.href='changeItems.jsp?id=<%= idParam %>'">Changed</button>
        <%
            } else {
        %>
            <p>No alert</p>
        <%
            }
        %>
    </div>
</body>
</html>

<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Details</title>
    <style>
        /* General styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        /* Header styles */
        header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 24px;
        }

        /* Main content styles */
        main {
            padding: 20px;
            text-align: center;
            background-color: white;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Footer styles */
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
            font-size: 14px;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        /* Sign Out button styles */
        .sign-out-button {
            background-color: red;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
    <script>
        function confirmSignOut() {
            if (confirm("Do you want to sign out?")) {
                window.location.href = "signout.jsp";
            }
        }
    </script>
</head>
<body>
    <header>
        Employee Details
    </header>

    <main>
        <%
            // Retrieve the userId from the cookie
            String userId = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("userId".equals(cookie.getName())) {
                        userId = cookie.getValue();
                        break;
                    }
                }
            }
            if (userId != null) {
                // Database credentials
                String DB_URL = "jdbc:mysql://localhost:3306/jdbc";
                String DB_USER = "root";
                String DB_PASSWORD = "UmaMahesh@9";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Query to retrieve employee details
                    String sql = "SELECT name, age FROM emp WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(userId));
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String name = rs.getString("name");
                        int age = rs.getInt("age");
                        out.println("<p>Employee ID: " + userId + "</p>");
                        out.println("<p>Name: " + name + "</p>");
                        out.println("<p>Age: " + age + "</p>");
                    } else {
                        out.println("<p>No employee found with ID " + userId + "</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>No user ID found in cookies.</p>");
            }
        %>

        <!-- Sign Out Button -->
        <button class="sign-out-button" onclick="confirmSignOut()">Sign Out</button>
    </main>

    <footer>
        &copy; 2024 Grocery Store Management. All rights reserved.
    </footer>
</body>
</html>

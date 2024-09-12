<%@ page import="java.sql.*, javax.servlet.http.Cookie" %>

<%
    // Retrieve the cookies
    Cookie[] cookies = request.getCookies();
    String orderId = null;
    String userId = null;
    String totalAmountStr = null;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("orderId".equals(cookie.getName())) {
                orderId = cookie.getValue();
            }
            if ("userId".equals(cookie.getName())) {
                userId = cookie.getValue();
            }
            if ("totalAmount".equals(cookie.getName())) {
                totalAmountStr = cookie.getValue();
            }
        }
    }

    // Log retrieved values
    out.println("Retrieved orderId cookie: " + orderId);
    out.println("Retrieved userId cookie: " + userId);
    out.println("Retrieved totalAmount cookie: '" + totalAmountStr + "'");

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/jdbc";
    String dbUser = "root";
    String dbPassword = "UmaMahesh@9";
    Connection conn = null;

    try {
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Convert total amount to float
        float totalAmount = 0.0f;
        if (totalAmountStr != null && !totalAmountStr.trim().isEmpty()) {
            totalAmountStr = totalAmountStr.trim();
            out.println("TotalAmountStr (trimmed): '" + totalAmountStr + "'");

            // Print each character of the totalAmountStr
            out.println("TotalAmountStr characters (ASCII values):");
            for (char c : totalAmountStr.toCharArray()) {
                out.println("Character: " + c + " (ASCII: " + (int) c + ")");
            }

            // Check if the string is a valid float
            try {
                totalAmount = Float.parseFloat(totalAmountStr);
                out.println("Conversion successful: " + totalAmount);
            } catch (NumberFormatException e) {
                out.println("Error converting totalAmountStr to float: " + e.getMessage());
                totalAmount = 0.0f; // Default value
            }
        } else {
            out.println("Total amount cookie is empty.");
        }

        // Log the final value to be inserted
        out.println("Final totalAmount to be inserted: " + totalAmount);

        // Insert the order details into the emporders table
        if (orderId != null && !orderId.trim().isEmpty() && userId != null && !userId.trim().isEmpty()) {
            int orderIdInt = Integer.parseInt(orderId);
            String sqlOrder = "INSERT INTO emporders (order_id, emp_id, total) VALUES (?, ?, ?)";
            PreparedStatement statementOrder = conn.prepareStatement(sqlOrder);
            statementOrder.setInt(1, orderIdInt);
            statementOrder.setString(2, userId);
            statementOrder.setFloat(3, totalAmount);

            int rowsInserted = statementOrder.executeUpdate();
            if (rowsInserted > 0) {
                out.println("Order data successfully inserted!");
            } else {
                out.println("Failed to insert order data.");
            }
        } else {
            out.println("Required cookies are missing or empty.");
        }
    } catch (NumberFormatException e) {
        out.println("Invalid order ID format.");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Database connection failed: " + e.getMessage());
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

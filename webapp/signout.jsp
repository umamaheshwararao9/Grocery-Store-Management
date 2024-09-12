<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Out</title>
    <script>
        function redirectToIndex() {
            // Redirect to index.jsp after clearing cookies and session
            window.location.href = "index.jsp";
        }
    </script>
</head>
<body onload="redirectToIndex()">
    <%
        // Set cache-control headers
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");

        // Invalidate session and clear cookies
        
        
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userId".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    cookie.setValue(null);
                    response.addCookie(cookie);
                }
            }
        }
    %>
    <p>Signing out...</p>
</body>
</html>

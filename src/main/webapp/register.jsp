<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("currentPage", "login");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap">
    <div class="site-shell">
        <div class="center-panel register-card">
            <h1 class="page-title">Create Staff Account</h1>
            <p class="page-subtitle">Register a new account to access the reservation management system.</p>

            <% if (request.getAttribute("error") != null) { %>
            <div class="msg error"><%= request.getAttribute("error") %></div>
            <% } %>

            <% if (request.getAttribute("success") != null) { %>
            <div class="msg success"><%= request.getAttribute("success") %></div>
            <% } %>

            <form action="register" method="post">
                <div class="field">
                    <label>Full Name</label>
                    <input type="text" name="fullName" placeholder="Enter full name" required>
                </div>

                <div class="field">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Choose a username" required>
                </div>

                <div class="field">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create a password" required>
                    <div class="password-hint">Use at least 6 characters for demo safety.</div>
                </div>

                <div class="field">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" placeholder="Re-enter password" required>
                </div>

                <div class="top-actions">
                    <button type="submit">Register Account</button>
                    <a class="btn btn-secondary" href="login.jsp">Back to Login</a>
                </div>
            </form>
        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
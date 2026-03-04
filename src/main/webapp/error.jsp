<!DOCTYPE html>
<html>
<head>
    <title>Error - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap">
    <div class="site-shell">
        <div class="center-panel narrow">
            <h1 class="page-title">Something went wrong</h1>
            <p class="page-subtitle">An unexpected error occurred while processing your request.</p>

            <div class="msg error">
                Please try again. If the issue continues, return to the dashboard or log in again.
            </div>

            <div class="top-actions">
                <a class="btn btn-primary" href="dashboard.jsp">Go to Dashboard</a>
                <a class="btn btn-secondary" href="login.jsp">Go to Login</a>
            </div>
        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
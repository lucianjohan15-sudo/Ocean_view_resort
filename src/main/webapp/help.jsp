<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("currentPage", "help");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Help - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap">
    <div class="site-shell">
        <div class="center-panel">
            <h1 class="page-title">Help Center</h1>
            <p class="page-subtitle">Quick guidance for staff to use the reservation system correctly.</p>

            <div class="top-actions">
                <a class="btn btn-secondary" href="dashboard.jsp">← Dashboard</a>
                <a class="btn btn-secondary" href="addReservation.jsp">Add Reservation</a>
                <a class="btn btn-secondary" href="viewReservation.jsp">View Reservation</a>
                <a class="btn btn-secondary" href="bill.jsp">Calculate Bill</a>
            </div>

            <div class="help-grid">
                <div class="panel">
                    <h3>How to Use the System</h3>
                    <ol>
                        <li><strong>Login:</strong> Use your staff username and password to access the dashboard.</li>
                        <li><strong>Add Reservation:</strong> Fill guest details, select room type, and enter stay dates.</li>
                        <li><strong>Display Reservation:</strong> Search using the reservation number to view saved details.</li>
                        <li><strong>Calculate Bill:</strong> Generate bill using reservation number to calculate total cost.</li>
                        <li><strong>Print Bill:</strong> Use the print button from the bill page.</li>
                        <li><strong>Logout:</strong> Click Logout after finishing work.</li>
                    </ol>
                </div>

                <div class="panel">
                    <h3>Validation Rules</h3>
                    <ul>
                        <li>All form fields are required.</li>
                        <li>Reservation number must be unique.</li>
                        <li>Check-out date must be after check-in date.</li>
                        <li>Reservation must exist before bill generation.</li>
                    </ul>

                    <hr class="soft">

                    <h3>Helpful Tips</h3>
                    <ul>
                        <li>Use reservation numbers like <strong>RES1001</strong>.</li>
                        <li>Double-check room type and dates before saving.</li>
                        <li>Use “View Reservation” before bill generation if needed.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("currentPage", "view");

    Reservation r = (Reservation) request.getAttribute("reservation");
    List<Reservation> allReservations = (List<Reservation>) request.getAttribute("allReservations");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reservation - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">

    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--line);
            flex-wrap: wrap;
            gap: 16px;
        }

        /* Upgraded Search Bar */
        .search-container {
            background: var(--soft);
            padding: 20px;
            border-radius: 12px;
            border: 1px solid #cfe4ff;
            margin-bottom: 24px;
        }

        .search-container .inline-form {
            margin-top: 0;
            grid-template-columns: 1fr auto;
        }

        .search-input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .search-input-wrapper svg {
            position: absolute;
            left: 14px;
            color: var(--muted);
        }

        .search-input-wrapper input {
            padding-left: 42px; /* Make room for the icon */
            border-color: #c1dcfb;
            box-shadow: 0 2px 6px rgba(13,110,253,0.05);
        }

        /* Reservation Detail Card (Replaces the plain table) */
        .detail-card {
            background: #ffffff;
            border: 1px solid var(--line);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.04);
            margin-bottom: 32px;
        }

        .detail-card-header {
            background: linear-gradient(135deg, var(--soft), #ffffff);
            padding: 20px 24px;
            border-bottom: 1px solid var(--line);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .res-badge {
            background: var(--primary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 24px;
            padding: 24px;
        }

        .info-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .info-label {
            color: var(--muted);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            color: var(--dark);
            font-size: 1.05rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-value svg {
            color: var(--primary);
            width: 18px;
            height: 18px;
        }

        /* Modern Data Table Enhancements */
        .modern-table {
            border: none;
            box-shadow: none;
        }

        .modern-table th {
            background: #f8fafc;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
            color: #64748b;
            padding: 16px 14px;
            border-bottom: 2px solid var(--line);
        }

        .modern-table td {
            vertical-align: middle;
            color: #334155;
            border-bottom: 1px solid #f1f5f9;
        }

        .modern-table tbody tr:hover {
            background: #f8fbff;
        }

        /* Tiny action buttons for table rows */
        .action-links {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            font-size: 0.8rem;
            padding: 4px 10px;
            border-radius: 6px;
            background: var(--soft);
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            border: 1px solid #cfe4ff;
            transition: all 0.15s ease;
        }

        .action-btn:hover {
            background: var(--primary);
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap">
    <div class="site-shell">
        <div class="center-panel" style="max-width: 1100px;">

            <div class="page-header">
                <div>
                    <h1 class="page-title">Reservation Details</h1>
                    <p class="page-subtitle">Search for a specific booking or browse all recent reservations.</p>
                </div>
                <div class="top-actions" style="margin-top: 0;">
                    <a class="btn btn-secondary" href="dashboard.jsp">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
                        Dashboard
                    </a>
                    <a class="btn btn-primary" href="addReservation.jsp">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                        Add Reservation
                    </a>
                </div>
            </div>

            <div class="search-container">
                <form action="viewReservation" method="get" class="inline-form">
                    <div class="search-input-wrapper">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        <input type="text" name="reservationNo" placeholder="Enter Reservation No (e.g. RES1001)" required>
                    </div>
                    <button type="submit">Search Booking</button>
                </form>
            </div>

            <% if (request.getAttribute("error") != null) { %>
            <div class="msg error"><%= request.getAttribute("error") %></div>
            <% } %>

            <% if (r != null) { %>
            <div class="detail-card">
                <div class="detail-card-header">
                    <h2 style="margin:0; font-size: 1.25rem; color: var(--dark);">Guest Information</h2>
                    <span class="res-badge"><%= r.getReservationNo() %></span>
                </div>

                <div class="info-grid">
                    <div class="info-group">
                        <span class="info-label">Guest Name</span>
                        <span class="info-value">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            <%= r.getGuestName() %>
                        </span>
                    </div>

                    <div class="info-group">
                        <span class="info-label">Contact Number</span>
                        <span class="info-value">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                            <%= r.getContactNumber() %>
                        </span>
                    </div>

                    <div class="info-group">
                        <span class="info-label">Room Type</span>
                        <span class="info-value">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                            <%= r.getRoomTypeName() %>
                        </span>
                    </div>

                    <div class="info-group">
                        <span class="info-label">Rate per Night</span>
                        <span class="info-value">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
                            LKR <%= r.getRatePerNight() %>
                        </span>
                    </div>

                    <div class="info-group">
                        <span class="info-label">Check-in Date</span>
                        <span class="info-value">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                            <%= r.getCheckInDate() %>
                        </span>
                    </div>

                    <div class="info-group">
                        <span class="info-label">Check-out Date</span>
                        <span class="info-value">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                            <%= r.getCheckOutDate() %>
                        </span>
                    </div>

                    <div class="info-group" style="grid-column: 1 / -1;">
                        <span class="info-label">Address</span>
                        <span class="info-value" style="color: var(--muted); font-size: 0.95rem;">
                            <%= r.getAddress() %>
                        </span>
                    </div>
                </div>

                <div style="padding: 16px 24px; background: #f8fbff; border-top: 1px solid var(--line); display: flex; justify-content: flex-end;">
                    <a class="btn btn-primary" href="bill?reservationNo=<%= r.getReservationNo() %>">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                        Generate Final Bill
                    </a>
                </div>
            </div>
            <% } %>

            <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 40px; margin-bottom: 16px;">
                <h2 style="margin:0; font-size: 1.3rem; color: var(--dark);">All Booked Reservations</h2>
            </div>

            <% if (allReservations != null && !allReservations.isEmpty()) { %>
            <div class="table-wrap" style="border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(15, 23, 42, 0.03);">
                <table class="modern-table">
                    <thead>
                    <tr>
                        <th style="width:120px;">Res. No</th>
                        <th>Guest Name</th>
                        <th>Room Type</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Contact</th>
                        <th style="width:140px; text-align: right;">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Reservation item : allReservations) { %>
                    <tr>
                        <td style="font-weight: 600; color: var(--primary);"><%= item.getReservationNo() %></td>
                        <td style="font-weight: 500;"><%= item.getGuestName() %></td>
                        <td><span style="background: #e2e8f0; padding: 2px 8px; border-radius: 4px; font-size: 0.8rem; font-weight: 600; color: #475569;"><%= item.getRoomTypeName() %></span></td>
                        <td><%= item.getCheckInDate() %></td>
                        <td><%= item.getCheckOutDate() %></td>
                        <td style="color: var(--muted);"><%= item.getContactNumber() %></td>
                        <td>
                            <div class="action-links" style="justify-content: flex-end;">
                                <a class="action-btn" href="viewReservation?reservationNo=<%= item.getReservationNo() %>">View</a>
                                <a class="action-btn" href="bill?reservationNo=<%= item.getReservationNo() %>" style="background: white;">Bill</a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="empty-state" style="padding: 40px; margin-top: 20px;">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#cbd5e1" stroke-width="1" style="margin-bottom: 16px;"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="9" y1="21" x2="9" y2="9"></line></svg>
                <h3 style="margin: 0 0 8px; color: #475569;">No Reservations Found</h3>
                <p style="margin: 0;">It looks like the system is empty. Start by adding a new reservation.</p>
            </div>
            <% } %>
        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
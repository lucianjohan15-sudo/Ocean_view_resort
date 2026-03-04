<%@ page import="com.oceanview.dao.RoomTypeDAO" %>
<%@ page import="com.oceanview.model.RoomType" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    request.setAttribute("currentPage", "add");

    RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
    List<RoomType> roomTypes = roomTypeDAO.getAllRoomTypes();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Reservation - Ocean View Resort</title>
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

        /* Form Layout Enhancements */
        .form-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-top: 24px;
        }

        /* Section Cards */
        .form-section {
            background: #ffffff;
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.02);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px dashed var(--line);
        }

        .section-icon {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            background: var(--soft);
            color: var(--primary);
            display: grid;
            place-items: center;
        }

        .section-title {
            margin: 0;
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--dark);
        }

        /* Input Enhancements */
        .field label {
            font-weight: 600;
            color: #475569;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .field input, .field select, .field textarea {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            color: #334155;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.02);
        }

        .field input:focus, .field select:focus, .field textarea:focus {
            background: #ffffff;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(13,110,253,0.1);
        }

        .field textarea {
            min-height: 110px;
        }

        /* Bottom Action Bar */
        .form-actions {
            margin-top: 24px;
            padding: 20px;
            background: #f8fbff;
            border: 1px solid #cfe4ff;
            border-radius: 16px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 12px;
        }

        .btn-large {
            padding: 12px 24px;
            font-size: 1rem;
        }

        /* Responsive */
        @media (max-width: 860px) {
            .form-layout {
                grid-template-columns: 1fr;
            }
        }

        /* Message Enhancements */
        .msg { display: flex; align-items: center; gap: 10px; font-weight: 500; }
        .msg svg { width: 20px; height: 20px; flex-shrink: 0; }
    </style>
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap">
    <div class="site-shell">
        <div class="center-panel" style="max-width: 1000px;">

            <div class="page-header">
                <div>
                    <h1 class="page-title">New Reservation</h1>
                    <p class="page-subtitle">Enter guest details and stay information to create a booking.</p>
                </div>
                <div class="top-actions" style="margin-top: 0;">
                    <a class="btn btn-secondary" href="dashboard.jsp">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
                        Dashboard
                    </a>
                    <a class="btn btn-secondary" href="viewReservation.jsp">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        Find Booking
                    </a>
                </div>
            </div>

            <% if (request.getAttribute("success") != null) { %>
            <div class="msg success" style="margin-bottom: 24px;">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                <%= request.getAttribute("success") %>
            </div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
            <div class="msg error" style="margin-bottom: 24px;">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="addReservation" method="post">

                <div class="form-layout">
                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            </div>
                            <h2 class="section-title">Guest Information</h2>
                        </div>

                        <div style="display: flex; flex-direction: column; gap: 16px;">
                            <div class="field">
                                <label>Reservation Number</label>
                                <input type="text" name="reservationNo" placeholder="e.g. RES1001" required autofocus>
                            </div>

                            <div class="field">
                                <label>Guest Full Name</label>
                                <input type="text" name="guestName" placeholder="Enter guest name" required>
                            </div>

                            <div class="field">
                                <label>Contact Number</label>
                                <input type="tel" name="contactNumber" placeholder="e.g. 0771234567" required>
                            </div>

                            <div class="field">
                                <label>Billing Address</label>
                                <textarea name="address" placeholder="Enter complete guest address" required></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                            </div>
                            <h2 class="section-title">Stay Details</h2>
                        </div>

                        <div style="display: flex; flex-direction: column; gap: 16px;">
                            <div class="field">
                                <label>Room Type</label>
                                <select name="roomTypeId" required>
                                    <option value="" disabled selected>-- Select a Room Type --</option>
                                    <% for (RoomType rt : roomTypes) { %>
                                    <option value="<%= rt.getRoomTypeId() %>">
                                        <%= rt.getRoomTypeName() %> (LKR <%= rt.getRatePerNight() %> / night)
                                    </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-grid" style="margin-top: 0;">
                                <div class="field">
                                    <label>Check-in Date</label>
                                    <input type="date" name="checkInDate" required>
                                </div>

                                <div class="field">
                                    <label>Check-out Date</label>
                                    <input type="date" name="checkOutDate" required>
                                </div>
                            </div>

                            <div style="margin-top: auto; padding: 16px; background: #f8fafc; border-radius: 12px; border: 1px dashed #cbd5e1; color: #64748b; font-size: 0.85rem; line-height: 1.5;">
                                <strong>Note:</strong> Standard check-in time is 2:00 PM and check-out is 11:00 AM. Early check-in is subject to room availability.
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <a class="btn btn-secondary btn-large" href="dashboard.jsp" style="background: transparent; border: none;">Cancel</a>
                    <button type="submit" class="btn-primary btn-large">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                        Save Reservation
                    </button>
                </div>
            </form>

        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
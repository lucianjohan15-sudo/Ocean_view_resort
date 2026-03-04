<%@ page import="com.oceanview.model.Reservation" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("currentPage", "bill");

    Reservation r = (Reservation) request.getAttribute("reservation");
    Long nights = (Long) request.getAttribute("nights");
    Object total = request.getAttribute("total");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculate Bill - Ocean View Resort</title>
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
            margin-bottom: 32px;
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
            padding-left: 42px;
            border-color: #c1dcfb;
            box-shadow: 0 2px 6px rgba(13,110,253,0.05);
            background: #ffffff;
        }

        /* The Beautiful Invoice Layout */
        .invoice-wrapper {
            background: #ffffff;
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.05);
            margin-bottom: 24px;
            color: var(--text);
        }

        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid var(--line);
            padding-bottom: 24px;
            margin-bottom: 24px;
        }

        .brand-section {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .brand-section .logo-block {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            border-radius: 14px;
            display: grid;
            place-items: center;
            font-size: 1.2rem;
            font-weight: 800;
            box-shadow: 0 8px 16px rgba(13,110,253,0.2);
        }

        .brand-details h2 {
            margin: 0 0 4px 0;
            font-size: 1.4rem;
            color: var(--dark);
        }

        .brand-details p {
            margin: 0;
            color: var(--muted);
            font-size: 0.9rem;
        }

        .meta-section {
            text-align: right;
        }

        .meta-section h1 {
            margin: 0 0 8px 0;
            font-size: 2rem;
            color: #cbd5e1;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .meta-grid {
            display: grid;
            grid-template-columns: auto auto;
            gap: 8px 16px;
            font-size: 0.9rem;
            text-align: right;
        }

        .meta-label { color: var(--muted); font-weight: 600; }
        .meta-value { color: var(--dark); font-weight: 700; }

        /* Two-Column Info Layout */
        .invoice-info-split {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-bottom: 32px;
            background: #f8fafc;
            padding: 24px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .info-block h3 {
            font-size: 0.85rem;
            text-transform: uppercase;
            color: var(--muted);
            letter-spacing: 1px;
            margin: 0 0 12px 0;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 8px;
        }

        .info-data p {
            margin: 0 0 6px 0;
            font-size: 0.95rem;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-data svg { width: 16px; height: 16px; color: var(--primary); }

        /* Formal Table */
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 32px;
        }

        .invoice-table th {
            background: var(--dark);
            color: white;
            text-transform: uppercase;
            font-size: 0.85rem;
            padding: 12px 16px;
            text-align: left;
        }

        .invoice-table th:last-child { text-align: right; border-radius: 0 8px 8px 0; }
        .invoice-table th:first-child { border-radius: 8px 0 0 8px; }

        .invoice-table td {
            padding: 16px;
            border-bottom: 1px solid var(--line);
            color: var(--dark);
        }

        .invoice-table td:last-child { text-align: right; font-weight: 600; }

        /* Calculation Footer */
        .invoice-summary {
            display: flex;
            justify-content: flex-end;
        }

        .summary-box {
            width: 320px;
            background: #f8fafc;
            border-radius: 12px;
            padding: 20px;
            border: 1px solid #e2e8f0;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 0.95rem;
            color: var(--muted);
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 2px dashed #cbd5e1;
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--primary);
        }

        .print-btn-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 24px;
        }

        /* Print Media Queries */
        @media print {
            .site-header, .site-footer, .actions-print-hide, .page-header, .print-btn-wrapper {
                display: none !important;
            }
            body { background: white; }
            .main-wrap, .site-shell, .center-panel {
                padding: 0; margin: 0; max-width: 100%; border: none; box-shadow: none;
            }
            .invoice-wrapper {
                border: none; box-shadow: none; padding: 0;
            }
            .invoice-info-split {
                background: white; border-color: #000;
            }
            .invoice-table th {
                background: #f1f5f9; color: #000; -webkit-print-color-adjust: exact;
            }
        }
    </style>
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap">
    <div class="site-shell">
        <div class="center-panel" style="max-width: 900px;">

            <div class="page-header actions-print-hide">
                <div>
                    <h1 class="page-title">Generate Invoice</h1>
                    <p class="page-subtitle">Search by reservation number to create a printable guest bill.</p>
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

            <div class="search-container actions-print-hide">
                <form action="bill" method="get" class="inline-form">
                    <div class="search-input-wrapper">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                        <input type="text" name="reservationNo" placeholder="Enter Reservation No (e.g. RES1001)" required>
                    </div>
                    <button type="submit" class="btn-primary">Calculate Bill</button>
                </form>
            </div>

            <% if (request.getAttribute("error") != null) { %>
            <div class="msg error actions-print-hide" style="margin-bottom: 24px;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <% if (r != null) { %>
            <div class="invoice-wrapper">

                <div class="invoice-header">
                    <div class="brand-section">
                        <div class="logo-block">OV</div>
                        <div class="brand-details">
                            <h2>Ocean View Resort</h2>
                            <p>123 Coastal Drive, Colombo, Sri Lanka</p>
                            <p>contact@oceanview.lk | +94 77 123 4567</p>
                        </div>
                    </div>
                    <div class="meta-section">
                        <h1>Invoice</h1>
                        <div class="meta-grid">
                            <span class="meta-label">Invoice Ref:</span>
                            <span class="meta-value"><%= r.getReservationNo() %></span>
                            <span class="meta-label">Issue Date:</span>
                            <span class="meta-value"><%= java.time.LocalDate.now() %></span>
                            <span class="meta-label">Status:</span>
                            <span class="meta-value" style="color: #166534; background: #bbf7d0; padding: 2px 8px; border-radius: 4px; font-size: 0.8rem;">DUE</span>
                        </div>
                    </div>
                </div>

                <div class="invoice-info-split">
                    <div class="info-block">
                        <h3>Billed To</h3>
                        <div class="info-data">
                            <p style="font-weight: 700; font-size: 1.1rem; color: var(--dark); margin-bottom: 8px;">
                                <%= r.getGuestName() %>
                            </p>
                            <p><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg> <%= r.getContactNumber() %></p>
                            <p style="color: var(--muted); font-size: 0.85rem; margin-top: 8px; align-items: flex-start;">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-top: 2px;"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                <span><%= r.getAddress() != null ? r.getAddress() : "Address not provided" %></span>
                            </p>
                        </div>
                    </div>
                    <div class="info-block">
                        <h3>Stay Details</h3>
                        <div class="info-data">
                            <p><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> <strong>Room Type:</strong> <%= r.getRoomTypeName() %></p>
                            <p><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg> <strong>Check-in:</strong> &nbsp; <%= r.getCheckInDate() %></p>
                            <p><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg> <strong>Check-out:</strong> <%= r.getCheckOutDate() %></p>
                        </div>
                    </div>
                </div>

                <table class="invoice-table">
                    <thead>
                    <tr>
                        <th>Description</th>
                        <th style="text-align: center;">Nights</th>
                        <th style="text-align: right;">Rate (LKR)</th>
                        <th>Amount (LKR)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <strong style="color: var(--dark);"><%= r.getRoomTypeName() %> Accommodation</strong><br>
                            <span style="font-size: 0.85rem; color: var(--muted);">From <%= r.getCheckInDate() %> to <%= r.getCheckOutDate() %></span>
                        </td>
                        <td style="text-align: center;"><%= nights %></td>
                        <td style="text-align: right;"><%= r.getRatePerNight() %></td>
                        <td><%= total %></td>
                    </tr>
                    </tbody>
                </table>

                <div class="invoice-summary">
                    <div class="summary-box">
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>LKR <%= total %></span>
                        </div>
                        <div class="summary-row">
                            <span>Taxes & Fees</span>
                            <span>Included</span>
                        </div>
                        <div class="summary-total">
                            <span>Grand Total</span>
                            <span>LKR <%= total %></span>
                        </div>
                    </div>
                </div>

            </div>

            <div class="print-btn-wrapper actions-print-hide">
                <button type="button" class="btn-primary" onclick="window.print()" style="padding: 14px 28px; font-size: 1.05rem;">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect x="6" y="14" width="12" height="8"></rect></svg>
                    Print Final Invoice
                </button>
            </div>

            <% } else { %>
            <div class="empty-state actions-print-hide" style="padding: 40px; margin-top: 20px;">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#cbd5e1" stroke-width="1" style="margin-bottom: 16px;"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                <h3 style="margin: 0 0 8px; color: #475569;">No Invoice Generated</h3>
                <p style="margin: 0;">Enter a valid reservation number above to calculate and preview the bill.</p>
            </div>
            <% } %>

        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
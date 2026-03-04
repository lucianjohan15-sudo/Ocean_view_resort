<%@ page import="com.oceanview.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("currentPage", "dashboard");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">

    <style>
        /* Base overrides to make the canvas feel wider and more expansive */
        .center-panel {
            max-width: 1200px !important;
            padding: 0 !important;
            background: transparent !important;
            box-shadow: none !important;
            border: none !important;
        }

        /* The Premium Command Center Hero */
        .dash-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            border-radius: 20px;
            padding: 48px 40px;
            color: #ffffff;
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
            box-shadow: 0 25px 50px -12px rgba(15, 23, 42, 0.4);
            border: 1px solid rgba(255,255,255,0.1);
        }

        /* Subtle grid pattern for the industrial feel */
        .dash-hero::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background-image:
                    linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
            background-size: 30px 30px;
            pointer-events: none;
        }

        /* A glowing ambient light effect */
        .dash-hero::after {
            content: '';
            position: absolute;
            top: -50%; right: -10%;
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(13,110,253,0.15) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
        }

        .dash-hero-content {
            position: relative;
            z-index: 10;
        }

        .dash-hero .page-title {
            color: #ffffff;
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 8px;
        }

        .dash-hero .page-subtitle {
            color: #94a3b8;
            font-size: 1.05rem;
            max-width: 600px;
        }

        /* The Info/Tip Bar inside the Hero */
        .hero-banner {
            margin-top: 24px;
            background: rgba(15, 23, 42, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(10px);
            color: #cbd5e1;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            padding: 12px 20px;
            border-radius: 99px;
            font-size: 0.9rem;
        }

        .hero-banner svg {
            color: #38bdf8;
        }

        /* The High-End Card Grid */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
        }

        .menu-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 32px 24px;
            display: flex;
            flex-direction: column;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02), 0 2px 4px -1px rgba(0, 0, 0, 0.02);
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
            overflow: hidden;
            text-decoration: none;
            group: card;
        }

        /* The Premium Top-Border Glow Effect */
        .menu-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .menu-card:hover {
            transform: translateY(-6px);
            border-color: #cbd5e1;
            box-shadow: 0 20px 25px -5px rgba(15, 23, 42, 0.1), 0 8px 10px -6px rgba(15, 23, 42, 0.05);
        }

        .menu-card:hover::before {
            transform: scaleX(1);
        }

        /* Beautiful layered icon containers */
        .card-icon {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            background: #f8fafc;
            border: 1px solid #f1f5f9;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
            box-shadow: inset 0 2px 4px rgba(255,255,255,0.8), 0 4px 8px rgba(15,23,42,0.04);
            transition: all 0.3s ease;
        }

        .menu-card:hover .card-icon {
            background: var(--soft);
            color: var(--primary-2);
            transform: scale(1.05);
        }

        .menu-card .menu-title {
            font-size: 1.2rem;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 10px;
            letter-spacing: -0.3px;
        }

        .menu-card .menu-text {
            color: #64748b;
            font-size: 0.95rem;
            line-height: 1.6;
            flex-grow: 1;
        }

        /* The dynamic action footer inside the card */
        .card-action {
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            opacity: 0.8;
            transition: all 0.3s ease;
        }

        .card-action svg {
            transition: transform 0.3s ease;
        }

        .menu-card:hover .card-action {
            opacity: 1;
        }

        .menu-card:hover .card-action svg {
            transform: translateX(6px);
        }

        /* Danger Card Overrides */
        .menu-card.danger::before {
            background: linear-gradient(90deg, #ef4444, #f43f5e);
        }
        .menu-card.danger:hover .card-icon {
            background: #fff1f2;
            color: #e11d48;
        }
        .menu-card.danger .card-action {
            color: #e11d48;
        }
    </style>
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap">
    <div class="site-shell">
        <div class="center-panel">

            <div class="dash-hero">
                <div class="dash-hero-content">
                    <h1 class="page-title">Reservation Control Center</h1>
                    <p class="page-subtitle">Manage operations, track guest stays, and generate billing invoices from your central dashboard.</p>

                    <div class="hero-banner">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="M12 16v-4"></path><path d="M12 8h.01"></path></svg>
                        <span><strong>System Tip:</strong> Generate a reservation number first to connect billing and guest search records.</span>
                    </div>
                </div>
            </div>

            <div class="menu-grid">

                <a class="menu-card" href="addReservation.jsp">
                    <div class="card-icon">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="8.5" cy="7" r="4"></circle><line x1="20" y1="8" x2="20" y2="14"></line><line x1="23" y1="11" x2="17" y2="11"></line></svg>
                    </div>
                    <div class="menu-title">New Reservation</div>
                    <div class="menu-text">Initialize a new booking profile with guest details, requested room type, and occupancy dates.</div>
                    <div class="card-action">
                        Launch Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                    </div>
                </a>

                <a class="menu-card" href="viewReservation.jsp">
                    <div class="card-icon">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <div class="menu-title">Search Directory</div>
                    <div class="menu-text">Query the active database to view comprehensive reservation metrics using a booking reference.</div>
                    <div class="card-action">
                        Launch Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                    </div>
                </a>

                <a class="menu-card" href="bill.jsp">
                    <div class="card-icon">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line><path d="M8 14h.01"></path><path d="M12 14h.01"></path><path d="M16 14h.01"></path><path d="M8 18h.01"></path><path d="M12 18h.01"></path><path d="M16 18h.01"></path></svg>
                    </div>
                    <div class="menu-title">Billing & Invoicing</div>
                    <div class="menu-text">Compute final guest folios, calculate total stay duration, and execute printable PDF invoices.</div>
                    <div class="card-action">
                        Launch Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                    </div>
                </a>

                <a class="menu-card" href="help.jsp">
                    <div class="card-icon">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
                    </div>
                    <div class="menu-title">Documentation</div>
                    <div class="menu-text">Access system protocols, data entry validation rules, and operational troubleshooting guides.</div>
                    <div class="card-action">
                        Read Docs <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                    </div>
                </a>

                <a class="menu-card danger" href="logout">
                    <div class="card-icon">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
                    </div>
                    <div class="menu-title">Terminate Session</div>
                    <div class="menu-text">Securely close the active dashboard session to maintain data integrity and compliance.</div>
                    <div class="card-action">
                        Log Out <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                    </div>
                </a>
            </div>

        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
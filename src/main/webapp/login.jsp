<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("currentPage", "login");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">

    <style>
        .login-wrapper {
            /* Vertically centers the login box, assuming header/footer take up ~160px */
            min-height: calc(100vh - 160px);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-panel {
            width: 100%;
            max-width: 420px;
            padding: 40px 36px;
            border-radius: 20px;
            /* Enhances your existing shadow for a deeper, floating effect */
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.08), 0 1px 3px rgba(0,0,0,0.05);
            /* Adds a slight glass/frosted effect over your global background */
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            margin: 0 auto;
        }

        .login-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .login-icon {
            width: 56px;
            height: 56px;
            margin: 0 auto 16px;
            background: linear-gradient(135deg, var(--soft), #ffffff);
            border: 1px solid var(--line);
            border-radius: 16px;
            display: grid;
            place-items: center;
            color: var(--primary);
            box-shadow: 0 8px 16px rgba(13, 110, 253, 0.1);
        }

        .btn-full {
            width: 100%;
            padding: 14px;
            font-size: 1.05rem;
            margin-top: 8px;
        }

        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: -4px;
            margin-bottom: 20px;
            font-size: 0.88rem;
        }

        .login-options label {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--muted);
            font-weight: 500;
            margin: 0;
            cursor: pointer;
        }

        .login-options input[type="checkbox"] {
            width: 16px;
            height: 16px;
            margin: 0;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%@ include file="includes/header.jspf" %>

<main class="main-wrap login-wrapper">
    <div class="site-shell">
        <div class="login-panel">

            <div class="login-header">
                <div class="login-icon">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                </div>
                <h1 class="page-title">Welcome Back</h1>
                <p class="page-subtitle">Sign in to Ocean View Resort</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
            <div class="msg error" style="margin-bottom: 20px; display: flex; align-items: center; gap: 8px;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="login" method="post">
                <div class="field">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="e.g. admin" required autofocus>
                </div>

                <div class="field">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>

                <div class="login-options">
                    <label>
                        <input type="checkbox" name="remember"> Remember me
                    </label>
                    <a href="#forgot" style="font-weight: 600;">Forgot Password?</a>
                </div>

                <div class="top-actions" style="margin-top:0;">
                    <button type="submit" class="btn-primary btn-full">Sign In</button>
                </div>
            </form>

        </div>
    </div>
</main>

<%@ include file="includes/footer.jspf" %>
</body>
</html>
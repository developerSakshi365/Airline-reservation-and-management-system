<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ✅ Prevent logged-in users from accessing login/register page
    String username = (String) session.getAttribute("username");
    if (username != null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login / Register</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
    <style>
        nav {
            background:#02487c;
            padding: 15px 40px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .navbar {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
        }
        .nav-left, .nav-right {
            list-style: none;
            display: flex;
            gap: 40px;
            margin: 0;
            padding: 0;
        }
        .nav-logo img {
            height: 60px;
            display: block;
            margin: 0 auto;
        }
        .nav-right-container {
            display: flex;
            align-items: center;
            gap: 20px;
            justify-content: flex-end;
        }
        .navbar button {
            padding: 10px 20px;
            border-radius: 50px;
            background: white;
            border: none;
            cursor: pointer;
        }
        .navbar button a {
            color: black;
            text-decoration: none;
            font-weight: bold;
        }
        .nav-left li a, .nav-right li a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: color 0.3s ease;
        }
        .nav-left li a:hover, .nav-right li a:hover {
            color: #00aaff;
        }
    </style>
</head>
<body>
<nav>
    <div class="navbar">
        <!-- Left links -->
        <ul class="nav-left">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="about.jsp">About Us</a></li>
            <li><a href="flights.jsp">Flights</a></li>
        </ul>

        <!-- Center logo -->
        <div class="nav-logo">
            <img src="images/plane1.png" alt="Airline Logo">
        </div>

        <!-- Right links -->
        <div class="nav-right-container">
            <ul class="nav-right">
                <!--<li><a href="booking.jsp">Bookings</a></li>-->
                <li><a href="contact.jsp">Contact</a></li>
            </ul>
            <!-- No login/register button here, since this IS the login page -->
        </div>
    </div>
</nav>

<!-- ✅ Wrapper to center the login container -->
<div class="container-wrapper">
    <div class="container">
        <!-- Login form -->
        <div class="form-box login">
            <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
                <h1>Login</h1>

                <!-- ✅ Show error message if login failed -->
                <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                <% if (errorMessage != null) { %>
                    <p style="color:red; text-align:center;">
                        <%= errorMessage %>
                    </p>
                <% } %>

                <div class="input-box">
                    <input type="text" name="username" placeholder="Username or Email" required>
                    <i class='bx bxs-user'></i>
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Password" required>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <div class="forgot-link">
                    <a href="forgot.jsp">Forgot password?</a>
                </div>

                <button type="submit" class="btn">Login</button>
                <p>or login with social platforms</p>
                <div class="social-icons">
  <a href="<%= request.getContextPath() %>/GoogleLoginServlet" title="Login with Google">
    <i class='bx bxl-google'></i>
  </a>
</div>
            </form>
        </div>

        <!-- Registration -->
        <div class="form-box register">
            <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">
                <h1>Registration</h1>

                <!-- ✅ Show success/error message from RegisterServlet -->
                <% if (request.getParameter("registered") != null) { %>
                    <p style="color:green; text-align:center;">
                        Registration successful! Please login.
                    </p>
                <% } else if (request.getParameter("errorReg") != null) { %>
                    <p style="color:red; text-align:center;">
                        Registration failed. Try again.
                    </p>
                <% } %>

                <div class="input-box">
                    <input type="text" name="username" placeholder="Username" required>
                    <i class='bx bxs-user'></i>
                </div>
                <div class="input-box">
                    <input type="email" name="email" placeholder="Email" required>
                    <i class='bx bxs-envelope'></i>
                </div>
                <div class="input-box">
                    <input type="password" name="password" placeholder="Password" required>
                    <i class='bx bxs-lock-alt'></i>
                </div>
                <button type="submit" class="btn">Register</button>
<!--                <p>or register with social platforms</p>-->
<!--                <div class="social-icons">
                    <a href="#"><i class='bx bxl-google'></i></a>
                    <a href="#"><i class='bx bxl-facebook'></i></a>
                    <a href="#"><i class='bx bxl-github'></i></a>
                    <a href="#"><i class='bx bxl-linkedin'></i></a>
                </div>-->
            </form>
        </div>

        <!-- Toggle panels -->
        <div class="toggle-box">
            <div class="toggle-panel toggle-left">
                <h1>Welcome to SkyWings!</h1>
                <p>Don't have an account?</p>
                <button class="btn register-btn" type="button">Register</button>
            </div>
            <div class="toggle-panel toggle-right">
                <h1>Welcome to SkyWings!</h1>
                <p>Already have an account?</p>
                <button class="btn login-btn" type="button">Login</button>
            </div>
        </div>
    </div>
</div>

<!-- Script -->
<script>
    const container = document.querySelector('.container');
    const registerBtn = document.querySelector('.register-btn');
    const loginBtn = document.querySelector('.login-btn');

    registerBtn.addEventListener('click', () => {
        container.classList.add('active');
    });

    loginBtn.addEventListener('click', () => {
        container.classList.remove('active');
    });
</script>
</body>
</html>

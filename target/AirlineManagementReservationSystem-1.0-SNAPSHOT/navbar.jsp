<%@ page import="jakarta.servlet.http.HttpSession" %>
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

<%
    HttpSession sess = request.getSession(false);
    String username = (sess != null) ? (String) sess.getAttribute("username") : null;
    String role = (sess != null) ? (String) sess.getAttribute("role") : null;
%>

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
                <li><a href="contact.jsp">Contact</a></li>

                <% if (username != null) { %>
                    <!-- User logged in -->
                    <li><a href="myBookings.jsp">My Bookings</a></li>
                    <li>
                        <a href="<%= request.getContextPath() %>/LogoutServlet" title="Logout">
                            <i class='bx bx-log-in' style="font-size:24px;"></i>
                        </a>
                    </li>

                    <% if ("admin".equalsIgnoreCase(role)) { %>
                        <!-- Admin-only links -->
                        <li><a href="jsp/admin/addFlight.jsp">Add Flight</a></li>
                        <li><a href="jsp/admin/manageFlights.jsp">Manage Flights</a></li>
                    <% } %>
                <% } else { %>
                    <!-- If not logged in -->
                    <button class="auth-btn">
                        <a href="login.jsp">Login / Register</a>
                    </button>
                <% } %>
            </ul>
        </div>
    </div>
</nav>


<!-- Navbar Styles -->
<style>
    /* Hide login/register buttons inside navbar when on login/register pages */
/*.auth-btn,{
  display: none;
}*/


nav {
    background:#02487c;
    padding: 15px 40px;
    position: sticky;
    top: 0;
    z-index: 1000;
}

.navbar {
    display: grid;
    grid-template-columns: 1fr auto 1fr; /* left | center | right */
    align-items: center; /* align everything vertically */
}

/* Left and right menus */
.nav-left,
.nav-right {
    list-style: none;
    display: flex;
    gap: 55px;
    margin: 0;
    padding: 0;
    align-items: center;   /* <-- FIX: keeps links/icons aligned */
}

/* Logo */
.nav-logo img {
    height: 60px;
    display: block;
    margin: 0 auto;
}

/* Right section (menu + button in one row) */
.nav-right-container {
    display: flex;
    align-items: center;  /* <-- FIX: aligns button with links */
    gap: 20px;
    justify-content: flex-end;
}

.navbar button {
    padding: 10px 20px;
    border-radius: 50px;
    background: white;
    border: none;
    cursor: pointer;
    display: flex;         /* <-- FIX: button text centered */
    align-items: center;
    justify-content: center;
}

.navbar button a {
    color: black;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
}

/* Links */
.nav-left li a,
.nav-right li a {
    color: white;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    transition: color 0.3s ease;
    display: flex;        /* <-- FIX: centers icon/text properly */
    align-items: center;
}

.nav-left li a:hover,
.nav-right li a:hover {
    color: #00aaff;
}


</style>

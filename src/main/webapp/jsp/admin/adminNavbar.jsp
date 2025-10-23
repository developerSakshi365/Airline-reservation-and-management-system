<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

<nav class="admin-nav">
    <div class="admin-navbar">
        <!-- Left links -->
        <ul class="admin-left">
            <li><a href="<%= request.getContextPath() %>/jsp/admin/adminHome.jsp">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/ViewFlightsServlet">Manage Flights</a></li>
            <li><a href="<%= request.getContextPath() %>/jsp/admin/messages.jsp">Messages</a></li>
        </ul>

        <!-- Logo center -->
        <div class="admin-logo">
            <img src="<%= request.getContextPath() %>/images/plane1.png" alt="Airline Logo">
        </div>

        <!-- Right section -->
        <ul class="admin-right">
            <li><span class="welcome">Welcome, Sakshi vishwakarma</span></li>
            <li>
                <a href="<%= request.getContextPath() %>/LogoutServlet" title="Logout">
                    <i class='bx bx-log-in'></i> Logout
                </a>
            </li>
        </ul>
    </div>
</nav>

<style>
.admin-nav {
    background: #02487c;
    padding: 12px 40px;
    position: sticky;
    top: 0;
    z-index: 1000;
}
.admin-navbar {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    align-items: center;
}
.admin-logo img {
    height: 55px;
    display: block;
    margin: 0 auto;
}
.admin-left, .admin-right {
    list-style: none;
    display: flex;
    justify-content: space-around;
    margin: 0;
    padding: 0;
    align-items: center;
}
.admin-left li a, .admin-right li a {
    color: white;
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    transition: color 0.3s ease;
    display: flex;
    align-items: center;
    gap: 6px;
}
.admin-left li a:hover, .admin-right li a:hover {
    color: #00c6ff;
    background: transparent;
}
.welcome {
    color: #f0f0f0;
    font-size: 14px;
    font-weight: 500;
}
.bx {
    font-size: 20px;
}
</style>

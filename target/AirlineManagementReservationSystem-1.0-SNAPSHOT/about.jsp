<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int totalFlights = 0;
    int todayFlights = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/flight_booking", "root", "12345");

        // Total flights in DB
        PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM flights");
        ResultSet rs1 = ps1.executeQuery();
        if (rs1.next()) totalFlights = rs1.getInt(1);

        // Flights flying today
        PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM flights WHERE travel_date = CURDATE()");
        ResultSet rs2 = ps2.executeQuery();
        if (rs2.next()) todayFlights = rs2.getInt(1);

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us - Airline Reservation System</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/about.css">
        <link rel="stylesheet" href="footer.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
</head>

<body>
    <!-- ✅ Navbar include -->
    <jsp:include page="navbar.jsp" />

    <!-- ✅ Sleek Header -->
<!--    <header class="about-header">
        <i class="bx bxs-plane-alt"></i>
        <h1>About Us</h1>
        <p class="tagline">Your journey begins with us — safe, reliable, and affordable ✈️</p>
    </header>-->

    <div class="about-container">

        <!-- Our History -->
        <section class="about-card">
            <h2><i class="bx bxs-book"></i> Our History</h2>
            <p>
                Founded in <strong>2020</strong>, Airline Management Reservation System 
                began as a small project to simplify domestic bookings. 
                Over the years, we expanded into a full-fledged platform handling 
                both <em>domestic</em> and <em>international</em> flights.  
                Today, we serve thousands of passengers and empower admins with 
                robust tools for flight management.
            </p>
        </section>

        <!-- Our Mission -->
        <section class="about-card">
            <h2><i class="bx bxs-rocket"></i> Our Mission</h2>
            <p>
                To make air travel <strong>accessible, affordable, and reliable</strong> for everyone.  
                We aim to bring innovation to booking systems, ensuring transparency, 
                efficiency, and convenience for travelers and administrators alike.
            </p>
        </section>

        <!-- Our Vision -->
        <section class="about-card">
            <h2><i class="bx bxs-bulb"></i> Our Vision</h2>
            <p>
                To become the <strong>leading digital airline reservation platform</strong> in Asia, 
                connecting millions of people every year through smarter, faster, and 
                greener travel solutions.
            </p>
        </section>

        <!-- Our Journey Timeline -->
        <section class="about-card timeline">
            <h2><i class="bx bxs-timer"></i> Our Journey</h2>
            <ul>
                <li><span>2020:</span> Started as a university project</li>
                <li><span>2021:</span> Expanded to 100+ daily bookings</li>
                <li><span>2023:</span> Added international flights</li>
                <li><span>2024:</span> Crossed 20,000+ happy customers</li>
                <li><span>2025:</span> Moving towards AI-powered smart bookings</li>
            </ul>
        </section>

        <!-- By the Numbers -->
        <section class="about-card stats">
            <h2><i class="bx bxs-bar-chart-alt-2"></i> By the Numbers</h2>
            <ul>
                <li><strong>Total Flights:</strong> <%= totalFlights %></li>
                <!--<li><strong>Flights Today:</strong> <%= todayFlights %></li>-->
                <li><strong>Average Daily Flights:</strong> 50+</li>
                <li><strong>Registered Airlines:</strong> 10+</li>
                <li><strong>Happy Customers:</strong> 20,000+</li>
            </ul>
        </section>

        <!-- Why Choose Us -->
        <section class="about-card">
            <h2><i class="bx bxs-star"></i> Why Choose Us?</h2>
            <ul>
                <li>24/7 booking and support</li>
                <li>Multiple flight classes: Economy, Business, First</li>
                <li>Admin dashboard with real-time control</li>
                <li>Secure authentication for safe bookings</li>
                <!--<li>Future-ready architecture powered by Java & MySQL</li>-->
            </ul>
        </section>

        <!-- Contact Info -->
        <section class="about-card contact">
            <h2><i class="bx bxs-envelope"></i> Contact Us</h2>
            <p>Email: <a href="mailto:support@skywings.com">support@skywings.com</a></p>
            <p>Phone: +91 98765 43210</p>
            <p>Address: SkyWings HQ, Bengaluru, India</p>
        </section>
    </div>
                
                <!-- ✅ Ready to Fly Button -->
    <div class="ready-to-fly">
        <form action="<%= (session.getAttribute("username") == null) 
                            ? "login.jsp" 
                            : "flights.jsp" %>" method="get">
            <button type="submit">🚀 Ready to Fly</button>
        </form>
    </div>


        <%@ include file="footer.jsp" %>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Airline Reservation System</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
</head>
<style>
    /* Hide login/register buttons inside navbar when on login/register pages */
.auth-btn{
  display: none;
}

nav {
    background:#02487c;
    padding: 15px 40px;
    position: sticky;   /* sticks while scrolling */
    top: 0;             /* stick to top */
    /*width: 100%;*/
    z-index: 1000;      /* keep it above hero image & content */
    /*background: rgb(179, 205, 224);  or transparent if you want overlay effect */
}

.navbar {
    display: grid;
    grid-template-columns: 1fr auto 1fr; /* left | center | right */
    align-items: center;
}

/* Left and right menus */
.nav-left,
.nav-right {
    list-style: none;
    display: flex;
    gap: 55px;
    margin: 0;
    padding: 0;
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

/* Links */
.nav-left li a,
.nav-right li a {
    color: white;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    transition: color 0.3s ease;
}

.nav-left li a:hover,
.nav-right li a:hover {
    color: #00aaff;
}
</style>
<body>
    <!-- Navbar -->
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
                <li><a href="booking.jsp">Bookings</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="<%= request.getContextPath() %>/LogoutServlet">🚪 Logout</a></li>
            </ul>

        </div>
    </div>
</nav>

    <!-- Hero Section -->
    <div class="hero">
        <h1>Welcome to SkyWings Airline️</h1>
        <p>Your journey begins here. Book your flights with ease.</p>
    </div>

    <!-- Flight Search Box -->
    <div class="search-box main-content">
        <h2>Search Flights</h2>
        <form action="flights.jsp" method="get">
            <input type="text" name="from" placeholder="From" required>
            <input type="text" name="to" placeholder="To" required>
            <input type="date" name="date" required>
            <select name="class">
                <option value="economy">Economy</option>
                <option value="business">Business</option>
            </select>
            <button type="submit">Search</button>
        </form>
    </div>

    <!-- Features -->
    <div class="features">
        <div class="feature">
            <h3>✈ Easy Booking</h3>
            <p>Book flights in just a few clicks.</p>
        </div>
        <div class="feature">
            <h3>💳 Secure Payments</h3>
            <p>All transactions are encrypted and safe.</p>
        </div>
        <div class="feature">
            <h3>📞 24/7 Support</h3>
            <p>We are always here to help you.</p>
        </div>
    </div>

   <!-- Popular Destinations Section -->
<section class="popular-destinations">
    <h2>Popular Destinations</h2>
    <div class="carousel-wrapper">
        <!-- Left Arrow -->
        <button class="carousel-btn left" onclick="scrollDestinations(-300)">&#10094;</button>

        <!-- Destination List -->
        <div class="destinations-container" id="destinations">
            <div class="destination">
                <img src="images/Delhi.jpg" alt="Delhi">
                <span>Delhi</span>
            </div>
            <div class="destination">
                <img src="images/Mumbai.jpg" alt="Mumbai">
                <span>Mumbai</span>
            </div>
            <div class="destination">
                <img src="images/Goa.jpg" alt="Goa">
                <span>Goa</span>
            </div>
            <div class="destination">
                <img src="images/Kolkatta.jpg" alt="Kolkatta">
                <span>Kolkatta</span>
            </div>
            <div class="destination">
                <img src="images/Bengaluru.jpg" alt="Bengaluru">
                <span>Bengaluru</span>
            </div>
            <div class="destination">
                <img src="images/Chennai.jpg" alt="Chennai">
                <span>Chennai</span>
            </div>
            <div class="destination">
                <img src="images/Ahmedabad.jpg" alt="Ahmedabad">
                <span>Ahmedabad</span>
            </div>
            <div class="destination">
                <img src="images/Lucknow.jpg" alt="Lucknow">
                <span>Lucknow</span>
            </div>
            <div class="destination">
                <img src="images/Varanasi.jpg" alt="Varanasi">
                <span>Varanasi</span>
            </div>
            <div class="destination">
                <img src="images/Jaipur.jpg" alt="Jaipur">
                <span>Jaipur</span>
            </div>
            <div class="destination">
                <img src="images/Amritsar.jpg" alt="Amritsar">
                <span>Amritsar</span>
            </div>
            <div class="destination">
                <img src="images/Vadodara.jpg" alt="Vadodara">
                <span>Vadodara</span>
            </div>
        </div>

        <!-- Right Arrow -->
        <button class="carousel-btn right" onclick="scrollDestinations(300)">&#10095;</button>
    </div>
</section>

<script>
    function scrollDestinations(amount) {
        document.getElementById("destinations").scrollBy({
            left: amount,
            behavior: "smooth"
        });
    }
</script>

    <!-- Why Choose Us -->
    <div class="why-us">
        <h2>Why Choose Us?</h2>
        <p>We provide the best prices, fastest booking, and trusted airlines worldwide.</p>
    </div>

    <!-- Customer Reviews -->
    <div class="reviews">
        <h2>What Our Customers Say</h2>
        <div class="review">
            "Amazing experience! Booking was so easy and support was excellent." – Riya Sharma
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>© 2025 Airline Reservation System | All Rights Reserved</p>
    </footer>
</body>
</html>

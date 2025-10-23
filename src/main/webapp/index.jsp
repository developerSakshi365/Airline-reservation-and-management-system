<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Airline Reservation System</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navbar -->
    <%@ include file="navbar.jsp" %>

    <!-- Hero Section -->
    <div class="hero">
    <div class="overlay-box">
        <h1>Welcome to SkyWings Airline️</h1>
        <p>Your journey begins here. Book your flights with ease.</p>
    </div>
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
  <%@ include file="footer.jsp" %>


</body>
</html>

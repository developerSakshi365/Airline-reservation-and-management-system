<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us - SkyWings</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .contact-container {
            max-width: 1000px;
            margin: 50px auto;
            display: flex;
            gap: 40px;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .contact-info { flex: 1; color: #333; }
        .contact-info h2 { color: #02487c; margin-bottom: 15px; }
        .contact-info p { margin: 8px 0; }
        .contact-form { flex: 1; }
        .contact-form h2 { color: #02487c; margin-bottom: 15px; }
        .contact-form input,
        .contact-form textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .contact-form button {
            background: #02487c;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .contact-form button:hover { background: #0361a1; }

        /* ✅ Overlay style */
        .overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            display: flex;
            justify-content: center;
            align-items: center;
            visibility: hidden;
        }
        .overlay.active { visibility: visible; }
        .overlay-box {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            text-align: center;
            width: 350px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        .overlay-box h3 { color: #02487c; margin-bottom: 15px; }
        .overlay-box button {
            margin-top: 10px;
            padding: 10px 18px;
            background: #02487c;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        .overlay-box button:hover { background: #0361a1; }
    </style>
</head>
<body>

    <!-- Navbar -->
    <%@ include file="navbar.jsp" %>

    <!-- Contact Section -->
    <div class="contact-container">
        <div class="contact-info">
            <h2>Contact Information</h2>
            <p><strong>Email:</strong> support@skywings.com</p>
            <p><strong>Phone:</strong> +91-9876543210</p>
            <p><strong>Address:</strong> SkyWings HQ, Mumbai, India</p>
            <p>We’re available 24/7 to assist you with bookings, cancellations, and inquiries.</p>
        </div>

        <div class="contact-form">
            <h2>Send Us a Message</h2>
            <form action="SendMessageServlet" method="post">
                <input type="text" name="name" placeholder="Your Name" required>
                <input type="email" name="email" placeholder="Your Email" required>
                <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
                <button type="submit">Send Message</button>
            </form>
        </div>
    </div>

    <!-- ✅ Success Overlay -->
    <div class="overlay <%= request.getParameter("status") != null ? "active" : "" %>">
        <div class="overlay-box">
            <h3>
                <%= "success".equals(request.getParameter("status")) 
                    ? "✅ Your message has been sent!" 
                    : "❌ Something went wrong!" %>
            </h3>
            <button onclick="window.location.href='contact.jsp'">OK</button>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQs - SkyWings</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .faq-container {
            max-width: 900px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .faq-container h2 {
            text-align: center;
            color: #02487c;
            margin-bottom: 20px;
        }
        .faq-item {
            margin-bottom: 15px;
            border-bottom: 1px solid #ddd;
        }
        .faq-question {
            background: #f0f8ff;
            padding: 15px;
            cursor: pointer;
            font-weight: bold;
            color: #02487c;
            transition: background 0.3s;
        }
        .faq-question:hover {
            background: #e0f0fa;
        }
        .faq-answer {
            display: none;
            padding: 15px;
            color: #333;
            font-size: 15px;
            line-height: 1.6;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <%@ include file="navbar.jsp" %>

    <!-- FAQ Section -->
    <div class="faq-container">
        <h2>Frequently Asked Questions</h2>

        <div class="faq-item">
            <div class="faq-question">How can I book a flight?</div>
            <div class="faq-answer">You can book flights directly from our "Flights" page by searching and selecting your preferred journey.</div>
        </div>

        <div class="faq-item">
            <div class="faq-question">Can I cancel or reschedule my booking?</div>
            <div class="faq-answer">Yes, you can cancel or reschedule your booking from your account dashboard or by contacting our support team.</div>
        </div>

        <div class="faq-item">
            <div class="faq-question">Do you offer refunds?</div>
            <div class="faq-answer">Refunds depend on the fare type and airline policy. Please check our Refund Policy in the footer for details.</div>
        </div>

        <div class="faq-item">
            <div class="faq-question">How can I contact customer support?</div>
            <div class="faq-answer">You can reach us via the Contact Us page or email us directly at support@skywings.com.</div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <script>
        const questions = document.querySelectorAll('.faq-question');
        questions.forEach(q => {
            q.addEventListener('click', () => {
                const answer = q.nextElementSibling;
                answer.style.display = (answer.style.display === 'block') ? 'none' : 'block';
            });
        });
    </script>
</body>
</html>

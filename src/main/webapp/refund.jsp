<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Refund Policy - SkyWings Airlines</title>
    <link rel="stylesheet" href="footer.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background: #f4f8fb;
            color: #333;
            line-height: 1.7;
        }

        .content {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        }

        h2 {
            text-align: center;
            font-size: 26px;
            margin-bottom: 25px;
            color: #02487c;
        }

        p {
            margin-bottom: 16px;
            font-size: 15px;
        }

        ul {
            margin: 15px 0 20px 20px;
        }

        li {
            margin-bottom: 10px;
            font-size: 15px;
        }

        .note {
            margin-top: 25px;
            padding: 15px;
            background: #f0f7ff;
            border-left: 5px solid #02487c;
            border-radius: 6px;
            font-size: 14px;
            color: #02487c;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="content">
        <h2>Refund Policy</h2>
        <p>At <strong>SkyWings Airlines</strong>, we value transparency and strive to provide our passengers with a fair and reliable refund process. Currently, as this is a demo project, the following simplified refund policy is applied:</p>
        
        <ul>
            <li> Cancellations made <strong>24 hours before departure</strong> are fully refundable.</li>
            <li> Cancellations made within <strong>24 hours of departure</strong> are non-refundable.</li>
            <li>️ In case of a flight cancellation by the airline, passengers are eligible for a <strong>full refund</strong> or free rebooking.</li>
        </ul>
        
        <p>Please note that refund processing may take a few business days depending on your payment provider.</p>

        <div class="note">
            ️ This refund policy is for demonstration purposes only and may not represent actual airline policies.
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>

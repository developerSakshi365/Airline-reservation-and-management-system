<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Terms & Conditions - SkyWings Airlines</title>
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
            color: #7a5c00;
        }
        .disclaimer-label {
    color: #c0392b;   /* red shade */
    font-weight: bold;
}

    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="content">
        <h2>Terms & Conditions</h2>
        <p>Welcome to <strong>SkyWings Airlines</strong>. By accessing or using this demo project, you agree to the following terms and conditions:</p>

        <ul>
            <li>️ This project is strictly for <strong>educational and demonstration purposes</strong>.</li>
            <li>️ All flight schedules, fares, and bookings shown here are <strong>simulated</strong> and do not represent real services.</li>
            <li>️ No actual payments, refunds, or commercial transactions are processed.</li>
            <li>️ SkyWings Airlines in this context is a <strong>fictional entity</strong> created for learning purposes.</li>
            <li>️ Users should not use this demo project for any real-world travel planning or ticket booking.</li>
        </ul>

        <p>By using this project, you acknowledge that the data displayed is fictitious and should not be relied upon for actual travel.</p>

        <div class="note">
    <span class="disclaimer-label">Disclaimer:</span> These terms are part of a 
    <strong>student/demo project</strong> and do not create any legal obligations.
</div>

    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>

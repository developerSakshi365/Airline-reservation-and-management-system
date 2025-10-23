<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Password Reset Sent</title>
    <style>
        /* General body styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f2f6fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Container box */
        .confirmation-container {
            background: #ffffff;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #02487c;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600;
        }

        p {
            color: #333;
            font-size: 16px;
            margin-bottom: 20px;
        }

        a {
            display: inline-block;
            padding: 10px 25px;
            background-color: #02487c;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        a:hover {
            background-color: #0366b3;
            box-shadow: 0 4px 12px rgba(2,72,124,0.3);
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <h2>Password Reset Link Sent ✅</h2>
        <p>If that email exists in our system, a password reset link has been sent.</p>
        <a href="<%= request.getContextPath() %>/login.jsp">Back to Login</a>
    </div>
</body>
</html>

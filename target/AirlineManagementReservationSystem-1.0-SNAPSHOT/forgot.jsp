<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Forgot Password</title>
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
        .forgot-container {
            background: #ffffff;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #02487c;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            font-weight: 500;
            color: #02487c;
        }

        input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            margin-bottom: 20px;
            transition: border 0.3s;
        }

        input[type="email"]:focus {
            border-color: #02487c;
            outline: none;
            box-shadow: 0 0 6px rgba(2,72,124,0.3);
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #02487c;
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.3s;
        }

        button:hover {
            background-color: #0366b3;
            box-shadow: 0 4px 12px rgba(2,72,124,0.3);
        }

        p {
            margin-top: 20px;
            font-size: 14px;
        }

        p a {
            color: #02487c;
            text-decoration: none;
            font-weight: 500;
        }

        p a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <h2>Forgot Password</h2>
        <form action="<%= request.getContextPath() %>/ForgotPasswordServlet" method="post">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" placeholder="Enter your email" required>
            <button type="submit">Send Reset Link</button>
        </form>
        <p><a href="<%= request.getContextPath() %>/login.jsp">Back to Login</a></p>
    </div>
</body>
</html>

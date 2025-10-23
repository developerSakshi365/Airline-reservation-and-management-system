<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head><meta charset="utf-8"><title>Reset link invalid</title></head>
<body>
  <h2>This reset link is invalid or has expired.</h2>
  <p><a href="<%= request.getContextPath() %>/forgot.jsp">Request new reset link</a></p>
</body>
</html>

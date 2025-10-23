<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String token = (String) request.getAttribute("token");
  String error = (String) request.getAttribute("error");
%>
<!doctype html>
<html>
<head><meta charset="utf-8"><title>Reset password</title></head>
<body>
  <h2>Reset password</h2>
  <% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
  <% } %>
  <form action="<%= request.getContextPath() %>/ResetPasswordServlet" method="post">
    <input type="hidden" name="token" value="<%= token %>">
    <label>New password</label><br>
    <input type="password" name="password" required minlength="6"><br><br>
    <label>Confirm password</label><br>
    <input type="password" name="confirm_password" required minlength="6"><br><br>
    <button type="submit">Change password</button>
  </form>
</body>
</html>

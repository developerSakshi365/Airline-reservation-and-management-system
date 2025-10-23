<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
    // require login
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        // redirect to login and come back
        String target = request.getRequestURI() + (request.getQueryString()!=null ? "?" + request.getQueryString() : "");
        response.sendRedirect("login.jsp?redirect=" + URLEncoder.encode(target, "UTF-8"));
        return;
    }

    int flightId = Integer.parseInt(request.getParameter("id"));
    String suggestedDate = request.getParameter("date"); // optional
    String flightNumber="", airline="", source="", destination="", dep="", arr="";
    double price = 0.0;
    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_booking","root","12345");
         PreparedStatement ps = con.prepareStatement("SELECT * FROM flights WHERE id=?")) {
        ps.setInt(1, flightId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                flightNumber = rs.getString("flight_number");
                airline = rs.getString("airline");
                source = rs.getString("source");
                destination = rs.getString("destination");
                dep = rs.getString("departure_time");
                arr = rs.getString("arrival_time");
                price = rs.getDouble("price");
            } else {
                out.println("Flight not found");
                return;
            }
        }
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Flight</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bookFlight.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="booking-container">
        <h2>Book Flight: <%= flightNumber %> (<%= airline %>)</h2>
        <p class="route"><%= source %> → <%= destination %> | Departure: <%= dep %></p>

        <form action="<%= request.getContextPath() %>/BookFlightServlet" method="post">
            <input type="hidden" name="flightId" value="<%= flightId %>">

            <label>Travel Date</label>
            <input type="date" name="travelDate" value="<%= (suggestedDate!=null)? suggestedDate : "" %>" required>

            <label>Class</label>
            <select name="classType" required>
                <option>Economy</option>
                <!--<option>Premium Economy</option>-->
                <option>Business</option>
                <!--<option>First Class</option>-->
            </select>

            <label>Passengers</label>
            <input type="number" name="passengers" value="1" min="1" required>

            <button type="submit">Confirm Booking (₹<%= price %>)</button>
        </form>
    </div>
</body>
</html>

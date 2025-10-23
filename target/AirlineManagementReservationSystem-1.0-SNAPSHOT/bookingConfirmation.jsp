<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String idStr = request.getParameter("bookingId");
    if (idStr == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    int bookingId = Integer.parseInt(idStr);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_booking", "root", "12345");
             PreparedStatement ps = con.prepareStatement(
                "SELECT b.id, b.booking_time, b.passengers, f.flight_number, f.airline, f.source, f.destination, f.departure_time " +
                "FROM bookings b JOIN flights f ON b.flight_id = f.id WHERE b.id = ?")) {

            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bookingConfirmation.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="confirmation-wrapper">
        <div class="confirmation-container">
            <h1>Booking Confirmed ✅</h1>
            <div class="booking-details">
                <p><strong>Booking ID:</strong> <%= rs.getInt("id") %></p>
                <p><strong>Flight:</strong> <%= rs.getString("flight_number") %> (<%= rs.getString("airline") %>)</p>
                <p><strong>Route:</strong> <%= rs.getString("source") %> → <%= rs.getString("destination") %></p>
                <p><strong>Departure:</strong> <%= rs.getString("departure_time") %></p>
                <p><strong>Passengers:</strong> <%= rs.getInt("passengers") %></p>
                <p><strong>Booked At:</strong> <%= rs.getString("booking_time") %></p>
            </div>
            <a href="<%= request.getContextPath() %>/flights.jsp" class="btn">Back to Flights</a>
        </div>
    </div>
</body>
</html>
<%
                } else {
                    out.println("Booking not found.");
                }
            }
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

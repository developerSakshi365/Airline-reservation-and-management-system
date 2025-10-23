<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/myBooking.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <h1>My Bookings</h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Flight</th>
                <th>Route</th>
                <th>Travel Date</th>
                <th>Class</th>
                <th>Passengers</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try (Connection con = DriverManager.getConnection(
                     "jdbc:mysql://localhost:3306/flight_booking","root","12345");
                 PreparedStatement ps = con.prepareStatement(
                     "SELECT b.id, f.flight_number, f.airline, f.source, f.destination, " +
                     "b.travel_date, b.class, b.passengers, b.status " +
                     "FROM bookings b JOIN flights f ON b.flight_id = f.id " +
                     "WHERE b.user_id = ? ORDER BY b.booking_time DESC")) {

                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    boolean any = false;
                    while (rs.next()) {
                        any = true;
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("flight_number") %> (<%= rs.getString("airline") %>)</td>
                <td><%= rs.getString("source") %> → <%= rs.getString("destination") %></td>
                <td><%= rs.getDate("travel_date") %></td>
                <td><%= rs.getString("class") %></td>
                <td><%= rs.getInt("passengers") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <% if (!"CANCELLED".equalsIgnoreCase(rs.getString("status"))) { %>
                        <form action="<%= request.getContextPath() %>/CancelBookingServlet" 
                              method="post" style="display:inline">
                            <input type="hidden" name="bookingId" value="<%= rs.getInt("id") %>">
                            <button type="submit" 
                                    onclick="return confirm('Cancel this booking?')">Cancel</button>
                        </form>
                    <% } else { %> - <% } %>
                </td>
            </tr>
        <%
                    }
                    if (!any) {
        %>
            <tr><td colspan="8" class="no-data">No bookings found.</td></tr>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</body>
</html>

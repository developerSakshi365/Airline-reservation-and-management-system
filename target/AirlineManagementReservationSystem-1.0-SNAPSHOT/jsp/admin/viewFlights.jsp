<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.flightbooking.model.Flight" %>
<%@ page session="true" %>
<%
//    String username = (String) session.getAttribute("username");
//    String role = (String) session.getAttribute("role");
//
//    if (username == null || !"admin".equalsIgnoreCase(role)) {
//        response.sendRedirect("login.jsp"); // only admin allowed
//        return;
//    }

    List<Flight> flights = (List<Flight>) request.getAttribute("flights");
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Flights</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/viewFlights.css">
</head>
<body>
        <%@ include file="/jsp/admin/adminNavbar.jsp" %>

    <div class="container">
        <h1>✈ All Flights</h1>
        <a class="back-link" href="<%= request.getContextPath() %>/jsp/admin/adminHome.jsp">⬅ Back to Dashboard</a>

        <table>
            <thead>
    <tr>
        <th>ID</th>
        <th>Flight Number</th>
        <th>Airline</th>
        <th>Source</th>
        <th>Destination</th>
        <th>Travel Date</th>
        <th>Class</th>
        <th>Departure</th>
        <th>Arrival</th>
        <th>Duration</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
</thead>
<tbody>
<%
    if (flights != null) {
        for (Flight f : flights) {
%>
    <tr>
        <td><%= f.getId() %></td>
        <td><%= f.getFlightNumber() %></td>
        <td><%= f.getAirline() %></td>
        <td><%= f.getSource() %></td>
        <td><%= f.getDestination() %></td>
        <td><%= f.getTravelDate() %></td>
        <td><%= f.getFlightClass() %></td>
        <td><%= f.getDepartureTime() %></td>
        <td><%= f.getArrivalTime() %></td>
        <td><%= f.getDuration() %></td>
        <td>₹<%= f.getPrice() %></td>
        <td>
    <div class="actions">
        <a href="./jsp/admin/editFlight.jsp?id=<%= f.getId() %>" class="btn edit">Edit</a>
        <a href="<%= request.getContextPath() %>/DeleteFlightServlet?id=<%= f.getId() %>" 
           onclick="return confirm('Are you sure you want to delete this flight?');" 
           class="btn delete">
           Delete
        </a>
    </div>
</td>

    </tr>
<%
        }
    }
%>
</tbody>

        </table>
    </div>
        <%@ include file="/jsp/admin/adminFooter.jsp" %>

</body>
</html>

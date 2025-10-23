<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Flight</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/addFlight.css">
</head>
<body>
        <%@ include file="/jsp/admin/adminNavbar.jsp" %>

    <div class="add-flight-container">
        <h1>Add New Flight</h1>

        <form action="<%= request.getContextPath() %>/AddFlightServlet" method="post" class="add-flight-form">
            <label>Flight Number:</label>
            <input type="text" name="flight_number" required>

            <label>Airline:</label>
            <input type="text" name="airline" required>

            <label>Source:</label>
            <input type="text" name="source" required>

            <label>Destination:</label>
            <input type="text" name="destination" required>
            
            <label>Travel Date:</label>
            <input type="date" name="travel_date" required>

           <label>Departure Time:</label>
           <input type="time" name="departure_time" required>

           <label>Arrival Time:</label>
           <input type="time" name="arrival_time" required>

            <label>Duration:</label>
            <input type="text" name="duration">

            <label>Price:</label>
            <input type="number" step="0.01" name="price" required>

            <button type="submit">Add Flight</button>
        </form>

        <a class="back-link" href="<%= request.getContextPath() %>/jsp/admin/adminHome.jsp">⬅ Back to Dashboard</a>
    </div>
            <%@ include file="/jsp/admin/adminFooter.jsp" %>

</body>
</html>

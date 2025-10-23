<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String flightNumber = "", airline = "", source = "", destination = "",
           departure = "", arrival = "", duration = "", travelDate = "", flightClass = "";
    double price = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_booking", "root", "12345");
        ps = con.prepareStatement("SELECT * FROM flights WHERE id=?");
        ps.setInt(1, id);
        rs = ps.executeQuery();
        if(rs.next()){
            flightNumber = rs.getString("flight_number");
            airline = rs.getString("airline");
            source = rs.getString("source");
            destination = rs.getString("destination");
            departure = rs.getString("departure_time").replace(" ", "T");
            arrival   = rs.getString("arrival_time").replace(" ", "T");
            duration = rs.getString("duration");
            price = rs.getDouble("price");
            travelDate = rs.getString("travel_date");  // yyyy-MM-dd
            flightClass = rs.getString("class");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Flight</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/editFlight.css">
</head>
<body>
        <%@ include file="/jsp/admin/adminNavbar.jsp" %>

    <div class="edit-flight-container">
        <h1>Edit Flight</h1>
        <form action="<%= request.getContextPath() %>/EditFlightServlet" method="post" class="edit-flight-form">
            <input type="hidden" name="id" value="<%=id%>"/>

            <label>Flight Number:</label>
            <input type="text" name="flight_number" value="<%=flightNumber%>" required/>

            <label>Airline:</label>
            <input type="text" name="airline" value="<%=airline%>" required/>

            <label>Source:</label>
            <input type="text" name="source" value="<%=source%>" required/>

            <label>Destination:</label>
            <input type="text" name="destination" value="<%=destination%>" required/>

            <label>Travel Date:</label>
            <input type="date" name="travel_date" value="<%=travelDate%>" required/>

            <label>Class:</label>
            <select name="flight_class" required>
                <option value="economy" <%= "economy".equalsIgnoreCase(flightClass) ? "selected" : "" %>>Economy</option>
                <option value="business" <%= "business".equalsIgnoreCase(flightClass) ? "selected" : "" %>>Business</option>
            </select>

            <label>Departure:</label>
            <input type="time" name="departure_time" value="<%=departure%>" required/>

            <label>Arrival:</label>
            <input type="time" name="arrival_time" value="<%=arrival%>" required/>

            <label>Duration:</label>
            <input type="text" name="duration" value="<%=duration%>"/>

            <label>Price:</label>
            <input type="number" step="0.01" name="price" value="<%=price%>" required/>

            <button type="submit">Update Flight</button>
        </form>
        <a class="back-link" href="<%= request.getContextPath() %>/ViewFlightsServlet">⬅ Back to Flights</a>
    </div>
            <%@ include file="/jsp/admin/adminFooter.jsp" %>

</body>
</html>

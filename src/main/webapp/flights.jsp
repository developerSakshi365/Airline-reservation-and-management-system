<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>

<%
    // search params (from index.jsp form)
    String from = request.getParameter("from");
    String to = request.getParameter("to");
    String date = request.getParameter("date");   // yyyy-MM-dd
    String flightClass = request.getParameter("class"); // economy/business

    // check login from session
    boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Available Flights</title>
        <link rel="stylesheet" href="footer.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
            /*padding: 20px;*/
        }

        table {
            width: 90%;
            margin: 10px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            border-radius: 6px;
            overflow: hidden;
        }

        table thead {
            background: #02487c;
            color: white;
        }

        table th, table td {
            padding: 18px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            font-weight: 600;
        }

        table tr:hover {
            /*background-color: #f1f1f1;*/
        }

        a {
            text-decoration: none;
            padding: 8px 14px;
            border-radius: 4px;
            font-weight: bold;
        }

        a[href*="bookFlight"] {
            background: #fff;
            color: #02487c;
        }

        a[href*="login.jsp"] {
            background: #ffffff;
            color: black;
        }

        a:hover {
            opacity: 0.8;
        }

        .no-flights {
            text-align: center;
            font-size: 16px;
            padding: 20px;
            color: #555;
        }

        /* Navbar spacing fix */
        body > h1 {
            margin-top: 60px;
        }
        /* Footer */

    </style>
</head>

<%@ include file="navbar.jsp" %>

<body>
    <h1>Available Flights</h1>

    <table>
        <thead>
            <tr>
                <th>Flight No</th>
                <th>Airline</th>
                <th>Source</th>
                <th>Destination</th>
                <th>Travel Date</th>
                <th>Class</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Price (₹)</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/flight_booking", "root", "12345")) {

                    StringBuilder query = new StringBuilder("SELECT * FROM flights WHERE 1=1");
                    if (from != null && !from.isEmpty()) query.append(" AND source = ?");
                    if (to != null && !to.isEmpty()) query.append(" AND destination = ?");
                    if (date != null && !date.isEmpty()) query.append(" AND travel_date = ?");
                    if (flightClass != null && !flightClass.isEmpty()) query.append(" AND class = ?");
                    query.append(" ORDER BY departure_time");

                    PreparedStatement ps = con.prepareStatement(query.toString());

                    int idx = 1;
                    if (from != null && !from.isEmpty()) ps.setString(idx++, from.trim());
                    if (to != null && !to.isEmpty()) ps.setString(idx++, to.trim());
                    if (date != null && !date.isEmpty()) ps.setDate(idx++, java.sql.Date.valueOf(date));
                    if (flightClass != null && !flightClass.isEmpty()) ps.setString(idx++, flightClass.trim());

                    try (ResultSet rs = ps.executeQuery()) {
                        boolean any = false;
                        while (rs.next()) {
                            any = true;
        %>
            <tr>
                <td><%= rs.getString("flight_number") %></td>
                <td><%= rs.getString("airline") %></td>
                <td><%= rs.getString("source") %></td>
                <td><%= rs.getString("destination") %></td>
                <td><%= rs.getDate("travel_date") %></td>
                <td><%= rs.getString("class") %></td>
                <td><%= rs.getTimestamp("departure_time") %></td>
                <td><%= rs.getTimestamp("arrival_time") %></td>
                <td>₹ <%= rs.getDouble("price") %></td>
                <td>
                    <%
                        String ctx = request.getContextPath();
                        int fid = rs.getInt("id");
                        if (isLoggedIn) {
                    %>
                        <a href="<%= ctx %>/bookFlight.jsp?id=<%= fid %>&date=<%= rs.getDate("travel_date") %>&class=<%= rs.getString("class") %>">Book Now</a>
                    <%
                        } else {
                            String target = ctx + "/bookFlight.jsp?id=" + fid + "&date=" + rs.getDate("travel_date") + "&class=" + rs.getString("class");
                            String encoded = URLEncoder.encode(target, "UTF-8");
                    %>
                        <a href="<%= ctx %>/login.jsp?redirect=<%= encoded %>">Login to Book</a>
                    <%
                        }
                    %>
                </td>
            </tr>
        <%
                        }
                        if (!any) {
        %>
            <tr><td colspan="10" class="no-flights">No flights found for your search.</td></tr>
        <%
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
            <%@ include file="footer.jsp" %>

</body>
</html>

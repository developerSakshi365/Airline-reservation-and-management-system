<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession,java.sql.*" %>
<%@ include file="/jsp/admin/sessionInfo.jsp" %>
<%@ include file="/jsp/admin/adminNavbar.jsp" %>

    
<%


    int totalFlights = 0;
    int totalSources = 0;
    int totalDestinations = 0;

    // For recent flights preview
    java.util.List<String[]> recentFlights = new java.util.ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_booking", "root", "12345");

        Statement stmt = con.createStatement();

        // Count total flights
        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM flights");
        if (rs1.next()) totalFlights = rs1.getInt(1);

        // Count distinct sources
        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(DISTINCT source) FROM flights");
        if (rs2.next()) totalSources = rs2.getInt(1);

        // Count distinct destinations
        ResultSet rs3 = stmt.executeQuery("SELECT COUNT(DISTINCT destination) FROM flights");
        if (rs3.next()) totalDestinations = rs3.getInt(1);

        // Fetch latest 5 flights
        ResultSet rs4 = stmt.executeQuery("SELECT flight_number, airline, source, destination, travel_date FROM flights ORDER BY id DESC LIMIT 5");
        while (rs4.next()) {
            recentFlights.add(new String[]{
                rs4.getString("flight_number"),
                rs4.getString("airline"),
                rs4.getString("source"),
                rs4.getString("destination"),
                rs4.getString("travel_date")
            });
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin/admin.css">
</head>
<body>
   

    <div class="dashboard-container">
        <h1>Welcome, <%= username %> 👋</h1>

        <!-- Stats Section -->
        <div class="stats">
            <div class="card">
                <h2><%= totalFlights %></h2>
                <p>Total Flights</p>
            </div>
            <div class="card">
                <h2><%= totalSources %></h2>
                <p>Unique Sources</p>
            </div>
            <div class="card">
                <h2><%= totalDestinations %></h2>
                <p>Unique Destinations</p>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="<%= request.getContextPath() %>/jsp/admin/addFlight.jsp" class="action-card">Add Flight</a>
            <a href="<%= request.getContextPath() %>/ViewFlightsServlet" class="action-card">Manage Flights</a>
            <a href="<%= request.getContextPath() %>/jsp/admin/messages.jsp" class="action-card">View Messages</a>
        </div>

        <!-- Recent Flights -->
        <div class="recent-flights">
            <h2>Recently Added Flights</h2>
            <table>
                <thead>
                    <tr>
                        <th>Flight No</th>
                        <th>Airline</th>
                        <th>Route</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (!recentFlights.isEmpty()) {
                            for (String[] f : recentFlights) {
                    %>
                        <tr>
                            <td><%= f[0] %></td>
                            <td><%= f[1] %></td>
                            <td><%= f[2] %> → <%= f[3] %></td>
                            <td><%= f[4] %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="4" style="text-align:center;">No recent flights found.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <a href="<%= request.getContextPath() %>/ViewFlightsServlet" class="view-all">View All Flights ➝</a>
        </div>
    </div>
        <%@ include file="/jsp/admin/adminFooter.jsp" %>


</body>
</html>

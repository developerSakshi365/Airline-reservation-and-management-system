package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditFlightServlet")
public class EditFlightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String flightNumber = request.getParameter("flight_number");
        String airline = request.getParameter("airline");
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String departure = request.getParameter("departure_time");
        String arrival = request.getParameter("arrival_time");
        String duration = request.getParameter("duration");
        double price = Double.parseDouble(request.getParameter("price"));
        Date travelDate = Date.valueOf(request.getParameter("travel_date")); // yyyy-MM-dd
        String flightClass = request.getParameter("flight_class");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/flight_booking","root","12345");

            String query = "UPDATE flights SET flight_number=?, airline=?, source=?, destination=?, " +
                           "departure_time=?, arrival_time=?, duration=?, price=?, travel_date=?, class=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, flightNumber);
            ps.setString(2, airline);
            ps.setString(3, source);
            ps.setString(4, destination);
            ps.setString(5, departure);
            ps.setString(6, arrival);
            ps.setString(7, duration);
            ps.setDouble(8, price);
            ps.setDate(9, travelDate);
            ps.setString(10, flightClass);
            ps.setInt(11, id);

            ps.executeUpdate();
            con.close();

            response.sendRedirect("ViewFlightsServlet");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

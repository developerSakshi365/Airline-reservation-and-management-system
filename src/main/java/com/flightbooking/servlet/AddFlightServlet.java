package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddFlightServlet")
public class AddFlightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String flightNumber = request.getParameter("flight_number");
        String airline = request.getParameter("airline");
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String travelDate = request.getParameter("travel_date");
        String departureTime = request.getParameter("departure_time");
        String arrivalTime = request.getParameter("arrival_time");
        String duration = request.getParameter("duration");
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/flight_booking", "root", "12345");

            String sql = "INSERT INTO flights(flight_number, airline, source, destination, travel_date, departure_time, arrival_time, duration, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
PreparedStatement pst = con.prepareStatement(sql);

pst.setString(1, flightNumber);
pst.setString(2, airline);
pst.setString(3, source);
pst.setString(4, destination);
pst.setString(5, travelDate);      
pst.setString(6, departureTime);  
pst.setString(7, arrivalTime);    
pst.setString(8, duration);
pst.setDouble(9, price);          


            int rows = pst.executeUpdate();
            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/ViewFlightsServlet");
            } else {
                response.getWriter().println("Failed to add flight!");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

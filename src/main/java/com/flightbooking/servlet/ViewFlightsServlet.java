package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.flightbooking.model.Flight;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ViewFlightsServlet")
public class ViewFlightsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Flight> flights = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/flight_booking", "root", "12345");

            String sql = "SELECT * FROM flights";
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Flight f = new Flight(
                        rs.getInt("id"),
                        rs.getString("flight_number"),
                        rs.getString("airline"),
                        rs.getString("source"),
                        rs.getString("destination"),
                        rs.getString("departure_time"),
                        rs.getString("arrival_time"),
                        rs.getString("duration"),
                        rs.getDouble("price"),
                        rs.getDate("travel_date"),
                        rs.getString("class") // if your column is named `class`
                        // OR use rs.getString("flight_class") if you renamed it
                );
                flights.add(f);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("flights", flights);
        request.getRequestDispatcher("/jsp/admin/viewFlights.jsp").forward(request, response);
    }
}

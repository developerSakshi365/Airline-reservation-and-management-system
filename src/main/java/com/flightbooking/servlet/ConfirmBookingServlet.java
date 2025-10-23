package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ConfirmBookingServlet")
public class ConfirmBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        int flightId = Integer.parseInt(request.getParameter("flight_id"));
        int passengers = Integer.parseInt(request.getParameter("passengers"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/flight_booking", "root", "12345");
                 PreparedStatement ps = con.prepareStatement(
                         "INSERT INTO bookings(user_id, flight_id, passengers) VALUES (?, ?, ?)",
                         Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, userId);
                ps.setInt(2, flightId);
                ps.setInt(3, passengers);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (keys.next()) {
                            int bookingId = keys.getInt(1);
                            response.sendRedirect(request.getContextPath() + "/bookingConfirmation.jsp?bookingId=" + bookingId);
                            return;
                        }
                    }
                }
                response.getWriter().println("Failed to create booking.");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.flightbooking.util.EmailUtil;  // ✅ use helper

@WebServlet("/BookFlightServlet")
public class BookFlightServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sess = request.getSession(false);
        if (sess == null || sess.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) sess.getAttribute("userId");
        int flightId = Integer.parseInt(request.getParameter("flightId"));
        String travelDate = request.getParameter("travelDate");
        String classType = request.getParameter("classType");
        int passengers = Integer.parseInt(request.getParameter("passengers"));

        String url = "jdbc:mysql://localhost:3306/flight_booking";

        try (Connection con = DriverManager.getConnection(url, "root", "12345")) {
            int bookingId = 0;

            // ✅ Insert booking
            try (PreparedStatement pst = con.prepareStatement(
                "INSERT INTO bookings (user_id, flight_id, travel_date, passengers, `class`, status) VALUES (?, ?, ?, ?, ?, 'CONFIRMED')",
                Statement.RETURN_GENERATED_KEYS)) {

                pst.setInt(1, userId);
                pst.setInt(2, flightId);
                pst.setDate(3, java.sql.Date.valueOf(travelDate));
                pst.setInt(4, passengers);
                pst.setString(5, classType);
                pst.executeUpdate();

                ResultSet keys = pst.getGeneratedKeys();
                if (keys.next()) {
                    bookingId = keys.getInt(1);
                }
            }

            // ✨ Fetch user email + flight details
            String userEmail = "", username = "", flightNum = "", airline = "", source = "", dest = "", dep = "", arr = "";
            double price = 0;

            try (PreparedStatement psUser = con.prepareStatement("SELECT email, username FROM users WHERE id=?")) {
                psUser.setInt(1, userId);
                ResultSet rs = psUser.executeQuery();
                if (rs.next()) {
                    userEmail = rs.getString("email");
                    username = rs.getString("username");
                }
            }

            try (PreparedStatement psFlight = con.prepareStatement("SELECT * FROM flights WHERE id=?")) {
                psFlight.setInt(1, flightId);
                ResultSet rs = psFlight.executeQuery();
                if (rs.next()) {
                    flightNum = rs.getString("flight_number");
                    airline = rs.getString("airline");
                    source = rs.getString("source");
                    dest = rs.getString("destination");
                    dep = rs.getString("departure_time");
                    arr = rs.getString("arrival_time");
                    price = rs.getDouble("price");
                }
            }

            // ✅ Prepare placeholders
            if (userEmail != null && !userEmail.isEmpty()) {
                Map<String, String> vals = new HashMap<>();
                vals.put("USERNAME", username);
                vals.put("BOOKING_ID", String.valueOf(bookingId));
                vals.put("FLIGHT_NUM", flightNum);
                vals.put("AIRLINE", airline);
                vals.put("SOURCE", source);
                vals.put("DEST", dest);
                vals.put("TRAVEL_DATE", travelDate);
                vals.put("DEPARTURE", dep);
                vals.put("ARRIVAL", arr);
                vals.put("CLASS", classType);
                vals.put("PASSENGERS", String.valueOf(passengers));
                vals.put("TOTAL_PRICE", String.format("₹ %.2f", price * passengers));
                vals.put("HOME_URL", request.getContextPath() + "/myBookings.jsp");
                vals.put("SUPPORT_EMAIL", "support@skywings.com");

                EmailUtil.sendTemplateEmail(
                        getServletContext(),
                        "/WEB-INF/email/booking_template.html",
                        vals,
                        "✅ Your SkyWings Booking #" + bookingId,
                        userEmail
                );
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect(request.getContextPath() + "/myBookings.jsp");
    }
}

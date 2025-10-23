package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.flightbooking.util.EmailUtil;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sess = request.getSession(false);
        if (sess == null || sess.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) sess.getAttribute("userId");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        String url = "jdbc:mysql://localhost:3306/flight_booking";

        try (Connection con = DriverManager.getConnection(url, "root", "12345")) {
            // ✅ Fetch booking details
            String userEmail = "", username = "", flightNum = "", airline = "", source = "", dest = "", dep = "", arr = "", travelDate = "", classType = "";
            int passengers = 0;
            double price = 0;

            try (PreparedStatement psBooking = con.prepareStatement(
                    "SELECT b.travel_date, b.passengers, b.class, f.flight_number, f.airline, f.source, f.destination, f.departure_time, f.arrival_time, f.price, u.email, u.username " +
                    "FROM bookings b JOIN flights f ON b.flight_id=f.id JOIN users u ON b.user_id=u.id WHERE b.id=? AND b.user_id=?")) {
                psBooking.setInt(1, bookingId);
                psBooking.setInt(2, userId);
                ResultSet rs = psBooking.executeQuery();
                if (rs.next()) {
                    travelDate = rs.getDate("travel_date").toString();
                    passengers = rs.getInt("passengers");
                    classType = rs.getString("class");
                    flightNum = rs.getString("flight_number");
                    airline = rs.getString("airline");
                    source = rs.getString("source");
                    dest = rs.getString("destination");
                    dep = rs.getString("departure_time");
                    arr = rs.getString("arrival_time");
                    price = rs.getDouble("price");
                    userEmail = rs.getString("email");
                    username = rs.getString("username");
                }
            }

            // ✅ Update booking status
            try (PreparedStatement ps = con.prepareStatement("UPDATE bookings SET status='CANCELLED' WHERE id=? AND user_id=?")) {
                ps.setInt(1, bookingId);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }

            // ✅ Send cancellation email
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
                        "/WEB-INF/email/cancel_template.html",
                        vals,
                        "❌ Your SkyWings Booking Cancelled #" + bookingId,
                        userEmail
                );
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        response.sendRedirect(request.getContextPath() + "/myBookings.jsp");
    }
}

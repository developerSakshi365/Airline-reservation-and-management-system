package com.flightbooking.servlet;

import com.flightbooking.util.EmailUtil;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String ctx = request.getContextPath();

        // Always show same response to avoid account enumeration
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/flight_booking", "root", "12345")) {

                // find user by email
                try (PreparedStatement ps = con.prepareStatement("SELECT id, username FROM users WHERE email=?")) {
                    ps.setString(1, email.trim());
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            int userId = rs.getInt("id");
                            String username = rs.getString("username");

                            // generate long token
                            String token = UUID.randomUUID().toString() + UUID.randomUUID().toString();
                            Timestamp expiresAt = new Timestamp(System.currentTimeMillis() + 60L*60L*1000L); // 1 hour

                            try (PreparedStatement ins = con.prepareStatement(
                                    "INSERT INTO password_reset_tokens (user_id, token, expires_at) VALUES (?,?,?)")) {
                                ins.setInt(1, userId);
                                ins.setString(2, token);
                                ins.setTimestamp(3, expiresAt);
                                ins.executeUpdate();
                            }

                            // build reset URL (use request.getScheme()/getServerName/getServerPort in dev)
                            String resetUrl = request.getScheme() + "://" + request.getServerName()
                                + (request.getServerPort() == 80 || request.getServerPort() == 443 ? "" : ":"+request.getServerPort())
                                + ctx + "/ResetPasswordServlet?token=" + URLEncoder.encode(token, "UTF-8");

                            Map<String,String> vals = new HashMap<>();
                            vals.put("USERNAME", username);
                            vals.put("RESET_URL", resetUrl);

                            try {
                                EmailUtil.sendTemplateEmail(getServletContext(), "/WEB-INF/email/reset_password.html",
                                        vals, "SkyWings Password Reset", email);
                            } catch (Exception ex) {
                                // log and continue — we still show same message so user flow not broken
                                ex.printStackTrace();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // swallow - we still redirect to generic page
        }

        response.sendRedirect(ctx + "/forgot_sent.jsp");
    }
}

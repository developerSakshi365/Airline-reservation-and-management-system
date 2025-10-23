package com.flightbooking.servlet;

import com.flightbooking.util.EmailUtil;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {
    private static final String ADMIN_EMAIL = "developersakshi365@gmail.com"; // make sure .com is correct!

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String fromEmail = request.getParameter("email");
        String messageText = request.getParameter("message");

        boolean saved = false;

        // --- Save to DB ---
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/flight_booking", "root", "12345");
                 PreparedStatement ps = con.prepareStatement(
                         "INSERT INTO contact_messages(name, email, message, created_at, is_read) VALUES(?,?,?,NOW(),0)")) {

                ps.setString(1, name);
                ps.setString(2, fromEmail);
                ps.setString(3, messageText);
                int rows = ps.executeUpdate();
                saved = rows > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Even if DB save fails, still try to send email
        }

        // --- Prepare template values ---
        Map<String, String> values = new HashMap<>();
        values.put("NAME", name);
        values.put("EMAIL", fromEmail);
        values.put("SUBJECT", "New Contact Form Message");
        values.put("MESSAGE", messageText);

        try {
            // --- Send HTML email using template ---
            EmailUtil.sendTemplateEmail(
                getServletContext(),
                "/WEB-INF/email/contact_message.html",  // path to template
                values,
                "New contact form message from " + name,
                ADMIN_EMAIL
            );
        } catch (MessagingException me) {
            me.printStackTrace();
        }

        // --- Redirect back with status ---
        response.sendRedirect(request.getContextPath() + "/contact.jsp?status=" + (saved ? "success" : "fail"));
    }
}

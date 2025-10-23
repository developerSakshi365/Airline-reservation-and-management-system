package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.*;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Show reset form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        if (token == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_booking","root","12345");
                 PreparedStatement ps = con.prepareStatement(
                     "SELECT id, expires_at, used FROM password_reset_tokens WHERE token = ?")) {
                ps.setString(1, token);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        boolean used = rs.getInt("used") == 1;
                        Timestamp expires = rs.getTimestamp("expires_at");
                        if (used || expires.before(new Timestamp(System.currentTimeMillis()))) {
                            request.getRequestDispatcher("/reset_invalid.jsp").forward(request, response);
                            return;
                        } else {
                            request.setAttribute("token", token);
                            request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
                            return;
                        }
                    } else {
                        request.getRequestDispatcher("/reset_invalid.jsp").forward(request, response);
                        return;
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // Handle form submission: validate token & set new password
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm_password");
        String ctx = request.getContextPath();

        if (token == null || password == null || confirm == null || !password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
            return;
        }

        // check password strength (simple example)
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight_booking","root","12345")) {
                con.setAutoCommit(false);
                // lock token row
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT id, user_id, expires_at, used FROM password_reset_tokens WHERE token = ? FOR UPDATE")) {
                    ps.setString(1, token);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            con.rollback();
                            request.getRequestDispatcher("/reset_invalid.jsp").forward(request, response);
                            return;
                        }
                        int used = rs.getInt("used");
                        Timestamp expires = rs.getTimestamp("expires_at");
                        int userId = rs.getInt("user_id");
                        if (used == 1 || expires.before(new Timestamp(System.currentTimeMillis()))) {
                            con.rollback();
                            request.getRequestDispatcher("/reset_invalid.jsp").forward(request, response);
                            return;
                        }

                        // hash password (BCrypt)
                        String hashed = BCrypt.hashpw(password, BCrypt.gensalt(10));

                        // update user's password
                        try (PreparedStatement up = con.prepareStatement("UPDATE users SET password = ? WHERE id = ?")) {
                            up.setString(1, hashed);
                            up.setInt(2, userId);
                            up.executeUpdate();
                        }

                        // mark token as used
                        try (PreparedStatement mu = con.prepareStatement("UPDATE password_reset_tokens SET used = 1 WHERE token = ?")) {
                            mu.setString(1, token);
                            mu.executeUpdate();
                        }

                        con.commit();
                        response.sendRedirect(ctx + "/login.jsp?reset=success");
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Try again.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset_password.jsp").forward(request, response);
        }
    }
}

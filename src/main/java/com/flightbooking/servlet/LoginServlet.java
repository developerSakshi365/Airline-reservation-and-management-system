package com.flightbooking.servlet;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String input = request.getParameter("username"); // can be username OR email
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect"); // optional, for booking flow

        String url = "jdbc:mysql://localhost:3306/flight_booking";
        String dbUser = "root";
        String dbPass = "12345";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(url, dbUser, dbPass);
                 PreparedStatement pst = con.prepareStatement(
                     "SELECT id, username, email, role, password FROM users WHERE username=? OR email=?")) {

                pst.setString(1, input);
                pst.setString(2, input);

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        int userId = rs.getInt("id");
                        String dbUsername = rs.getString("username");  // always store username in session
                        String dbRole = rs.getString("role");
                        String storedPass = rs.getString("password");

                        boolean valid = false;

                        // --- Check hashed password ---
                        if (storedPass.startsWith("$2a$")) { 
                            // BCrypt hash
                            valid = BCrypt.checkpw(password, storedPass);
                        } else {
                            // Legacy plain-text password
                            if (password.equals(storedPass)) {
                                valid = true;

                                // 🔄 Upgrade to hashed password
                                String hashed = BCrypt.hashpw(password, BCrypt.gensalt(10));
                                try (PreparedStatement upd = con.prepareStatement(
                                        "UPDATE users SET password=? WHERE id=?")) {
                                    upd.setString(1, hashed);
                                    upd.setInt(2, userId);
                                    upd.executeUpdate();
                                }
                            }
                        }

                        if (valid) {
                            HttpSession session = request.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("username", dbUsername);
                            session.setAttribute("role", dbRole);

                            String context = request.getContextPath();

                            // --- Redirect rules ---
                            if ("admin".equalsIgnoreCase(dbRole)) {
                                response.sendRedirect(context + "/jsp/admin/adminHome.jsp");
                                return;
                            }

                            if (redirect != null && !redirect.isEmpty()) {
                                response.sendRedirect(redirect);
                                return;
                            }

                            // Normal users → go to index
                            response.sendRedirect(context + "/index.jsp");
                            return;
                        } else {
                            request.setAttribute("errorMessage", "Invalid username/email or password!");
                            request.getRequestDispatcher("/login.jsp").forward(request, response);
                        }

                    } else {
                        request.setAttribute("errorMessage", "Invalid username/email or password!");
                        request.getRequestDispatcher("/login.jsp").forward(request, response);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}

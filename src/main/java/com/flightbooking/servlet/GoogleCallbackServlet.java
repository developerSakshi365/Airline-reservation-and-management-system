package com.flightbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.Base64;
import java.util.logging.Logger;

import org.json.JSONObject;

@WebServlet("/GoogleCallbackServlet")
public class GoogleCallbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(GoogleCallbackServlet.class.getName());

    // TODO: Replace with your actual Google OAuth credentials
    private static final String CLIENT_ID = "YOUR_CLIENT_ID";
    private static final String CLIENT_SECRET = "YOUR_CLIENT_SECRET";
    private static final String REDIRECT_URI = "http://localhost:8080/AirlineManagementReservationSystem/GoogleCallbackServlet";

    // Add your admin email(s) here
    private static final String ADMIN_EMAIL = "developersakshi365@gmail.com";

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/flight_booking", "root", "12345");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String code = req.getParameter("code");
        String state = req.getParameter("state");

        HttpSession s = req.getSession(false);
        if (s == null || !state.equals(s.getAttribute("google_oauth_state"))) {
            resp.getWriter().println("❌ Invalid state parameter.");
            return;
        }

        if (code == null) {
            resp.getWriter().println("❌ Google did not return a code.");
            return;
        }

        try {
            // 1. Exchange code for tokens
            String tokenResponse = postForToken(code);
            JSONObject tokenJson = new JSONObject(tokenResponse);
            String idToken = tokenJson.getString("id_token");

            // 2. Decode JWT payload
            String[] parts = idToken.split("\\.");
            String payload = new String(Base64.getUrlDecoder().decode(parts[1]));
            JSONObject userInfo = new JSONObject(payload);

            String googleId = userInfo.getString("sub");
            String email = userInfo.getString("email");
            String name = userInfo.optString("name", email);

            // 3. Determine role based on email
            String role = email.equalsIgnoreCase(ADMIN_EMAIL) ? "admin" : "user";

            // 4. Insert or update user in DB
            int userId = upsertUser(googleId, email, name, role);

            if (userId <= 0) {
                resp.getWriter().println("❌ Failed to save user in database. Check server logs.");
                return;
            }

            // 5. Create session
            HttpSession session = req.getSession(true);
            session.setAttribute("userId", userId);
            session.setAttribute("username", name);
            session.setAttribute("email", email);
            session.setAttribute("role", role);

            // 6. Redirect based on role
            if ("admin".equals(role)) {
                resp.sendRedirect(req.getContextPath() + "/jsp/admin/adminHome.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("❌ Error: " + e.getMessage());
        }
    }

    private String postForToken(String code) throws IOException {
        URL url = new URL("https://oauth2.googleapis.com/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

        String data = "code=" + URLEncoder.encode(code, "UTF-8")
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8")
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&grant_type=authorization_code";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(data.getBytes());
        }

        int status = conn.getResponseCode();
        InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();
        if (is == null) {
            throw new IOException("No response stream from token endpoint, HTTP status: " + status);
        }

        try (BufferedReader br = new BufferedReader(new InputStreamReader(is))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            String resp = sb.toString();
            LOG.info("Token endpoint response (status " + status + "): " + resp);
            if (status < 200 || status >= 300) {
                throw new IOException("Token endpoint returned HTTP " + status + ": " + resp);
            }
            return resp;
        }
    }

    private int upsertUser(String googleId, String email, String name, String role) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            LOG.warning("MySQL driver not found: " + e.getMessage());
        }

        String selectSql = "SELECT id, google_id FROM users WHERE email=? OR google_id=?";
        String updateSql = "UPDATE users SET google_id=?, role=? WHERE id=?";
        String checkUserSql = "SELECT COUNT(*) FROM users WHERE username=?";
        String insertSql = "INSERT INTO users (username, email, password, role, google_id) VALUES (?,?,?,?,?)";

        try (Connection con = getConnection();
             PreparedStatement psSelect = con.prepareStatement(selectSql)) {

            psSelect.setString(1, email);
            psSelect.setString(2, googleId);
            ResultSet rs = psSelect.executeQuery();
            if (rs.next()) {
                int existingId = rs.getInt("id");
                String existingGoogleId = rs.getString("google_id");
                if (existingGoogleId == null || existingGoogleId.isEmpty()) {
                    try (PreparedStatement upd = con.prepareStatement(updateSql)) {
                        upd.setString(1, googleId);
                        upd.setString(2, role); // update role if admin
                        upd.setInt(3, existingId);
                        upd.executeUpdate();
                    }
                }
                LOG.info("Found existing user id=" + existingId + " for email=" + email);
                return existingId;
            }

            // Ensure unique username
            String finalUsername = (name != null && !name.isBlank()) ? name : email;
            try (PreparedStatement psCheck = con.prepareStatement(checkUserSql)) {
                psCheck.setString(1, finalUsername);
                ResultSet rsCheck = psCheck.executeQuery();
                if (rsCheck.next() && rsCheck.getInt(1) > 0) {
                    finalUsername = finalUsername.replaceAll("\\s+", "") + "_" + System.currentTimeMillis();
                }
            }

            try (PreparedStatement ins = con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                ins.setString(1, finalUsername);
                ins.setString(2, email);
                ins.setNull(3, java.sql.Types.VARCHAR); // password null
                ins.setString(4, role); // insert role (user/admin)
                ins.setString(5, googleId);

                int rows = ins.executeUpdate();
                if (rows == 0) {
                    LOG.severe("Insert failed, no rows affected.");
                    return -1;
                }

                ResultSet keys = ins.getGeneratedKeys();
                if (keys.next()) {
                    int id = keys.getInt(1);
                    LOG.info("Inserted new user id=" + id + " email=" + email);
                    return id;
                } else {
                    LOG.severe("No generated key returned.");
                    return -1;
                }
            }

        } catch (SQLException e) {
            LOG.severe("SQL Error in upsertUser: " + e.getMessage());
            e.printStackTrace();
            return -1;
        } catch (Exception e) {
            LOG.severe("Other Error in upsertUser: " + e.getMessage());
            e.printStackTrace();
            return -1;
        }
    }
}

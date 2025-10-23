package com.flightbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

@WebServlet("/GoogleLoginServlet")
public class GoogleLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // TODO: Replace with your actual Google OAuth Client ID
    private static final String CLIENT_ID = "YOUR_CLIENT_ID";

    // TODO: Must exactly match redirect URI in Google Cloud Console
    private static final String REDIRECT_URI = "http://localhost:8080/AirlineManagementReservationSystem/GoogleCallbackServlet";

    private String generateState() {
        byte[] b = new byte[24];
        new SecureRandom().nextBytes(b);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(b);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String state = generateState();
        HttpSession s = req.getSession(true);
        s.setAttribute("google_oauth_state", state);

        String scope = URLEncoder.encode("openid email profile", StandardCharsets.UTF_8);

        String authUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                + "?response_type=code"
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                + "&scope=" + scope
                + "&state=" + URLEncoder.encode(state, StandardCharsets.UTF_8)
                + "&access_type=online"
                + "&prompt=select_account";

        resp.sendRedirect(authUrl);
    }
}

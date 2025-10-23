package com.flightbooking.util;

import java.io.*;
import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletContext;

public class EmailUtil {

    // --- CONFIG (your Gmail + App Password) ---
    private static final String FROM_EMAIL = "developersakshi365@gmail.com";  // your Gmail
    private static final String FROM_PASSWORD = "ptirjucwdezumnvs";           // your App Password
    private static final String FROM_NAME = "SkyWings Airlines";              // display name

    // Load template from WEB-INF/email/... using ServletContext
    public static String loadTemplate(ServletContext ctx, String path) throws IOException {
        try (InputStream is = ctx.getResourceAsStream(path)) {
            if (is == null) throw new FileNotFoundException("Template not found: " + path);
            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) sb.append(line).append("\n");
                return sb.toString();
            }
        }
    }

    // Replace placeholders like {{KEY}} with provided values
    public static String applyTemplate(String template, Map<String,String> values) {
        String out = template;
        if (values != null) {
            for (Map.Entry<String,String> e : values.entrySet()) {
                String token = "{{" + e.getKey() + "}}";
                String val = e.getValue() == null ? "" : e.getValue();
                out = out.replace(token, val);
            }
        }
        return out;
    }

    // Send HTML email
    public static void sendHtmlEmail(String to, String subject, String htmlContent) throws MessagingException {
        Session session = getSession();

        Message msg = new MimeMessage(session);
        try {
            msg.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME, "UTF-8"));
        } catch (UnsupportedEncodingException uee) {
            msg.setFrom(new InternetAddress(FROM_EMAIL));
        }
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        msg.setSubject(subject);
        msg.setContent(htmlContent, "text/html; charset=utf-8");

        Transport.send(msg);
    }

    // Convenience: load template, apply values, send
    public static void sendTemplateEmail(ServletContext ctx, String templatePath,
                                         Map<String,String> values, String subject, String to)
            throws IOException, MessagingException {
        String template = loadTemplate(ctx, templatePath);
        String html = applyTemplate(template, values);
        sendHtmlEmail(to, subject, html);
    }

    // Send plain text email with Reply-To
    public static void sendEmail(String to, String subject, String textContent, String replyTo)
            throws MessagingException {
        Session session = getSession();

        Message msg = new MimeMessage(session);
        try {
            msg.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME, "UTF-8"));
        } catch (UnsupportedEncodingException uee) {
            msg.setFrom(new InternetAddress(FROM_EMAIL));
        }
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        msg.setSubject(subject);
        msg.setText(textContent);

        if (replyTo != null && !replyTo.isBlank()) {
            msg.setReplyTo(new Address[]{new InternetAddress(replyTo)});
        }

        Transport.send(msg);
    }

    // Helper: setup Gmail SMTP session
    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth","true");
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.host","smtp.gmail.com");
        props.put("mail.smtp.port","587");

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });
    }

    // --- NEW METHOD FOR PASSWORD RESET EMAIL ---
    public static void sendPasswordResetEmail(ServletContext ctx, String to, String username, String resetUrl)
            throws Exception {
        // Load reset_password.html template from WEB-INF/email
        String template = loadTemplate(ctx, "/WEB-INF/email/reset_password.html");

        // Replace placeholders
        template = template.replace("{{USERNAME}}", username);
        template = template.replace("{{RESET_URL}}", resetUrl);

        // Send mail
        sendHtmlEmail(to, "SkyWings Password Reset", template);
    }
}

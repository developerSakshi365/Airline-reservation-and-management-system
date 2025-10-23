<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // ✅ Role check
    if (session.getAttribute("role") == null || 
        !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/flight_booking", "root", "12345");
    PreparedStatement ps = con.prepareStatement(
            "SELECT id, name, email, message, created_at, is_read FROM contact_messages ORDER BY created_at DESC");
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Contact Messages</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f8fb;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #02487c;
        }

        .main-content {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: 30px 10px;   /* 🔹 smaller side padding */
}

.contact-box {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 1200px;   /* 🔹 was 1000px, now wider */
}


        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 14px;
        }

        th {
            background: #02487c;
            color: #fff;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
            vertical-align: top;
            font-size: 15px;
        }

        /* ✅ Fix for Message column */
        .message-cell {
            max-width: 400px;
            white-space: normal;     /* wrap naturally */
            word-break: break-word;  /* break long words */
            line-height: 1.5;
        }

        tr.unread {
            background: #f6fbff;
            font-weight: bold;
        }

        a {
            color: #02487c;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        button {
            background: #02487c;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            transition: 0.2s ease;
        }

        button:hover {
            background: #0360aa;
        }

        /* Responsive */
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
                width: 100%;
            }
            th {
                display: none;
            }
            td {
                padding: 8px;
                border: none;
                border-bottom: 1px solid #ddd;
            }
            td::before {
                content: attr(data-label);
                font-weight: bold;
                display: block;
                margin-bottom: 4px;
                color: #02487c;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/jsp/admin/adminNavbar.jsp" %>

    <div class="main-content">
        <div class="contact-box">
            <h2>Contact Messages</h2>
            <table>
                <thead>
                    <tr>
                        <th>When</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Message</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        boolean isRead = rs.getInt("is_read") == 1;
                %>
                    <tr class="<%= isRead ? "" : "unread" %>">
                        <td data-label="When"><%= rs.getTimestamp("created_at") %></td>
                        <td data-label="Name"><%= rs.getString("name") %></td>
                        <td data-label="Email">
                            <a href="mailto:<%= rs.getString("email") %>?subject=Re:%20Your%20message%20to%20SkyWings">
                                <%= rs.getString("email") %>
                            </a>
                        </td>
                        <td data-label="Message" class="message-cell">
                            <%= rs.getString("message") %>
                        </td>
                        <td data-label="Actions">
                            <form action="<%=request.getContextPath()%>/MarkMessageServlet" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<%=id%>">
                                <button type="submit"><%= isRead ? "Mark Unread" : "Mark Read" %></button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                %>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="/jsp/admin/adminFooter.jsp" %>
</body>
</html>

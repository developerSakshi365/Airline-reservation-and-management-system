<footer class="admin-footer">
    <div class="footer-container">
        <span>© <%= java.time.Year.now() %> Airline Reservation & Management System</span>
        <span>Logged in as <strong>Saksh vishwakarma</strong> | Role: Admin </span>
        <span>Version 1.0 | Powered by Java, MySQL & Apache Tomcat</span>
    </div>
</footer>

<style>
/* Sticky Admin Footer */
.admin-footer {
    background: #02487c;
    color: #dbe9f5;
    font-size: 14px;
    border-top: 2px solid #003a63;
    font-family: Arial, sans-serif;
    padding: 10px 10px;
    position: fixed;   /* <-- makes it sticky */
    bottom: 0;
    left: 0;
    width: 100%;
    z-index: 100;      /* ensures it stays above other elements */
}

/* Flexbox for one-line layout */
.admin-footer .footer-container {
    max-width: 1100px;
    margin: auto;
    display: flex;
    justify-content: space-between; /* spread across */
    align-items: center;
    padding: 8px 15px;
    flex-wrap: wrap; /* prevents overflow on small screens */
}

.admin-footer .footer-container span {
    margin: 0 10px;
    white-space: nowrap; /* prevents breaking into multiple lines */
}
</style>

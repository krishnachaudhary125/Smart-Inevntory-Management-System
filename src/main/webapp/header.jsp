<header>
    <div class="logo-title">
        <a href="index.jsp?link=home" class="logo-link">
            <img src="images/logo.png" alt="SIMS Logo">
            <h1>Smart Inventory Management System</h1>
        </a>
    </div>

    <%
        boolean loggedIn = session.getAttribute("userId") != null;
        String username = (String) session.getAttribute("uname");
    %>

    <% if (!loggedIn) { %>
        <nav>
            <ul>
                <li><a href="index.jsp?link=home">Home</a></li>
                <li><a href="index.jsp?link=about">About</a></li>
                <li><a href="index.jsp?link=contact">Contact</a></li>
                <li><a href="index.jsp?link=sign_in">Sign In</a></li>
            </ul>
        </nav>
    <% } else { %>
        <div class="header-actions">

            <!-- Alert Popup -->
            <div class="dropdown">
                <button class="dropbtn" onclick="togglePopup('alertPopup')"><img src="images/icons/notifications.png" alt="Notification" width="24" height="24"></button>
                <div id="alertPopup" class="dropdown-content">
                    <a href="#">Low stock alert</a>
                    <a href="#">Expiry warning</a>
                    <a href="#">New product added</a>
                    <a href="index.jsp?link=dashboard&menu=notifications">View all</a>
                </div>
            </div>

            <!-- User Popup -->
            <div class="dropdown">
                <button class="dropbtn" onclick="togglePopup('userPopup')">
                    <%= username != null ? username : "User" %>
                    <img src="images/icons/arrow_dropdown.png" alt="Drop Down" width="24" height="24">
                </button>
                <div id="userPopup" class="dropdown-content">
                    <a href="index.jsp?link=profile">Profile</a>
                    <a href="index.jsp?link=edit_profile">Edit Profile</a>
                    <hr>
                    <a href="sign_out">Sign Out</a>
                </div>
            </div>

        </div>
    <% } %>
</header>
<script>
function togglePopup(popupId) {
    const popup = document.getElementById(popupId);
    const isVisible = popup.style.display === 'block';

    document.querySelectorAll('.dropdown-content').forEach(p => p.style.display = 'none');
    popup.style.display = isVisible ? 'none' : 'block';
}

// Close dropdown
window.addEventListener('click', function(event) {
    if (!event.target.matches('.dropbtn')) {
        document.querySelectorAll('.dropdown-content').forEach(popup => {
            popup.style.display = 'none';
        });
    }
});

</script>
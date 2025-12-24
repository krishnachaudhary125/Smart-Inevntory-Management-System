<div class="home_container">
    <section class="home">
        <div class="home-content">
            <h1>Welcome to Smart Inventory Management System</h1>
            <p>Manage your inventory efficiently, track stock and also find out require stock for future.</p>
            <%
                            boolean loggedIn = session.getAttribute("userId") != null;
                            if (loggedIn) {
                        %>
                            <a href="index.jsp?link=dashboard&menu=statistics" class="btn">Go to Dashboard</a>
                        <%
                            } else {
                        %>
                            <a href="index.jsp?link=sign_in" class="btn">Get Started</a>
                        <%
                            }
                        %>
        </div>
    </section>
</div>

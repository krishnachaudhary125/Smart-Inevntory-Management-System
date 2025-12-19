
<header>
    <div class="logo-title">
         <a href="index.jsp?link=home" class="logo-link">
                    <img src="images/logo.png" alt="SIMS Logo">
                    <h1>Smart Inventory Management System</h1>
                </a>
        </div>
        <%
            boolean loggedIn = session.getAttribute("userId") != null;
        %>
        <nav>
            <ul>
                <li>
                    <a href="index.jsp?link=home">Home</a>
                </li>

                <li>
                    <a href="index.jsp?link=about">About</a>
                </li>

                <li>
                    <a href="index.jsp?link=contact">Contact</a>
                </li>

                 <% if (loggedIn) { %>
                         <li><a href="index.jsp?link=dashboard">Dashboard</a></li>
                         <li><a href="logout">Logout</a></li>
                     <% } else { %>
                         <li><a href="index.jsp?link=sign_in">Sign In</a></li>
                     <% } %>
            </ul>
        </nav>
</header>


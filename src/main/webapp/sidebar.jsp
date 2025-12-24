<nav class="sidebar-nav">
    <div class="option">
        <ul>
            <li>
                <a href="index.jsp?link=dashboard&menu=statistics"
                class="<%= "statistics".equals(request.getParameter("menu")) ? "active" : "" %>">Statistics</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=admin"
                class="<%= "statistics".equals(request.getParameter("menu")) ? "active" : "" %>">Admin</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=user"
                class="<%= "statistics".equals(request.getParameter("menu")) ? "active" : "" %>">Staff</a>
            </li>
        </ul>
    </div>
</nav>
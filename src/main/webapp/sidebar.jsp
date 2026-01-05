<nav class="sidebar-nav">
    <div class="option">
        <ul>
            <li>
                <a href="index.jsp?link=dashboard&menu=statistics"
                   class="<%= "statistics".equals(request.getParameter("menu")) ? "active" : "" %>">Statistics</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=admin"
                   class="<%= "admin".equals(request.getParameter("menu")) ? "active" : "" %>">Admin</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=staff"
                   class="<%= "staff".equals(request.getParameter("menu")) ? "active" : "" %>">Staff</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=users"
                   class="<%= "users".equals(request.getParameter("menu")) ? "active" : "" %>">Users</a>
            </li>
        </ul>
    </div>
</nav>

<nav class="sidebar-nav">
    <div class="option">
        <ul>
            <li>
                <a href="index.jsp?link=dashboard&menu=statistics"
                   class="<%= "statistics".equals(request.getParameter("menu")) ? "active" : "" %>">Statistics</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=users"
                   class="<%= "users".equals(request.getParameter("menu")) ? "active" : "" %>">Users</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=vendors"
                   class="<%= "vendors".equals(request.getParameter("menu")) ? "active" : "" %>">Vendors</a>
            </li>
        </ul>
    </div>
</nav>

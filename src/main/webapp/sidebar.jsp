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
            <li>
                <a href="index.jsp?link=dashboard&menu=category"
                   class="<%= "category".equals(request.getParameter("menu")) ? "active" : "" %>">Category</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=members"
                   class="<%= "members".equals(request.getParameter("menu")) ? "active" : "" %>">
                   Members
                </a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=products"
                   class="<%= "products".equals(request.getParameter("menu")) ? "active" : "" %>">Products</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=stockout"
                    class="<%= "stockout".equals(request.getParameter("menu")) ? "active" : "" %>">Stock Out</a>
            </li>
            <li>
                <a href="index.jsp?link=dashboard&menu=sales"
                   class="<%= "sales".equals(request.getParameter("menu")) ? "active" : "" %>">
                   Sales
                </a>
            </li>
        </ul>
    </div>
</nav>

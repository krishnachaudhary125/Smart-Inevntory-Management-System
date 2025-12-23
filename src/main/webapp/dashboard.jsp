<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("index.jsp?link=sign_in");
        return;
    }
%>

<div class="dashboard-container">

    <aside class="dashboard-sidebar">
        <jsp:include page="sidebar.jsp" />
    </aside>

    <main class="dashboard-main">

        <%
            String menu = request.getParameter("menu");
            if (menu == null) {
                menu = "default";
            }
        %>

        <section class="dashboard-content">
            <% if ("statistics".equals(menu)) { %>
                <jsp:include page="statistics.jsp" />
            <% } else if ("products".equals(menu)) { %>
                <jsp:include page="admin.jsp" />
            <% } else if ("users".equals(menu)) { %>
                <jsp:include page="staff.jsp" />
            <% }%>
        </section>

    </main>

</div>

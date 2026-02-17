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
            if ("users".equals(menu)) {
                com.example.project.dao.UserDAO userDAO = new com.example.project.dao.UserDAO();
                java.util.List<com.example.project.model.User> users = userDAO.getAllUsers();
                request.setAttribute("users", users);
            }
        %>

        <section class="dashboard-content">
            <%
                    if (menu == null || menu.equals("statistics")) {
                        %>
                        <jsp:include page="statistics.jsp" />
                        <%
                    } else if (menu.equals("admin")) {
                        %>
                        <jsp:include page="admin.jsp" />
                        <%
                    } else if (menu.equals("staff")) {
                        %>
                        <jsp:include page="staff.jsp" />
                        <%
                    } else if (menu.equals("users")) {
                        %>
                        <jsp:include page="users.jsp" />
                        <%
                    } else if(menu.equals("vendors")){
                        %>
                        <jsp:include page="vendors.jsp" />
                        <%
                    }
                %>
        </section>

    </main>

</div>

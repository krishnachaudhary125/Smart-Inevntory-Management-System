<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("index.jsp?link=sign_in");
        return;
    }
%>

<div class="dashboard-container">
<div class="dashboard-sidebar">
<jsp:include page = "sidebar.jsp" />
</div>

<div class="dashboard-body">
<%
    String menu = request.getParameter("menu");
    if(menu == null) {
        menu = "default";
    }
%>

<div class="dashboard-content">
    <% if("statistics".equals(menu)) { %>
        <jsp:include page="statistics.jsp" />
    <% } else if("products".equals(menu)) { %>
        <jsp:include page="admin.jsp" />
    <% } else if("users".equals(menu)) { %>
        <jsp:include page="staff.jsp" />
    <% } else { %>
        <p>Select a menu from the sidebar.</p>
    <% } %>
</div>
</div>
</div>
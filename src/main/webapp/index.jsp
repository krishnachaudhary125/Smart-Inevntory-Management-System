<html>
<head>
    <title>Smart Inventory Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<%
    String link = request.getParameter("link");

    if ("dashboard".equals(link) && session.getAttribute("userId") == null) {
        response.sendRedirect("index.jsp?link=sign_in");
        return;
    }
%>

<jsp:include page="header.jsp" />

<div class="main_content">
    <%
        if(link == null || link.equals("home")) {
    %>
            <jsp:include page="home.jsp" />
    <%
        } else if(link.equals("about")) {
    %>
            <jsp:include page="about.jsp" />
    <%
        } else if(link.equals("contact")) {
    %>
            <jsp:include page="contact.jsp" />
    <%
        } else if(link.equals("dashboard")) {
    %>
            <jsp:include page="dashboard.jsp" />
    <%
        } else if(link.equals("sign_in")) {
    %>
            <jsp:include page="sign_in.jsp" />
    <%
        }
    %>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>

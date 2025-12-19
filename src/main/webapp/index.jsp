<html>

<head>
    <title>Smart Inventory Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="header.jsp" />
<div class="main_content">
    <%
        String link = request.getParameter("link");

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
        } else if(link.equals("dashboard")){
        //Checking if the user have signed in or not
            if (session.getAttribute("userId") != null) {
            %>
              <jsp:include page="dashboard.jsp" />
            <%
            } else {
               response.sendRedirect("index.jsp?link=sign_in");
               return;
            }
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
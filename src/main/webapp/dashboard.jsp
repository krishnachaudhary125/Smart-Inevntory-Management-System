<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("index.jsp?link=sign_in");
        return;
    }
%>
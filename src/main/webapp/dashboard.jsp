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
            else if ("vendors".equals(menu)) {
                try (java.sql.Connection conn = com.example.project.util.DBConnection.getConnection()) {
                    com.example.project.dao.VendorDAO vendorDAO = new com.example.project.dao.VendorDAO(conn);
                    java.util.List<com.example.project.model.Vendor> vendors = vendorDAO.getAllVendors();
                    request.setAttribute("vendors", vendors);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }else if ("category".equals(menu)) {
                try (java.sql.Connection conn = com.example.project.util.DBConnection.getConnection()) {
                    com.example.project.dao.CategoryDAO categoryDAO = new com.example.project.dao.CategoryDAO(conn);
                    java.util.List<com.example.project.model.Category> category = categoryDAO.getAllCategory();
                    request.setAttribute("category", category);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>

        <section class="dashboard-content">
            <%
                    if (menu == null || menu.equals("statistics")) {
                        %>
                        <jsp:include page="statistics.jsp" />
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
                    } else if(menu.equals("category")){
                        %>
                        <jsp:include page="category.jsp" />
                        <%
                    } else if(menu.equals("products")){
                        %>
                        <jsp:include page="products.jsp" />
                        <%
                    }
                %>
        </section>

    </main>

</div>

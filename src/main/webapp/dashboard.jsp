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
            }else if ("products".equals(menu)) {
                 try (java.sql.Connection conn = com.example.project.util.DBConnection.getConnection()) {

                     com.example.project.dao.CategoryDAO categoryDAO = new com.example.project.dao.CategoryDAO(conn);
                     java.util.List<com.example.project.model.Category> categories = categoryDAO.getAllCategory();
                     request.setAttribute("categories", categories);

                     com.example.project.dao.VendorDAO vendorDAO = new com.example.project.dao.VendorDAO(conn);
                     java.util.List<com.example.project.model.Vendor> vendors = vendorDAO.getAllVendors();
                     request.setAttribute("vendors", vendors);

                     com.example.project.dao.BatchDAO batchDAO = new com.example.project.dao.BatchDAO(conn);
                     java.util.List<com.example.project.model.Batch> batches = batchDAO.getAllBatches();
                     request.setAttribute("batches", batches);

                     com.example.project.dao.ProductDAO productDAO = new com.example.project.dao.ProductDAO(conn);
                     java.util.List<com.example.project.model.ProductInventory> inventory = productDAO.getInventory();
                     request.setAttribute("inventory", inventory);

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
<div id="toast" class="toast"></div>
<script>

const toast = document.getElementById("toast");

function showToast(msg,type){
    toast.innerText = msg;
    toast.className = "toast show " + type;

    setTimeout(()=>{
        toast.classList.remove("show");
    },3000);
}

document.addEventListener("DOMContentLoaded",()=>{

    <% if("success".equals(request.getParameter("sign_in"))){ %>

        showToast("Welcome <%= session.getAttribute("uname") %>! Sign In successful.","success");

    <% } %>

});

</script>
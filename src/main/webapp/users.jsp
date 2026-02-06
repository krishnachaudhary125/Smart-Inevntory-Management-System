<%@ page import="com.example.project.model.User" %>
<%@ page import="java.util.List" %>

<div class="user-container">
    <nav class="user-header">
        <ul>
            <li><button id="add-user-btn">Add User</button></li>
            <li><button>Role Filter</button></li>
            <li>
        <div class="search">
            <input type="text" placeholder="Search User">
            <button>Search</button>
        </div>
            </li>
        </ul>
    </nav>

    <div id="add-user-modal" class="add-user-modal">
    <div class="add-user-container">
    <span class="close">&times;</span>
    <h2>Add User</h2>
    <form action="" method="post">
    <div class="add_user_field">
        <input type="text" name="uname" id="uname" value="" placeholder="Enter username">
    </div>
    <div class="add_user_field">
        <input type="text" name="email" id="email" value="" placeholder="Enter email">
    </div>
    <div class="add_user_field">
        <input type="password" name="psw" id="psw" value="" placeholder="Enter password">
    </div>
    <div class="show_password">
        <input type="checkbox" id="showPassword" onclick="togglePassword()">
        <label for="showPassword">Show Password</label>
    </div>
    <%
    String role =(String) session.getAttribute("role");
    if("super-admin".equals(role)){
    %>
    <div class="role-options">
        <label class="role-item">
                <input type="radio" name="role" value="staff">
                <span>Staff</span>
            </label>

            <label class="role-item">
                <input type="radio" name="role" value="admin">
                <span>Admin</span>
            </label>
    </div>
    <%
    } else {
    %>
        <input type="hidden" name="role" value="staff">
    <%
    }
    %>
    <div class="add_user_button">
        <button type="submit" name="add_user_button" id="add_user_button">Sign In</button>
    </div>
    </form>
    </div>
    </div>
    
    <div class="user-table">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                           <%
                           Object obj = request.getAttribute("users");
                           List<User> users = null;

                           if (obj instanceof List) {
                               users = (List<User>) obj;
                           }

                           if (users != null && !users.isEmpty()) {
                               for (User u : users) {
                           %>
                           <tr>
                               <td><%= u.getUserId() %></td>
                               <td><%= u.getUsername() %></td>
                               <td><%= u.getEmail() %></td>
                               <td><%= u.getRole() %></td>
                               <td>
                                   <button class="edit" data-id="<%= u.getUserId() %>">Edit</button>
                                   <button class="delete" data-id="<%= u.getUserId() %>">Delete</button>
                               </td>
                           </tr>
                           <%
                               }
                           } else {
                           %>
                           <tr>
                               <td colspan="5" style="text-align:center; padding:15px;">No users found</td>
                           </tr>
                           <%
                           }
                           %>

                        </tbody>
        </table>
    </div>

</div>

<script>
    function togglePassword() {
        var pw = document.getElementById("psw");
        if (pw.type === "password") {
            pw.type = "text";
        } else {
            pw.type = "password";
        }
    }
    const modal = document.getElementById("add-user-modal");
    const closeBtn = document.querySelector(".close");

    document.getElementById("add-user-btn").onclick = () => {
        modal.style.display = "flex";
    };

    closeBtn.onclick = () => modal.style.display = "none";

    window.onclick = (e) => {
        if (e.target === modal) modal.style.display = "none";
    };
</script>
<%@ page import="com.example.project.model.User" %>
    <%@ page import="java.util.List" %>

        <div class="user-container">
            <nav class="user-header">
                <ul>
                    <li><button id="add-user-btn">Add User</button></li>
                    <li><button>Role Filter</button></li>
                    <li>
                        <div class="search-user">
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
                    <%
    String generalError = (String) session.getAttribute("generalError");
    String unameError = (String) session.getAttribute("unameError");
    String emailError = (String) session.getAttribute("emailError");
    String pswError = (String) session.getAttribute("pswError");
    String cpswError = (String) session.getAttribute("cpswError");

    boolean hasServerErrors = generalError != null || unameError != null 
            || emailError != null || pswError != null || cpswError != null;

    session.removeAttribute("generalError");
    session.removeAttribute("unameError");
    session.removeAttribute("emailError");
    session.removeAttribute("pswError");
    session.removeAttribute("cpswError");
%>

            <% if (generalError != null) { %>
                <div class="general-error"><%= generalError %></div>
            <% } %>

                            <form action="<%= request.getContextPath() %>/addUser" method="post" onsubmit="return validateAddUserForm()">
                                <div class="add_user_field">
                                    <input type="text" name="uname" id="uname" value="<%= request.getParameter(" uname")
                                        !=null ? request.getParameter("uname") : "" %>" placeholder="Enter username"
                                    required>
                                    <small class="error" id="unameError">
                                        <%= unameError != null ? unameError : "" %>
                                    </small>
                                </div>
                                <div class="add_user_field">
                                    <input type="text" name="email" id="email" value="<%= request.getParameter(" email")
                                        !=null ? request.getParameter("email") : "" %>" placeholder="Enter email"
                                    required>
                                    <small class="error" id="emailError">
                                        <%= emailError != null ? emailError : "" %>
                                    </small>
                                </div>
                                <div class="add_user_field">
                                    <input type="password" name="psw" id="psw" value="" placeholder="Enter password"
                                        required>
                                    <small class="error" id="pswError">
                                       <%= pswError != null ? pswError : "" %>
                                    </small>
                                </div>
                                <div class="add_user_field">
                                    <input type="password" name="cpsw" id="cpsw" value="" placeholder="Confirm Password"
                                        required>
                                    <small class="error" id="cpswError">
                                        <%= cpswError != null ? cpswError : "" %>
                                    </small>
                                </div>
                                <div class="show_password">
                                    <input type="checkbox" id="showPassword" onclick="togglePassword()">
                                    <label for="showPassword">Show Password</label>
                                </div>
                                <% String role=(String) session.getAttribute("role"); if("super-admin".equals(role)){ %>
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
                                    <% } else { %>
                                        <input type="hidden" name="role" value="staff">
                                        <% } %>
                                            <div class="add_user_button">
                                                <button type="submit" name="add_user_button" id="add_user_button">Add
                                                    User</button>
                                            </div>
                            </form>
                </div>
            </div>

            <div class="user-table">
                <table>
                    <thead>
                        <tr>
                            <th>S.No</th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% Object obj=request.getAttribute("users"); List<User> users = null;

                            if (obj instanceof List) {
                            users = (List<User>) obj;
                                }
                                String currentRole = (String) session.getAttribute("role");

                                if (users != null && !users.isEmpty()) {
                                    int counter = 1;
                                for (User u : users) {
                                %>
                                <tr>
                                    <td>
                                        <%= counter++ %>
                                    </td>
                                    <td>
                                        <%= u.getUserId() %>
                                    </td>
                                    <td>
                                        <%= u.getUsername() %>
                                    </td>
                                    <td>
                                        <%= u.getEmail() %>
                                    </td>
                                    <td>
                                        <%= u.getRole() %>
                                    </td>
                                    <td>
                                        <%
                                            if ("super-admin".equals(currentRole)) {
                                        %>
                                            <button class="edit" data-id="<%= u.getUserId() %>">Edit</button>
                                            <button class="delete" data-id="<%= u.getUserId() %>">Delete</button>
                                        <%
                                            } else if ("admin".equals(currentRole) && "staff".equals(u.getRole())) {
                                        %>
                                            <button class="edit" data-id="<%= u.getUserId() %>">Edit</button>
                                            <button class="delete" data-id="<%= u.getUserId() %>">Delete</button>
                                        <%
                                            } else {
                                        %>
                                            <span style="color: gray;">No Access</span>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="5" style="text-align:center; padding:15px;">No users found</td>
                                    </tr>
                                    <% } %>

                    </tbody>
                </table>
            </div>

        </div>

        <div id="toast" class="toast"></div>

<script>
    // --- Password toggle ---
    function togglePassword() {
        const pw = document.getElementById("psw");
        const cpw = document.getElementById("cpsw");
        pw.type = pw.type === "password" ? "text" : "password";
        cpw.type = cpw.type === "password" ? "text" : "password";
    }

    // --- Modal handling ---
    const modal = document.getElementById("add-user-modal");
    const closeBtn = document.querySelector(".close");
    const addUserBtn = document.getElementById("add-user-btn");

    addUserBtn.onclick = () => modal.style.display = "flex";
    closeBtn.onclick = () => modal.style.display = "none";
    window.onclick = (e) => { if(e.target === modal) modal.style.display = "none"; };

    // --- Client-side validation ---
    function validateAddUserForm() {
        const uname = document.getElementById("uname");
        const email = document.getElementById("email");
        const psw = document.getElementById("psw");
        const cpsw = document.getElementById("cpsw");

        const unameError = document.getElementById("unameError");
        const emailError = document.getElementById("emailError");
        const pswError = document.getElementById("pswError");
        const cpswError = document.getElementById("cpswError");

        // Clear previous errors
        [unameError, emailError, pswError, cpswError].forEach(e => e.innerHTML = "");
        [uname, email, psw, cpsw].forEach(f => f.classList.remove("input-error"));

        let isValid = true;

        // Username validation
        if(uname.value.trim() === "") {
            unameError.innerHTML = "Username is required";
            uname.classList.add("input-error");
            isValid = false;
        } else if(uname.value.trim().length < 3) {
            unameError.innerHTML = "Minimum 3 characters required";
            uname.classList.add("input-error");
            isValid = false;
        }

        // Email validation
        const emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
        if(email.value.trim() === "") {
            emailError.innerHTML = "Email is required";
            email.classList.add("input-error");
            isValid = false;
        } else if(!emailPattern.test(email.value)) {
            emailError.innerHTML = "Invalid email format";
            email.classList.add("input-error");
            isValid = false;
        }

        // Password validation
        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&^#])[A-Za-z\d@$!%*?&^#]{8,}$/;
        if(psw.value.trim() === "") {
            pswError.innerHTML = "Password is required";
            psw.classList.add("input-error");
            isValid = false;
        } else if(!passwordPattern.test(psw.value)) {
            pswError.innerHTML = "Password must be 8+ chars, uppercase, lowercase, number & symbol";
            psw.classList.add("input-error");
            isValid = false;
        }

        // Confirm password validation
        if(cpsw.value !== psw.value) {
            cpswError.innerHTML = "Passwords do not match";
            cpsw.classList.add("input-error");
            isValid = false;
        }

        return isValid;
    }

    // --- Toast notifications ---
    const toast = document.getElementById("toast");
    function showToast(msg,type){ toast.innerText=msg; toast.className="toast show "+type; setTimeout(()=>toast.classList.remove("show"),3000); }

    // --- Show toast or auto-open modal based on server-side flags ---
    document.addEventListener('DOMContentLoaded',()=>{
        <% if("added".equals(request.getParameter("success"))){ %>
            showToast("User added successfully!","success");
        <% } %>
        <% if("failed".equals(request.getParameter("error"))){ %>
            showToast("Failed to add user!","error");
        <% } %>
        <% if("emailExists".equals(request.getParameter("error"))){ %>
            showToast("Email already exists!","error");
            modal.style.display="flex";
        <% } %>
        <% if("unameExists".equals(request.getParameter("error"))){ %>
            showToast("Username already exists!","error");
            modal.style.display="flex";
        <% } %>
        <% if(hasServerErrors){ %>
            modal.style.display="flex";
        <% } %>
    });
</script>

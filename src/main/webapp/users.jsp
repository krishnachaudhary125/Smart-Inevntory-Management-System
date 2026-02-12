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
                    <form action="addUser" method="post" onsubmit="return validateAddUserForm()">
                        <div class="add_user_field">
                            <input type="text" name="uname" id="uname" value="" placeholder="Enter username" required>
                            <small class="error" id="unameError"></small>
                        </div>
                        <div class="add_user_field">
                            <input type="text" name="email" id="email" value="" placeholder="Enter email" required>
                            <small class="error" id="emailError"></small>
                        </div>
                        <div class="add_user_field">
                            <input type="password" name="psw" id="psw" value="" placeholder="Enter password" required>
                            <small class="error" id="pswError"></small>
                        </div>
                        <div class="add_user_field">
                            <input type="password" name="cpsw" id="cpsw" value="" placeholder="Confirm Password"
                                required>
                            <small class="error" id="cpswError"></small>
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

                                if (users != null && !users.isEmpty()) {
                                for (User u : users) {
                                %>
                                <tr>
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
                                        <button class="edit" data-id="<%= u.getUserId() %>">Edit</button>
                                        <button class="delete" data-id="<%= u.getUserId() %>">Delete</button>
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

        <script>
            function togglePassword() {
                var pw = document.getElementById("psw");
                var cpw = document.getElementById("cpsw");
                if (pw.type === "password") {
                    pw.type = "text";
                } else {
                    pw.type = "password";
                }
                if (cpw.type === "password") {
                    cpw.type = "text";
                } else {
                    cpw.type = "password";
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

            function validateAddUserForm() {
                var uname = document.getElementById("uname");
                var email = document.getElementById("email");
                var psw = document.getElementById("psw");
                var cpsw = document.getElementById("cpsw");

                var unameError = document.getElementById("unameError");
                var emailError = document.getElementById("emailError");
                var pswError = document.getElementById("pswError");
                var cpswError = document.getElementById("cpswError");

                unameError.innerHTML = "";
                emailError.innerHTML = "";
                pswError.innerHTML = "";
                cpswError.innerHTML = "";

                uname.classList.remove("input-error");
                email.classList.remove("input-error");
                psw.classList.remove("input-error");
                cpsw.classList.remove("input-error");

                let isValid = true;

                //Checking if uname is empty or less than 3 char
                if (uname.value.trim() === "") {
                    unameError.innerHTML = "Username is required";
                    uname.classList.add("input-error");
                    isValid = false;
                } else if (uname.value.trim().length < 3) {
                    unameError.innerHTML = "Minimum 3 characters required";
                    uname.classList.add("input-error");
                    isValid = false;
                }

                //Checking if the email is empty and also if it is on standard format with regex code
                var emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
                if (email.value.trim() === "") {
                    emailError.innerHTML = "Email is required";
                    email.classList.add("input-error");
                    isValid = false;
                } else if (!email.value.match(emailPattern)) {
                    emailError.innerHTML = "Invalid email format";
                    email.classList.add("input-error");
                    isValid = false;
                }

                //Checking if the password contain at least 8 char with uppercase, lowercase, number and symbol
                var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&^#])[A-Za-z\d@$!%*?&^#]{8,}$/;

                if (psw.value.trim() === "") {
                    pswError.innerHTML = "Password is required";
                    psw.classList.add("input-error");
                    isValid = false;
                }
                else if (!passwordPattern.test(psw.value)) {
                    pswError.innerHTML = "Password need to be 8 charecter long and must contain capital and small letter, number and symbol.";
                    psw.classList.add("input-error");
                    isValid = false;
                }

                //Checking if the password and confirm password matched or not
                if (cpsw.value !== psw.value) {
                    cpswError.innerHTML = "Passwords do not match";
                    cpsw.classList.add("input-error");
                    isValid = false;
                }

                return isValid;
            }
        </script>
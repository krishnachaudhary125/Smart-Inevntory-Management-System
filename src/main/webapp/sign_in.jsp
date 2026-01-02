
<div class="sign_in_container">
    <form action="sign_in" method="POST" onsubmit="return validateForm()">
        <h1 class>Sign In</h1>
        <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="login-error">
                    <%= error %>
                </div>
            <%
                }
            %>
        <div>
            <div class="sign_in_field">
                <input type="text" name="uname" id="uname" value="" placeholder="Enter email or username">
                <small id="unameError" class="inputError"></small>
            </div>
            <div class="sign_in_field">
                <input type="password" name="psw" id="psw" value="" placeholder="Enter password">
                <small id="pswError" class="inputError"></small>
            </div>
            <div class="show_password">
                <input type="checkbox" id="showPassword" onclick="togglePassword()">
                <label for="showPassword">Show Password</label>
            </div>
            <div class="sign_in_button">
                <button type="submit" name="sign_in_button" id="sign_in_button">Sign In</button>
            </div>
            <div class="forgot_password">
                <a href="forgot_password.jsp">Forgot Password?</a>
            </div>
        </div>
    </form>
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

    function validateForm() {
        let uname = document.getElementById("uname").value.trim();
        let psw = document.getElementById("psw").value.trim();
        let valid = true;

        document.getElementById("unameError").innerText = "";
        document.getElementById("pswError").innerText = "";

        if (uname === "") {
            document.getElementById("unameError").innerText = "Username or email is required.";
            valid = false;
        }

        if (psw === "") {
            document.getElementById("pswError").innerText = "Password is required.";
            valid = false;
        }
        return valid;
    }
</script>

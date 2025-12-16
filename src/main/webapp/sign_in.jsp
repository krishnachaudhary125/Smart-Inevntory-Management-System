
<div class="sign_in_container">
    <form action="#" method="POST">
        <h1 class>Sign In</h1>
        <div>
            <div class="sign_in_field">
                <input type="text" name="uname" id="uname" value="" placeholder="Enter email or username">
            </div>
            <div class="sign_in_field">
                <input type="password" name="psw" id="psw" value="" placeholder="Enter password">
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
</script>

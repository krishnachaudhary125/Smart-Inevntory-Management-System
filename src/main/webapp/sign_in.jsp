<jsp:include page="header.jsp" />
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
            <div class="sign_in_button">
                <button type="submit" name="sign_in_button" id="sign_in_button">Sign In</button>
            </div>
        </div>
    </form>
</div>
<jsp:include page="footer.jsp" />
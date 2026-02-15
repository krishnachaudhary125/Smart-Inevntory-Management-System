package com.example.project.servlet;

import com.example.project.dao.UserDAO;
import com.example.project.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.example.project.util.PasswordHashing.sha1;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("uname");
        String email = req.getParameter("email");
        String password = req.getParameter("psw");
        String cpsw = req.getParameter("cpsw");
        String role = req.getParameter("role");

        HttpSession session = req.getSession();
        UserDAO dao = new UserDAO();

        session.removeAttribute("generalError");
        session.removeAttribute("unameError");
        session.removeAttribute("emailError");
        session.removeAttribute("pswError");
        session.removeAttribute("cpswError");

        boolean hasError = false;

        if(username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                cpsw == null || cpsw.trim().isEmpty()) {
            session.setAttribute("generalError", "All fields are required");
            hasError = true;
        }

        if(username != null && username.trim().length() < 3){
            session.setAttribute("unameError", "Username must be at least 3 characters");
            hasError = true;
        }

        String emailPattern = "^[^ ]+@[^ ]+\\.[a-z]{2,3}$";
        if(email != null && !email.matches(emailPattern)){
            session.setAttribute("emailError", "Invalid email format");
            hasError = true;
        }

        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&^#])[A-Za-z\\d@$!%*?&^#]{8,}$";
        if(password != null && !password.matches(passwordPattern)){
            session.setAttribute("pswError", "Password must be 8+ chars, uppercase, lowercase, number & symbol");
            hasError = true;
        }

        if(password != null && cpsw != null && !password.equals(cpsw)){
            session.setAttribute("cpswError", "Passwords do not match");
            hasError = true;
        }

        // --- Check existing email/username ---
        if(!hasError && dao.emailExists(email)){
            session.setAttribute("generalError", "Email already exists");
            hasError = true;
        }

        if(!hasError && dao.unameExists(username)){
            session.setAttribute("generalError", "Username already exists");
            hasError = true;
        }

        if(hasError){
            resp.sendRedirect(req.getContextPath() + "/index.jsp?link=dashboard&menu=users");
            return;
        }

        String hashedPassword = sha1(password);
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(role);

        boolean success = dao.insertUser(user);

        if(success){
            resp.sendRedirect(req.getContextPath() + "/index.jsp?link=dashboard&menu=users&success=added");
        } else {
            session.setAttribute("generalError", "Failed to add user");
            resp.sendRedirect(req.getContextPath() + "/index.jsp?link=dashboard&menu=users&error=failed");
        }
    }
}

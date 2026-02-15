package com.example.project.servlet;

import com.example.project.dao.UserDAO;
import com.example.project.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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

        boolean hasError = false;

        if(username==null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password==null || password.trim().isEmpty() ||
                cpsw==null || cpsw.isEmpty()){

            req.setAttribute("generalError", "All fields are required.");
            hasError = true;
        }

        if(!hasError){
            if(username.trim().length() < 3){
                req.setAttribute("unameError", "Username must be at least 3 character long.");
                hasError = true;
            }

            String emailPattern = "/^[^ ]+@[^ ]+\\.[a-z]{2,3}$/";
            if(!email.matches(emailPattern)){
                req.setAttribute("emailError", "Invalid email format.");
            }

            String passwordPattern = "/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&^#])[A-Za-z\\d@$!%*?&^#]{8,}$/";
            if(!password.matches(passwordPattern)){
                req.setAttribute("paswError", "Password need to be 8 character long and must contain capital and small letter, number and symbol.");
                hasError = true;
            }

            if(!password.equals(cpsw)){
                req.setAttribute("cpswError","Password do not match.");
            }
        }

        UserDAO dao = new UserDAO();
        if(!hasError && dao.emailExists(email)){
            req.setAttribute("generalError", "Email already exists.");
            hasError = true;
        }
        if(!hasError && dao.unameExists(username)){
            req.setAttribute("generalError", "Username already exists.");
            hasError = true;
        }
        if(hasError){
            req.getRequestDispatcher("/Smart-Inventory-Management-System/index.jsp?link=dashboard&menu=users")
                    .forward(req, resp);
            return;
        }

        String hashedPassword = sha1(password);

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(role);

        boolean success = dao.insertUser(user);

        if (success) {
            resp.sendRedirect("/Smart-Inventory-Management-System/index.jsp?link=dashboard&menu=users");
        } else {
            resp.sendRedirect("dashboard.jsp?menu=users&error=failed");
        }
    }
}

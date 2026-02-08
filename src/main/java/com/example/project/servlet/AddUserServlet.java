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
        String role = req.getParameter("role");

        String hashedPassword = sha1(password);

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(role);

        UserDAO dao = new UserDAO();
        boolean success = dao.insertUser(user);

        if (success) {
            resp.sendRedirect("/Smart-Inventory-Management-System/index.jsp?link=dashboard&menu=users");
        } else {
            resp.sendRedirect("dashboard.jsp?menu=users&error=failed");
        }
    }
}

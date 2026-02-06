package com.example.project.servlet;

import com.example.project.dao.UserDAO;
import com.example.project.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = UserDAO.getAllUsers();
        request.setAttribute("users", users);

        request.getRequestDispatcher("users.jsp").forward(request, response);
    }
}

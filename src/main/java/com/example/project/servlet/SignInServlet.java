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

@WebServlet("/sign_in")
public class SignInServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uname = req.getParameter("uname");
        String psw = req.getParameter("psw");

        User user = UserDAO.validateUser(uname, psw);
        //Comparing input data with database data
        if(user != null){
            HttpSession session = req.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("uname", user.getUsername());
            session.setAttribute("role", user.getRole());

            resp.sendRedirect("index.jsp?link=dashboard&menu=statistics");
        } else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("index.jsp?link=sign_in")
                    .forward(req, resp);
        }
    }
}

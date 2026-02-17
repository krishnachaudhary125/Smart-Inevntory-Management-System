package com.example.project.servlet;

import com.example.project.dao.CategoryDAO;
import com.example.project.model.Category;
import com.example.project.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/category")
public class CategoryListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {

            CategoryDAO dao = new CategoryDAO(conn);
            List<Category> category = dao.getAllCategory();
            req.setAttribute("category", category);

            req.getRequestDispatcher("/index.jsp?link=dashboard&menu=category").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

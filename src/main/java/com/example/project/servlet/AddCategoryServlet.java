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

@WebServlet("/addCategory")
public class AddCategoryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {

            String action = req.getParameter("action");
            CategoryDAO dao = new CategoryDAO(conn);

            if ("add".equals(action)) {

                Category c = new Category();
                c.setCategoryName(req.getParameter("categoryName"));

                dao.addCategory(c);

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));
                dao.deactivateCategory(id);
            }

            resp.sendRedirect(req.getContextPath() + "/index.jsp?link=dashboard&menu=category");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/index.jsp?link=dashboard&menu=category&error=1");
        }
    }
}

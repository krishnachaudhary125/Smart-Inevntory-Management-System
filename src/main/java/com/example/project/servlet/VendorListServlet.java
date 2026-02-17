package com.example.project.servlet;

import com.example.project.dao.VendorDAO;
import com.example.project.model.Vendor;
import com.example.project.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/vendors")
public class VendorListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {

            VendorDAO dao = new VendorDAO(conn);
            List<Vendor> vendors = dao.getAllVendors();
            req.setAttribute("vendors", vendors);

            req.getRequestDispatcher("/index.jsp?link=dashboard&menu=vendors").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

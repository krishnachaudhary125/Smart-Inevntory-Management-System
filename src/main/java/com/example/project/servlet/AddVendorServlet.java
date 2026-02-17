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

@WebServlet("/addVendor")
public class AddVendorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {

            String action = req.getParameter("action");
            VendorDAO dao = new VendorDAO(conn);

            if ("add".equals(action)) {

                Vendor v = new Vendor();
                v.setVendorName(req.getParameter("vendorName"));
                v.setVendorPhone(req.getParameter("vendorPhone"));
                v.setVendorEmail(req.getParameter("vendorEmail"));
                v.setVendorAddress(req.getParameter("vendorAddress"));

                dao.addVendor(v);

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));
                dao.deactivateVendor(id);
            }

            resp.sendRedirect(req.getContextPath() + "/index.jsp?link=dashboard&menu=vendors");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/index.jsp?link=dashboard&menu=vendors&error=1");
        }
    }
}

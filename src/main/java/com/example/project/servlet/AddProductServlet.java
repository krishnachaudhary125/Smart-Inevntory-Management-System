package com.example.project.servlet;

import com.example.project.dao.BatchDAO;
import com.example.project.dao.ProductDAO;
import com.example.project.model.Product;
import com.example.project.util.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/addProduct")
public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try(Connection conn = DBConnection.getConnection()){

            String name = req.getParameter("productName");
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            int vendorId = Integer.parseInt(req.getParameter("vendorId"));
            String batchId = req.getParameter("batchId");
            String newBatch = req.getParameter("newBatchName");

            int quantity = Integer.parseInt(req.getParameter("productQunatity"));
            double price = Double.parseDouble(req.getParameter("productPrice"));
            String expiry = req.getParameter("productExpiry");

            BatchDAO batchDAO = new BatchDAO(conn);

            int batchDefId;

            if("new".equals(batchId)){

                batchDefId = batchDAO.addBatch(newBatch);

            }else{

                batchDefId = Integer.parseInt(batchId);

            }

            Product product = new Product();

            product.setProductName(name);
            product.setCategoryId(categoryId);

            ProductDAO productDAO = new ProductDAO(conn);

            int productId = productDAO.addProduct(product);

            productDAO.addProductBatch(
                    productId,
                    batchDefId,
                    vendorId,
                    quantity,
                    price,
                    expiry
            );

            resp.sendRedirect(req.getContextPath()+"/index.jsp?link=dashboard&menu=products&success=added");

        }catch(Exception e){
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath()+"/index.jsp?link=dashboard&menu=products&error=failed");
        }
    }
}
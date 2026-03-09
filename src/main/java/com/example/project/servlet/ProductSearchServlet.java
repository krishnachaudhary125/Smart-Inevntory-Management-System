package com.example.project.servlet;

import com.example.project.dao.ProductDAO;
import com.example.project.model.ProductInventory;
import com.example.project.util.DBConnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/searchProduct")
public class ProductSearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String keyword = req.getParameter("keyword");

        resp.setContentType("application/json");

        try(Connection conn = DBConnection.getConnection()){

            ProductDAO dao = new ProductDAO(conn);

            List<ProductInventory> products = dao.searchProducts(keyword);

            StringBuilder json = new StringBuilder("[");
            boolean first = true;

            for(ProductInventory p : products){

                if(!first) json.append(",");
                first = false;

                json.append("{")
                        .append("\"id\":").append(p.getProductId()).append(",")
                        .append("\"name\":\"").append(p.getProductName()).append("\",")
                        .append("\"batch\":\"").append(p.getBatchNumber()).append("\",")
                        .append("\"price\":").append(p.getPrice())
                        .append("}");
            }

            json.append("]");

            resp.getWriter().write(json.toString());

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
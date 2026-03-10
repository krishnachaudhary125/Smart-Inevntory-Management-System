package com.example.project.servlet;

import com.example.project.dao.SaleDAO;
import com.example.project.model.Sale;
import com.example.project.util.DBConnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/sales")
public class SalesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try(Connection conn = DBConnection.getConnection()){

            SaleDAO dao = new SaleDAO(conn);

            List<Sale> sales = dao.getAllSales();

            req.setAttribute("sales", sales);

            req.getRequestDispatcher("/sales.jsp").forward(req, resp);

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
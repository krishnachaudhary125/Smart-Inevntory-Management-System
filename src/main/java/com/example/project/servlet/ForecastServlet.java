package com.example.project.servlet;

import com.example.project.dao.ProductDAO;
import com.example.project.dao.SaleDAO;
import com.example.project.model.Product;
import com.example.project.util.DBConnection;
import com.example.project.util.ExponentialSmoothing;
import com.example.project.util.RecommendationEngine;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/forecast")
public class ForecastServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try(Connection conn = DBConnection.getConnection()){

            ProductDAO productDAO = new ProductDAO(conn);
            SaleDAO saleDAO = new SaleDAO(conn);

            List<Product> products = productDAO.getAllProducts();

            /* APRIORI TRANSACTIONS */
            List<List<String>> transactions = saleDAO.getTransactions();

            Map<String,String> recommendations =
                    RecommendationEngine.recommend(transactions);

            /* FORECAST RESULT LIST */
            List<Map<String,Object>> forecastList = new ArrayList<>();

            for(Product p : products){

                int productId = p.getProductId();
                String productName = p.getProductName();

                /* SALES HISTORY */
                List<Integer> salesHistory =
                        productDAO.getProductSalesHistory(productId);

                /* FORECAST DEMAND */
                double forecast =
                        ExponentialSmoothing.forecast(salesHistory,0.3);

                /* CURRENT STOCK */
                int stock = productDAO.getCurrentStock(productId);

                /* RESTOCK CALCULATION */
                int restock = (int)Math.max(0, forecast - stock);

                /* COMPLEMENTARY PRODUCT */
                String complementary =
                        recommendations.get(productName);

                Map<String,Object> map = new HashMap<>();

                map.put("product", productName);
                map.put("forecast", (int)Math.round(forecast));
                map.put("stock", stock);
                map.put("restock", restock);
                map.put("complement", complementary);

                forecastList.add(map);
            }

            req.setAttribute("forecastList", forecastList);

            req.getRequestDispatcher(
                    "/index.jsp?link=dashboard&menu=forecast"
            ).forward(req,resp);

        }catch(Exception e){

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath() +
                            "/index.jsp?link=dashboard&menu=statistics"
            );
        }
    }
}
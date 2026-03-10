package com.example.project.servlet;

import com.example.project.dao.SaleDAO;
import com.example.project.util.DBConnection;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/completeSale")
public class CompleteSaleServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Gson gson = new Gson();

        JsonObject data = gson.fromJson(req.getReader(), JsonObject.class);

        JsonArray items = data.getAsJsonArray("items");

        double total = data.get("total").getAsDouble();

        int usedPoints = data.has("usedPoints") ? data.get("usedPoints").getAsInt() : 0;

        String customerType = data.get("customerType").getAsString();

        String phone = data.has("phone") ? data.get("phone").getAsString() : "Guest";

        if(phone == null || phone.trim().isEmpty()){
            phone = "Guest";
        }

        try(Connection conn = DBConnection.getConnection()){

            conn.setAutoCommit(false);

            SaleDAO saleDAO = new SaleDAO(conn);

            int saleId = saleDAO.createSale(total, usedPoints, phone);

            for(JsonElement e : items){

                JsonObject obj = e.getAsJsonObject();

                int batchId = obj.get("batchId").getAsInt();
                int qty = obj.get("quantity").getAsInt();
                double price = obj.get("price").getAsDouble();

                saleDAO.addSaleItem(saleId, batchId, qty, price);

                saleDAO.reduceStock(batchId, qty);
            }

            if("member".equals(customerType) && phone != null && !phone.isEmpty()){

                int earnedPoints = (int)(total / 100);

                saleDAO.updateMemberPoints(phone, usedPoints, earnedPoints);
            }

            conn.commit();

            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"success\"}");

        }catch(Exception e){

            e.printStackTrace();

            resp.setStatus(500);

            resp.getWriter().write("{\"status\":\"error\"}");
        }
    }
}
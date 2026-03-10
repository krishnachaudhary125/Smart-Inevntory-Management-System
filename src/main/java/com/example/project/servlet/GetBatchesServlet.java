package com.example.project.servlet;

import com.example.project.dao.BatchDAO;
import com.example.project.model.Batch;
import com.example.project.util.DBConnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/getBatches")
public class GetBatchesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int productId = Integer.parseInt(req.getParameter("productId"));

        resp.setContentType("application/json");

        try(Connection conn = DBConnection.getConnection()){

            BatchDAO dao = new BatchDAO(conn);

            List<Batch> batches = dao.getBatchesByProduct(productId);

            StringBuilder json = new StringBuilder("[");
            boolean first = true;

            for(Batch b : batches){

                if(!first) json.append(",");
                first = false;

                json.append("{")
                        .append("\"batchId\":").append(b.getBatchId()).append(",")
                        .append("\"batch\":\"").append(b.getBatchNumber()).append("\",")
                        .append("\"price\":").append(b.getPrice()).append(",")
                        .append("\"qty\":").append(b.getQuantity())
                        .append("}");
            }

            json.append("]");

            resp.getWriter().write(json.toString());

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
package com.example.project.dao;

import com.example.project.model.Sale;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SaleDAO {

    private Connection conn;

    public SaleDAO(Connection conn){
        this.conn = conn;
    }

    public int createSale(double total, int usedPoints, String phone) throws SQLException{

        String sql = "INSERT INTO sales(member_phone,total_amount,used_points) VALUES(?,?,?)";

        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setString(1, phone);
        ps.setDouble(2, total);
        ps.setInt(3, usedPoints);

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();

        if(rs.next()){
            return rs.getInt(1);
        }

        return 0;
    }


    public void addSaleItem(int saleId, int batchId, int qty, double price) throws SQLException{

        String sql = "INSERT INTO sale_items(sale_id,batch_id,quantity,price) VALUES(?,?,?,?)";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, saleId);
        ps.setInt(2, batchId);
        ps.setInt(3, qty);
        ps.setDouble(4, price);

        ps.executeUpdate();
    }


    public void reduceStock(int batchId, int qty) throws SQLException{

        String sql = "UPDATE product_batches SET quantity = quantity - ? WHERE batch_id = ? AND quantity >= ?";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, qty);
        ps.setInt(2, batchId);
        ps.setInt(3, qty);

        ps.executeUpdate();
    }


    public void updateMemberPoints(String phone, int usedPoints, int earnedPoints) throws SQLException {

        String sql = "UPDATE members SET points = points - ? + ? WHERE phone = ?";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, usedPoints);
        ps.setInt(2, earnedPoints);
        ps.setString(3, phone);

        ps.executeUpdate();
    }

    public List<Sale> getAllSales() throws SQLException {

        List<Sale> list = new ArrayList<>();

        String sql = "SELECT * FROM sales ORDER BY sale_id DESC";

        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){

            Sale s = new Sale();

            s.setSaleId(rs.getInt("sale_id"));
            s.setMemberPhone(rs.getString("member_phone"));
            s.setTotalAmount(rs.getDouble("total_amount"));
            s.setUsedPoints(rs.getInt("used_points"));
            s.setSaleDate(rs.getTimestamp("sale_date"));

            list.add(s);
        }

        return list;
    }

    public List<String> getProductsBySale(int saleId) throws SQLException {

        List<String> products = new ArrayList<>();

        String sql =
                "SELECT p.product_name " +
                        "FROM sale_items si " +
                        "JOIN product_batches pb ON si.batch_id = pb.batch_id " +
                        "JOIN products p ON pb.product_id = p.product_id " +
                        "WHERE si.sale_id = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, saleId);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            products.add(rs.getString("product_name"));
        }

        return products;
    }
}
package com.example.project.dao;

import java.sql.*;

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
}
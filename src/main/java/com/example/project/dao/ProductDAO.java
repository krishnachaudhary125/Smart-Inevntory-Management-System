package com.example.project.dao;

import com.example.project.model.Product;
import com.example.project.model.ProductInventory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Connection conn;

    public ProductDAO(Connection conn){
        this.conn = conn;
    }

    public int addProduct(Product product) throws SQLException {

        String sql = "INSERT INTO products(product_name,category_id) VALUES(?,?)";

        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setString(1, product.getProductName());
        ps.setInt(2, product.getCategoryId());

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();

        if(rs.next()){
            return rs.getInt(1);
        }

        return 0;
    }

    public void addProductBatch(
            int productId,
            int batchDefId,
            int vendorId,
            int quantity,
            double price,
            String expiryDate
    ) throws SQLException{

        String sql = "INSERT INTO product_batches(product_id,batch_def_id,vendor_id,quantity,unit_price,expiry_date) VALUES(?,?,?,?,?,?)";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, productId);
        ps.setInt(2, batchDefId);
        ps.setInt(3, vendorId);
        ps.setInt(4, quantity);
        ps.setDouble(5, price);
        ps.setString(6, expiryDate);

        ps.executeUpdate();
    }

    public List<ProductInventory> getInventory() throws SQLException {

        List<ProductInventory> list = new ArrayList<>();

        String sql =
                "SELECT " +
                        "p.product_name, " +
                        "c.category_name, " +
                        "b.batch_number, " +
                        "v.vendor_name, " +
                        "pb.quantity, " +
                        "pb.unit_price, " +
                        "pb.expiry_date " +
                        "FROM product_batches pb " +
                        "JOIN products p ON pb.product_id = p.product_id " +
                        "JOIN categories c ON p.category_id = c.category_id " +
                        "JOIN batch_definitions b ON pb.batch_def_id = b.batch_def_id " +
                        "JOIN vendors v ON pb.vendor_id = v.vendor_id " +
                        "WHERE pb.is_active = TRUE";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){

            ProductInventory p = new ProductInventory();

            p.setProductName(rs.getString("product_name"));
            p.setCategoryName(rs.getString("category_name"));
            p.setBatchNumber(rs.getString("batch_number"));
            p.setVendorName(rs.getString("vendor_name"));
            p.setQuantity(rs.getInt("quantity"));
            p.setPrice(rs.getDouble("unit_price"));
            p.setExpiryDate(rs.getDate("expiry_date"));

            list.add(p);
        }

        return list;
    }
}
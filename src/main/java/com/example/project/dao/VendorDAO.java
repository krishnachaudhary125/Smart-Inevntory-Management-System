package com.example.project.dao;

import com.example.project.model.Vendor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VendorDAO {
    private Connection conn;
    public VendorDAO(Connection conn){
        this.conn = conn;
    }

    public boolean addVendor(Vendor vendor) throws SQLException {
        String sql = "INSERT INTO vendors (vendor_name, phone, email, address) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, vendor.getVendorName());
        ps.setString(2, vendor.getVendorPhone());
        ps.setString(3, vendor.getVendorEmail());
        ps.setString(4, vendor.getVendorAddress());
        return ps.executeUpdate() > 0;
    }

    public List<Vendor> getAllVendors() throws SQLException {
        List<Vendor> list = new ArrayList<>();
        String sql = "SELECT * FROM vendors WHERE is_active = TRUE ORDER BY created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Vendor v = new Vendor();
            v.setVendorId(rs.getInt("vendor_id"));
            v.setVendorName(rs.getString("vendor_name"));
            v.setVendorPhone(rs.getString("phone"));
            v.setVendorEmail(rs.getString("email"));
            v.setVendorAddress(rs.getString("address"));
            v.setActive(rs.getBoolean("is_active"));
            list.add(v);
        }
        return list;
    }

    public boolean deactivateVendor(int id) throws SQLException {
        String sql = "UPDATE vendors SET is_active = FALSE WHERE vendor_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }
}

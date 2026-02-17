package com.example.project.dao;

import com.example.project.model.Category;
import com.example.project.model.Vendor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    private Connection conn;

    public CategoryDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO categories (category_name) VALUES (?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, category.getCategoryName());
        return ps.executeUpdate() > 0;
    }

    public List<Category> getAllCategory() throws SQLException {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories WHERE is_active = TRUE";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Category c = new Category();
            c.setCategoryId(rs.getInt("category_id"));
            c.setCategoryName(rs.getString("category_name"));
            c.setActive(rs.getBoolean("is_active"));
            list.add(c);
        }
        return list;
    }

    public boolean deactivateCategory(int id) throws SQLException {
        String sql = "UPDATE categories SET is_active = FALSE WHERE category_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }
}

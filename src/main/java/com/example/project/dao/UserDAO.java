package com.example.project.dao;

import com.example.project.model.User;
import com.example.project.util.DBConnection;
import com.example.project.util.PasswordHashing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public static User validateUser(String uname, String psw) {

        User user = null;
        String hashedPassword = PasswordHashing.sha1(psw);

        String sql = "SELECT user_id, username, role FROM users WHERE (username=? OR email=?) AND password=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, uname);
            ps.setString(2, uname);
            ps.setString(3, hashedPassword);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("role")
                );
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return user;
    }
}
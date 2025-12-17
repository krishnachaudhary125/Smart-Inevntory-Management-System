package com.example.project.dao;

import com.example.project.model.User;
import com.example.project.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.example.project.util.PasswordHashing;

public class UserDAO {
    public static User validateUser(String uname, String psw){

        User user = null;
        String hashedPassword = PasswordHashing.sha1(psw);

        try(Connection conn = DBConnection.getConnection()){

            String sqlAdmin = "SELECT admin_id, username, role FROM admin WHERE (username=? OR email=?) AND password=?";
            PreparedStatement psAdmin = conn.prepareStatement(sqlAdmin);
            psAdmin.setString(1, uname);
            psAdmin.setString(2, uname);
            psAdmin.setString(3, hashedPassword);

            ResultSet rs = psAdmin.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("admin_id"),
                        rs.getString("username"),
                        rs.getString("role")
                );
            }

            String sqlStaff = "SELECT staff_id, username, role FROM staff WHERE (username=? OR email=?) AND password=?";
            PreparedStatement psStaff = conn.prepareStatement(sqlStaff);
            psStaff.setString(1, uname);
            psStaff.setString(2, uname);
            psStaff.setString(3, hashedPassword);

            rs = psStaff.executeQuery();
            if(rs.next()){
                user = new User(
                        rs.getInt("staff_id"),
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

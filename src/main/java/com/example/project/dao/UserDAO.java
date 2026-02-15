package com.example.project.dao;

import com.example.project.model.User;
import com.example.project.util.DBConnection;
import com.example.project.util.PasswordHashing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public static User validateUser(String uname, String psw) {

        User user = null;
        String hashedPassword = PasswordHashing.sha1(psw);

        String sql = "SELECT user_id, username, email, role FROM users WHERE (username=? OR email=?) AND password=?";

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
                        rs.getString("email"),
                        rs.getString("role")
                );
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return user;
    }

    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        String sql = "SELECT user_id, username, email, role FROM users";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("role")
                );
                users.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public boolean insertUser(User user) {
        String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean emailExists(String email){
        boolean exists = false;
        String sql = "SELECT 1 FROM users WHERE email = ?";

        try(Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
        }catch (Exception e){
            e.printStackTrace();
        }
        return exists;
    }

    public boolean unameExists(String username){
        boolean exists = false;
        String sql = "SELECT 1 FROM users WHERE username = ?";

        try(Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
        }catch (Exception e){
            e.printStackTrace();
        }
        return exists;
    }
}
package com.example.project.dao;

import com.example.project.model.Member;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

    private Connection conn;

    public MemberDAO(Connection conn){
        this.conn = conn;
    }

    public boolean addMember(Member m) throws SQLException {

        String sql =
                "INSERT INTO members(member_name, phone) VALUES (?,?)";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1,m.getMemberName());
        ps.setString(2,m.getPhone());

        return ps.executeUpdate() > 0;
    }

    public List<Member> getAllMembers() throws SQLException {

        List<Member> list = new ArrayList<>();

        String sql = "SELECT * FROM members";

        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){

            Member m = new Member();

            m.setMemberId(rs.getInt("member_id"));
            m.setMemberName(rs.getString("member_name"));
            m.setPhone(rs.getString("phone"));
            m.setPoints(rs.getInt("points"));

            list.add(m);

        }

        return list;
    }

    public boolean phoneExists(String phone) {

        boolean exists = false;

        String sql = "SELECT 1 FROM members WHERE phone = ?";

        try(PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setString(1, phone);

            ResultSet rs = ps.executeQuery();

            exists = rs.next();

        }catch(Exception e){
            e.printStackTrace();
        }

        return exists;
    }
}
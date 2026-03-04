package com.example.project.dao;

import com.example.project.model.Batch;
import java.sql.*;
import java.util.*;

public class BatchDAO {

    private Connection conn;

    public BatchDAO(Connection conn){
        this.conn = conn;
    }

    public List<Batch> getAllBatches() throws SQLException {

        List<Batch> list = new ArrayList<>();

        String sql = "SELECT * FROM batch_definitions";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){

            Batch b = new Batch();

            b.setBatchDefId(rs.getInt("batch_def_id"));
            b.setBatchNumber(rs.getString("batch_number"));

            list.add(b);
        }

        return list;
    }

    public int addBatch(String batchNumber) throws SQLException {

        String sql = "INSERT INTO batch_definitions(batch_number) VALUES(?)";

        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setString(1, batchNumber);

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();

        if(rs.next()){
            return rs.getInt(1);
        }

        return 0;
    }
}
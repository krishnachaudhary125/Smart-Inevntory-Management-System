package com.example.project.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String url = "jdbc:mysql://localhost:3306/smart_inventory_management_system";
    private static final String user = "root";
    private static final String psw = "";

    public static Connection getConnection() throws Exception{
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, psw);
    }
}

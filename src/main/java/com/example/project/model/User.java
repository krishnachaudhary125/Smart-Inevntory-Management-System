package com.example.project.model;

public class User {
    private int id;
    private String uname;
    private String role;

    public User(int id, String uname, String role){
        this.id = id;
        this.uname = uname;
        this.role = role;
    }

    public int getId() {
        return id;
    }

    public String getUname() {
        return uname;
    }

    public String getRole() {
        return role;
    }
}

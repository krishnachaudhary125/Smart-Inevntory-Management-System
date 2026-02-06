package com.example.project.model;

public class User {
    private int userId;
    private String uname;
    private String email;
    private String role;

    public User(int userId, String uname, String email, String role) {
        this.userId = userId;
        this.uname = uname;
        this.email = email;
        this.role = role;
    }

    public int getUserId() { return userId; }
    public String getUsername() { return uname; }
    public String getEmail() { return email; }
    public String getRole() { return role; }
}

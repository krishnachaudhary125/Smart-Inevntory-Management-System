package com.example.project.model;

public class User {
    private int userId;
    private String uname;
    private String email;
    private String password;
    private String role;

    public User(){}

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
    public String getPassword(){ return password; }

    public void setUsername(String uname) {
        this.uname = uname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }
}

package com.example.project.model;

public class Batch {

    private int batchId;
    private int batchDefId;
    private String batchNumber;
    private double price;
    private int quantity;

    public int getBatchId() {
        return batchId;
    }

    public void setBatchId(int batchId) {
        this.batchId = batchId;
    }

    public int getBatchDefId() {
        return batchDefId;
    }

    public void setBatchDefId(int batchDefId) {
        this.batchDefId = batchDefId;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
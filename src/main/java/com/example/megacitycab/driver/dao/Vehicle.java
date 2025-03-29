package com.example.megacitycab.driver.dao;


public class Vehicle {
    private int vehicleId;
    private String vehicleType;
    private String model;
    private String color;
    private String cc;
    private String numberPlate;
    private String image;

    public Vehicle(int vehicleId, String vehicleType, String model, String color, String cc, String numberPlate, String image) {
        this.vehicleId = vehicleId;
        this.vehicleType = vehicleType;
        this.model = model;
        this.color = color;
        this.cc = cc;
        this.numberPlate = numberPlate;
        this.image = image;
    }

    // Getters and Setters
    public int getVehicleId() { return vehicleId; }
    public String getVehicleType() { return vehicleType; }
    public String getModel() { return model; }
    public String getColor() { return color; }
    public String getCc() { return cc; }
    public String getNumberPlate() { return numberPlate; }
    public String getImage() { return image; }
}

package com.example.megacitycab.admin_page.model;

public class Vehicle {
    private String vehicleType;
    private String image;
    private String model;
    private String color;
    private String cc;
    private String numberPlate;
//    private String driverName;
//    private String driverMobile;

    // Constructor
    public Vehicle(String vehicleType, String image, String model, String color, String cc,
                   String numberPlate) {
        this.vehicleType = vehicleType;
        this.image = image;
        this.model = model;
        this.color = color;
        this.cc = cc;
        this.numberPlate = numberPlate;
//        this.driverName = driverName;
//        this.driverMobile = driverMobile;

    }

    // Getters and Setters for all fields
    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getCc() {
        return cc;
    }

    public void setCc(String cc) {
        this.cc = cc;
    }

    public String getNumberPlate() {
        return numberPlate;
    }

    public void setNumberPlate(String numberPlate) {
        this.numberPlate = numberPlate;
    }

//    public String getDriverName() {
//        return driverName;
//    }
//
//    public void setDriverName(String driverName) {
//        this.driverName = driverName;
//    }
//
//    public String getDriverMobile() {
//        return driverMobile;
//    }
//
//    public void setDriverMobile(String driverMobile) {
//        this.driverMobile = driverMobile;
//    }
}

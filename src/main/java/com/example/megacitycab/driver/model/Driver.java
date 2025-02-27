package com.example.megacitycab.driver.model;

public class Driver {

    private int id; // Added ID field
    private String username;
    private String password;
    private String email;
    private String contactNumber;
    private String address;
    private int age;
    private int experience;
    private boolean carLicense;
    private boolean autoLicense;
    private boolean bikeLicense;

    // Getters and Setters for each field

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public boolean isCarLicense() {
        return carLicense;
    }

    public void setCarLicense(boolean carLicense) {
        this.carLicense = carLicense;
    }

    public boolean isAutoLicense() {
        return autoLicense;
    }

    public void setAutoLicense(boolean autoLicense) {
        this.autoLicense = autoLicense;
    }

    public boolean isBikeLicense() {
        return bikeLicense;
    }

    public void setBikeLicense(boolean bikeLicense) {
        this.bikeLicense = bikeLicense;
    }


}

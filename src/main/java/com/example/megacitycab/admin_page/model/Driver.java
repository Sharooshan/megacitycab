package com.example.megacitycab.admin_page.model;

import java.io.InputStream;

public class Driver {

    private String username;
    private String password;
    private String email;
    private String contactNumber;
    private InputStream licenceProof;
    private InputStream nicProof;
    private boolean carLicense;
    private boolean autoLicense;
    private boolean bikeLicense;
    private String address;
    private int age;
    private int experience;

    // Constructor
    public Driver(String username, String password, String email, String contactNumber,
                  InputStream licenceProof, InputStream nicProof, boolean carLicense,
                  boolean autoLicense, boolean bikeLicense, String address, int age, int experience) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.contactNumber = contactNumber;
        this.licenceProof = licenceProof;
        this.nicProof = nicProof;
        this.carLicense = carLicense;
        this.autoLicense = autoLicense;
        this.bikeLicense = bikeLicense;
        this.address = address;
        this.age = age;
        this.experience = experience;
    }

    // Getters and setters for all fields
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

    public InputStream getLicenceProof() {
        return licenceProof;
    }

    public void setLicenceProof(InputStream licenceProof) {
        this.licenceProof = licenceProof;
    }

    public InputStream getNicProof() {
        return nicProof;
    }

    public void setNicProof(InputStream nicProof) {
        this.nicProof = nicProof;
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
}

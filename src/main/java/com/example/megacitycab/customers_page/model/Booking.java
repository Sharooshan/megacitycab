package com.example.megacitycab.customers_page.model;


public class Booking {
    private int vehicleId;
    private int customerId;
    private String tripStartDate;
    private String tripEndDate;
    private String tripTime;
    private String pickupLocation;
    private String dropLocation;
    private int passengerCount;
    private String paymentMethod;
    private double totalPrice;
    private double discountAmount;
    private String driverName;
    private String driverMobile;

    // Constructors
    public Booking() {
    }

    public Booking(int vehicleId, int customerId, String tripStartDate, String tripEndDate,
                   String tripTime, String pickupLocation, String dropLocation,
                   int passengerCount, String paymentMethod, double totalPrice,
                   double discountAmount, String driverName, String driverMobile) {
        this.vehicleId = vehicleId;
        this.customerId = customerId;
        this.tripStartDate = tripStartDate;
        this.tripEndDate = tripEndDate;
        this.tripTime = tripTime;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.passengerCount = passengerCount;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.discountAmount = discountAmount;
        this.driverName = driverName;
        this.driverMobile = driverMobile;
    }

    // Getters and Setters
    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getTripStartDate() {
        return tripStartDate;
    }

    public void setTripStartDate(String tripStartDate) {
        this.tripStartDate = tripStartDate;
    }

    public String getTripEndDate() {
        return tripEndDate;
    }

    public void setTripEndDate(String tripEndDate) {
        this.tripEndDate = tripEndDate;
    }

    public String getTripTime() {
        return tripTime;
    }

    public void setTripTime(String tripTime) {
        this.tripTime = tripTime;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropLocation() {
        return dropLocation;
    }

    public void setDropLocation(String dropLocation) {
        this.dropLocation = dropLocation;
    }

    public int getPassengerCount() {
        return passengerCount;
    }

    public void setPassengerCount(int passengerCount) {
        this.passengerCount = passengerCount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getDriverMobile() {
        return driverMobile;
    }

    public void setDriverMobile(String driverMobile) {
        this.driverMobile = driverMobile;
    }
}

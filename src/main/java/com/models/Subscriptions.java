package com.models;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Subscriptions extends User {
    private int sid;
    private int uid;
    private String customerName;
    private String email;
    private String phno;
    private String address;
    private String publicationName;
    private double amount;
    private String paymentType;
    private LocalDate startDate;  // Change to LocalDate
    private String paymentStatus;
    private String subscriptionStatus;
    private int daysCount;
    private String landMark;

    // Getters and Setters

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getPublicationName() {
        return publicationName;
    }

    public void setPublicationName(String publicationName) {
        this.publicationName = publicationName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public LocalDate getStartDate() {  // Update the getter
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {  // Update the setter
        this.startDate = startDate;
    }

    // Additional methods for handling LocalDate
    public void setStartDate(String startDateString) {  // Overloaded setter to handle String input
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");  // Define the expected format
        this.startDate = LocalDate.parse(startDateString, formatter);  // Parse the string to LocalDate
    }

    public String getStartDateString() {  // Convert LocalDate back to String for display
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");  // Define the format
        return startDate.format(formatter);  // Return formatted date as string
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getSubscriptionStatus() {
        return subscriptionStatus;
    }

    public void setSubscriptionStatus(String subscriptionStatus) {
        this.subscriptionStatus = subscriptionStatus;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhno() {
        return phno;
    }

    public void setPhno(String phno) {
        this.phno = phno;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getDaysCount() {
        return daysCount;
    }

    public void setDaysCount(int daysCount) {
        this.daysCount = daysCount;
    }
    

    public String getLandMark() {
		return landMark;
	}

	public void setLandMark(String landMark) {
		this.landMark = landMark;
	}

	@Override
    public String toString() {
        return "Subscriptions [sid=" + sid + ", uid=" + uid + ", customerName=" + customerName + ", email=" + email
                + ", phno=" + phno + ", address=" + address + ", publicationName=" + publicationName + ", amount="
                + amount + ", paymentType=" + paymentType + ", startDate=" + startDate + ", paymentStatus="
                + paymentStatus + ", subscriptionStatus=" + subscriptionStatus + ", daysCount=" + daysCount + "]";
    }
}

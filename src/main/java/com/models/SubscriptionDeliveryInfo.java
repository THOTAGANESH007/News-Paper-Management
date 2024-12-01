package com.models;

public class SubscriptionDeliveryInfo {
	private int sid;
	private int uid;
	private String customerName;
	private String email;
	private String subscriptionStatus;
	private int did;
	private String deliveryAgentName;
	private String deliveryAgentPhno;
	private String areaAssigned;
	private String address;
	private String publicationName;
	private String paymentType;

	// Getters and Setters
	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
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

	public String getSubscriptionStatus() {
		return subscriptionStatus;
	}

	public void setSubscriptionStatus(String subscriptionStatus) {
		this.subscriptionStatus = subscriptionStatus;
	}

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public String getDeliveryAgentName() {
		return deliveryAgentName;
	}

	public void setDeliveryAgentName(String deliveryAgentName) {
		this.deliveryAgentName = deliveryAgentName;
	}

	public String getDeliveryAgentPhno() {
		return deliveryAgentPhno;
	}

	public void setDeliveryAgentPhno(String deliveryAgentPhno) {
		this.deliveryAgentPhno = deliveryAgentPhno;
	}

	public String getAreaAssigned() {
		return areaAssigned;
	}

	public void setAreaAssigned(String areaAssigned) {
		this.areaAssigned = areaAssigned;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPublicationName() {
		return publicationName;
	}

	public void setPublicationName(String publicationName) {
		this.publicationName = publicationName;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

}

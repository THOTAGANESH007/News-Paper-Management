package com.models;

public class DeliveryAgent {
	private int did;
	private String email;
	private String password;
	private String address;
	private double salary;
	private String areaAssigned;
	private String name;
	private String phno;

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public double getSalary() {
		return salary;
	}

	public void setSalary(double salary) {
		this.salary = salary;
	}

	public String getAreaAssigned() {
		return areaAssigned;
	}

	public void setAreaAssigned(String areaAssigned) {
		this.areaAssigned = areaAssigned;
	}
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhno() {
		return phno;
	}

	public void setPhno(String phno) {
		this.phno = phno;
	}

	@Override
	public String toString() {
		return "DeliveryAgent [did=" + did + ", email=" + email + ", password=" + password + ", address=" + address
				+ ", salary=" + salary + ", areaAssigned=" + areaAssigned + "]";
	}

}

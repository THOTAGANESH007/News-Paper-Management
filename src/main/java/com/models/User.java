package com.models;

public class User {

	private int id;
	private String name;
	private String email;
	private String password;
	private String phno;
	private String address;
	private String category;

	
	
	public User() {
		super();
	}

	public User(String name, String email, String password, String phno, String category) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.phno = phno;
		this.category = category;
	}

	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", phno=" + phno
				+ ", address=" + address + ", category=" + category + "]";
	}

}

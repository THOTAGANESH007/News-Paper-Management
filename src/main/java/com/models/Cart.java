package com.models;

public class Cart {
	private int cid;
	private int pid;
	private int uid;
	private String PublicationName;
	private String author;
	private double price;
	private double totalPrice;

	public Cart() {
		super();
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	

	public String getPublicationName() {
		return PublicationName;
	}

	public void setPublicationName(String publicationName) {
		PublicationName = publicationName;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "Cart [cid=" + cid + ", pid=" + pid + ", uid=" + uid + ", PublicationName=" + PublicationName
				+ ", author=" + author + ", price=" + price + ", totalPrice=" + totalPrice + "]";
	}
	

}

package com.models;

public class Publications {
	private int pid;
	private String publicationName;
	private String author;
	private String publicationType;
	private double price;
	private String publicationStatus;
	private String photo;
	private String summary;

	
	public Publications() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Publications(String publicationName, String author, String publicationType, double price,
			String publicationStatus, String photo, String summary) {
		super();
		this.publicationName = publicationName;
		this.author = author;
		this.publicationType = publicationType;
		this.price = price;
		this.publicationStatus = publicationStatus;
		this.photo = photo;
		this.summary = summary;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getPublicationName() {
		return publicationName;
	}

	public void setPublicationName(String publicationName) {
		this.publicationName = publicationName;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublicationType() {
		return publicationType;
	}

	public void setPublicationType(String publicationType) {
		this.publicationType = publicationType;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getPublicationStatus() {
		return publicationStatus;
	}

	public void setPublicationStatus(String publicationStatus) {
		this.publicationStatus = publicationStatus;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	@Override
	public String toString() {
		return "Publications [pid=" + pid + ", publicationName=" + publicationName + ", author=" + author
				+ ", publicationType=" + publicationType + ", price=" + price + ", publicationStatus="
				+ publicationStatus + ", photo=" + photo + ", summary=" + summary + "]";
	}

}

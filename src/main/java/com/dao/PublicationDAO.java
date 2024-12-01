package com.dao;

import java.util.List;

import com.models.Publications;

import com.models.Subscriptions;

public interface PublicationDAO {

	public boolean addPublications(Publications details);

	public List<Subscriptions> allSubscriptions();

	public List<Subscriptions> getSubscriptionsByUid(int uid);

	public boolean updatePaymentStatus(int uid, int sid);

	public List<Publications> getAllNewsPapers();

	public List<Publications> getAllMagazines();

	public List<Publications> getRecentNewsPapers();

	public List<Publications> getRecentMagazines();

	public Publications getPublicationById(int id);

	public boolean saveOrder(List<Subscriptions> blist);

	public boolean updateAddress(String fullAddress, String email);

	public List<Subscriptions> getSubscriptionById_Receipt(int uid);

	public boolean updateSubscriptionStatus(int sid, String status);

	public void increaseNotificationCount(int userId);

	public int getNotificationCount(int userId);

	public String getNotificationText(int userId);

	public List<Publications> searchPublicationsByQuery(String searchQuery);

	public boolean DeletePublication(int pid, String publicationName, String publicationType);
}

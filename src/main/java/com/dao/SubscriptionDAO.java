package com.dao;

import java.util.List;

import com.models.SubscriptionDeliveryInfo;

public interface SubscriptionDAO {

	public List<SubscriptionDeliveryInfo> getAssignedSubscriptions();

	public List<SubscriptionDeliveryInfo> getSubscriptionsForDeliveryAgent(String email);

}

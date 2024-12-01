package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.models.SubscriptionDeliveryInfo;

public class SubscriptionDAOImpl implements SubscriptionDAO {
	private Connection connection;

	public SubscriptionDAOImpl(Connection connection) {
		this.connection = connection;
	}

	@Override
	public List<SubscriptionDeliveryInfo> getAssignedSubscriptions() {
		String query = "SELECT s.sid, s.uid, s.customerName, s.email, s.subscriptionStatus, da.did, "
				+ "da.name AS deliveryAgentName, da.phno AS deliveryAgentPhno, da.areaAssigned, "
				+ "s.publicationName, s.address, s.paymentType " + "FROM subscriptions s "
				+ "JOIN deliveryAgent da ON s.landMark = da.areaAssigned";

		List<SubscriptionDeliveryInfo> subscriptions = new ArrayList<>();
		try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				SubscriptionDeliveryInfo info = new SubscriptionDeliveryInfo();
				info.setSid(rs.getInt("sid"));
				info.setUid(rs.getInt("uid"));
				info.setCustomerName(rs.getString("customerName"));
				info.setEmail(rs.getString("email"));
				info.setSubscriptionStatus(rs.getString("subscriptionStatus"));
				info.setDid(rs.getInt("did"));
				info.setDeliveryAgentName(rs.getString("deliveryAgentName"));
				info.setDeliveryAgentPhno(rs.getString("deliveryAgentPhno"));
				info.setAreaAssigned(rs.getString("areaAssigned"));
				info.setAddress(rs.getString("address"));
				info.setPublicationName(rs.getString("publicationName"));
				info.setPaymentType(rs.getString("paymentType"));
				subscriptions.add(info);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return subscriptions;
	}

	@Override
	public List<SubscriptionDeliveryInfo> getSubscriptionsForDeliveryAgent(String email) {
		String query = "SELECT s.sid, s.uid, s.customerName, s.email, s.subscriptionStatus, da.did, "
				+ "da.name AS deliveryAgentName, da.phno AS deliveryAgentPhno, da.areaAssigned, "
				+ "s.publicationName, s.address, s.paymentType " + "FROM subscriptions s "
				+ "JOIN deliveryAgent da ON s.landMark = da.areaAssigned "
				+ "WHERE s.subscriptionStatus = 'Active' AND da.email = ?";

		List<SubscriptionDeliveryInfo> subscriptions = new ArrayList<>();
		try (PreparedStatement stmt = connection.prepareStatement(query)) {
			stmt.setString(1, email);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				SubscriptionDeliveryInfo info = new SubscriptionDeliveryInfo();
				info.setSid(rs.getInt("sid"));
				info.setUid(rs.getInt("uid"));
				info.setCustomerName(rs.getString("customerName"));
				info.setEmail(rs.getString("email"));
				info.setSubscriptionStatus(rs.getString("subscriptionStatus"));
				info.setDid(rs.getInt("did"));
				info.setDeliveryAgentName(rs.getString("deliveryAgentName"));
				info.setDeliveryAgentPhno(rs.getString("deliveryAgentPhno"));
				info.setAreaAssigned(rs.getString("areaAssigned"));
				info.setAddress(rs.getString("address"));
				info.setPublicationName(rs.getString("publicationName"));
				info.setPaymentType(rs.getString("paymentType"));

				subscriptions.add(info);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return subscriptions;
	}
}

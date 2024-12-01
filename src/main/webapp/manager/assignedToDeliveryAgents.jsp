<%@page import="com.models.SubscriptionDeliveryInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.SubscriptionDAOImpl"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Assigned Subscriptions</title>
<%@include file="cdns.jsp"%>
</head>
<body>
<%@include file="navbar.jsp"%>
	<div class="container-fluid mt-5">
		<h1 class="text text-center text-danger">Assigned Subscriptions</h1>
		<table class="table table-hover mt-3 text-center">
			<thead class="bg-primary text-white">
				<tr>
					<th>Subscription ID</th>
					<th>Customer ID</th>
					<th>Customer Name</th>
					<th>Customer Email</th>
					<th>Publication Name</th>
					<th>Delivery Agent Name</th>
					<th>Delivery Agent Phone</th>
					<th>Area Assigned</th>
					<th>Customer Address</th>
					<th>Subscription Status</th>
					<th>Payment Type</th>
				</tr>
			</thead>
			<tbody>
				<%
				SubscriptionDAOImpl dao = new SubscriptionDAOImpl(DBConnect.getConn());
				List<SubscriptionDeliveryInfo> subscriptions = dao.getAssignedSubscriptions();
				for (SubscriptionDeliveryInfo subscription : subscriptions) {
				%>
				<tr>
					<td><strong>SUB-ID-00-<%=subscription.getSid()%></strong></td>
					<td><strong>USR-ID-00-<%=subscription.getUid()%></strong></td>
					<td><%=subscription.getCustomerName()%></td>
					<td><%=subscription.getEmail()%></td>
					<td><%=subscription.getPublicationName()%></td>        
					<td><%=subscription.getDeliveryAgentName()%></td>
					<td><%=subscription.getDeliveryAgentPhno()%></td>
					<td><%=subscription.getAreaAssigned()%></td>
					<td><%=subscription.getAddress()%></td>                 
					<td><%=subscription.getSubscriptionStatus()%></td>
					<td><%=subscription.getPaymentType()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>

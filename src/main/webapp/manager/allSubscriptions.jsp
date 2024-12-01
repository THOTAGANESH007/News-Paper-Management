<%@page import="java.util.List"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.models.Subscriptions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Subscriptions</title>
<%@include file="cdns.jsp"%>
</head>
<body style="background-color: #f0f2f2">
	<%@include file="navbar.jsp"%>
	<%
	if (userObj != null) {
	%>
	<h3 class="text-center">
		Hello
		<%=userObj.getName()%></h3>
	<table class="table table-striped">
		<thead class="bg-primary text-white">
			<tr>
				<th scope="col">Sub Id</th>
				<th scope="col">User Id</th>
				<th scope="col">User Name</th>
				<th scope="col">Email</th>
				<th scope="col">Ph No</th>
				<th scope="col">Address</th>
				<th scope="col">Publication Name</th>
				<th scope="col">Amount</th>
				<th scope="col">Payment Type</th>
				<th scope="col">Start Date</th>
				<th scope="col">Payment Status</th>
				<th scope="col">Subscription Status</th>
				<th scope="col">Days Count</th>
			</tr>
		</thead>
		<tbody>
			<%
			PublicationDAOImpl sdao = new PublicationDAOImpl(DBConnect.getConn());
			List<Subscriptions> slist = sdao.allSubscriptions();
			for (Subscriptions s : slist) {
			%>
			<tr>
				<td><%=s.getSid()%></td>
				<td><%=s.getUid()%></td>
				<td><%=s.getCustomerName()%></td>
				<td><%=s.getEmail()%></td>
				<td><%=s.getPhno()%></td>
				<td><%=s.getAddress()%></td>
				<td><%=s.getPublicationName()%></td>
				<td><%=s.getAmount()%></td>
				<td><%=s.getPaymentType()%></td>
				<td><%=s.getStartDateString()%></td>
				<td><%=s.getPaymentStatus()%></td>
				<td><%=s.getSubscriptionStatus()%></td>
				<td><%=s.getDaysCount()%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<div style="margin-top: 130px;">
		<%@include file="footer.jsp"%></div>
	<%
	} else {
	response.sendRedirect("../login.jsp");
	}
	%>
</body>
</html>

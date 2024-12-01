<%@page import="com.dao.PublicationDAOImpl"%>
<%@page import="com.models.Subscriptions"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.models.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Subscriptions</title>
<%@include file="includes/cdns.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@include file="includes/navbar.jsp"%>
	<%
	User u = (User) session.getAttribute("userObj");
	if (u != null) {
		PublicationDAOImpl pdao = new PublicationDAOImpl(DBConnect.getConn());
		List<Subscriptions> slist = pdao.getSubscriptionsByUid(u.getId());
		if (slist != null && !slist.isEmpty()) {
	%>

	<div class="container p-1">
		<h5 class="text-center text-danger"><%=u.getName()%> 's Subscriptions</h5>
		<table class="table table-hover mt-3 text-center">
			<thead class="bg-primary text-white">
				<tr>
					<th scope="col">Subscription ID</th>
					<th scope="col">Publication Name</th>
					<th scope="col">Your Address</th>
					<th scope="col">Amount</th>
					<th scope="col">Payment Type</th>
					<th scope="col">Payment Status</th>
					<th scope="col">Subscription Status</th>
					<th scope="col">Subscription Date</th>
				</tr>
			</thead>
			<tbody>
				<%
				
				for (Subscriptions s : slist) {
				%>
				<tr>
					<td><strong>SUB-00-<%=s.getSid()%></strong></td> <!-- Subscription ID -->
					<td><%=s.getPublicationName()%></td> <!-- Publication Name -->
					<td><%=s.getAddress() %></td> <!-- Users Address -->
					<td><%=s.getAmount()%></td> <!-- Amount -->
					<td><%=s.getPaymentType()%></td> <!-- Payment Type -->
					<td><%=s.getPaymentStatus()%></td> <!-- Subscription Status -->
					<td><%=s.getSubscriptionStatus() %></td>
					<td><%=s.getStartDate()%></td> <!-- Start Date -->
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	
    <%
        } else {
            out.println("<h4 class='text-danger'>No Subscriptions found for the given User ID.</h4>");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
    %>
</body>
</html>

<%@ page import="com.db.DBConnect"%>
<%@ page import="com.dao.PublicationDAOImpl"%>
<%@ page import="com.models.Subscriptions"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="cdns.jsp"%>
<meta charset="UTF-8">
<title>Post Bills</title>
<script>
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
	});
</script>
</head>
<body>
	<%@ include file="navbar.jsp"%>

	<%
	if (userObj != null) {

		// Get successMsg from session

		String SuccessMsg = (String) session.getAttribute("sent");
		if (SuccessMsg != null && !SuccessMsg.isEmpty()) {
	%>
	<p class="text-center text-success"><%=SuccessMsg%></p>
	<%
	// Remove the message from session after displaying
	session.removeAttribute("sent");
	}
	%>
	<h3 class="text-center text-danger">List Of Bills Statuses</h3>
	<table class="table table-hover ">
		<thead class="bg-primary text-white">
			<tr>
				<th scope="col">User Id</th>
				<th scope="col">User Name</th>
				<th scope="col">Email</th>
				<th scope="col">Payment Status</th>
				<th scope="col">Subscription Status</th>
				<th scope="col">Amount</th>
				<th scope="col">Payment Type</th>
				<th scope="col">Post Notice</th>
			</tr>
		</thead>
		<tbody>
			<%
			PublicationDAOImpl sdao = new PublicationDAOImpl(DBConnect.getConn());
			List<Subscriptions> subscriptions = sdao.allSubscriptions();

			// Iterate through each subscription and display the necessary information
			for (Subscriptions sub : subscriptions) {
				String paymentStatus = sub.getPaymentStatus();
				int daysCount = sub.getDaysCount();
				int remainingDays = Math.max(30 - daysCount, 0); // Calculate remaining days
			%>
			<tr>
				<th scope="row"><%=sub.getUid()%></th>
				<td><%=sub.getCustomerName()%></td>
				<td><%=sub.getEmail()%></td>
				<td><%=paymentStatus%></td>
				<td><%=sub.getSubscriptionStatus()%></td>
				<td><%=sub.getAmount()%></td>
				<td><%=sub.getPaymentType()%></td>
				<td>
					<%
					if ("pending".equalsIgnoreCase(paymentStatus) && daysCount >= 30) {
					%>
					<a href="../increaseNotificationCount?userId=<%=sub.getUid()%>"
					class="btn btn-success btn-sm">Post Notice</a> <%
 } else {
 %>
					<button type="button" class="btn btn-warning btn-sm"
						data-toggle="tooltip" data-placement="top"
						title="No Overdue && Already Paid!!!">Post Notice</button> <%
 }
 %>
				</td>

			</tr>
			<%
			} // End of subscription loop
			%>
		</tbody>
	</table>
	<%
	} else {
	response.sendRedirect("../login.jsp");
	}
	%>
</body>
</html>

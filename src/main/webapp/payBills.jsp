<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.models.Subscriptions"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="includes/cdns.jsp"%>
<meta charset="UTF-8">
<title>Subscription Summary</title>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<%
	User u = (User) session.getAttribute("userObj");
	if (u != null) {
		PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());
		List<Subscriptions> subscriptions = dao.getSubscriptionsByUid(u.getId());
	if (subscriptions != null && !subscriptions.isEmpty()) {
	%>
	<h3 class="text-center text-danger"><%=u.getName()%>'s
		Subscription Summary
	</h3>

	<table class="table table-hover">
		<thead class="bg-primary text-white">
			<tr>
				<th scope="col">Subscription Id</th>
				<th scope="col">Subscription Name</th>
				<th scope="col">Amount</th>
				<th scope="col">Subscribed Date</th>
				<th scope="col">Payment Type</th>
				<th scope="col">Payment Status</th>
				<th scope="col">Subscription Status</th>
				<th scope="col">Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			double totalAmount = 0;
			for (Subscriptions sub : subscriptions) {
				totalAmount += sub.getAmount();
			}
			for (Subscriptions sub : subscriptions) {
				int daysCount = sub.getDaysCount();
				int remainingDays = Math.max(30 - daysCount, 0); // Calculate remaining days
			%>
			<tr>
				<th scope="row"><strong>SUB-ID-00-<%=sub.getSid()%></strong></th>
				<td scope="row"><%=sub.getPublicationName() %></td>
				<td><%=sub.getAmount()%></td>
				<td><%=sub.getStartDate()%></td>
				<td><%=sub.getPaymentType()%></td>
				<td><%=sub.getPaymentStatus()%></td>
				<td><%=sub.getSubscriptionStatus()%></td>
				<td>
					<%
					// Check if payment status is pending and daysCount is 30
					if ("pending".equalsIgnoreCase(sub.getPaymentStatus())) {
					%> <a
					href="cheque.jsp?uid=<%=sub.getUid()%>&&amount=<%=sub.getAmount()%>&&sid=<%=sub.getSid()%>"
					class="btn btn-danger btn-sm"> Pay Bill </a> <%
 } else {
 %>
					<button type="button" class="btn btn-warning btn-sm"
						data-toggle="tooltip" data-placement="top"
						title="You Had Already Paid the Bill!!!">Pay Bill</button> <%
 }
 %> <a href="receipt.jsp?uid=<%=u.getId()%>"
					class="btn btn-success btn-sm" data-toggle="tooltip"
					data-placement="top" title="Click to view your receipt">View
						Receipt</a>
				</td>
			</tr>
			<%
			} // End of for each loop
			%>
			<tr class="bg-light">
				<td colspan="3"></td>
				<td><strong>Total Amount:</strong></td>
				<td colspan="2"><strong><%=totalAmount%></strong></td>
			</tr>
		</tbody>
	</table>
	
	<%
        } else {
            out.println("<h4 class='text-danger'>No Bills found for the given User ID.</h4>");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
    %>
	
</body>
</html>

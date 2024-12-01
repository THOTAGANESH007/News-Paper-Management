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
	<h3 class="text-center text-danger">Subscription Summary</h3>

	<table class="table table-hover">
		<thead class="bg-primary text-white">
			<tr>
				<th scope="col">User Id</th>
				<th scope="col">User Name</th>
				<th scope="col">Email</th>
				<th scope="col">Amount</th>
				<th scope="col">Payment Type</th>
				<th scope="col">Payment Status</th>
				<th scope="col">Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			// Get the list of subscriptions and total amount from request attributes
			List<Subscriptions> subscriptions = (List<Subscriptions>) session.getAttribute("subscriptions");
			Double totalAmount = (Double) session.getAttribute("totalAmount");

			for (Subscriptions sub : subscriptions) {
			%>
			<tr>
				<th scope="row"><%=sub.getUid()%></th>
				<td><%=sub.getCustomerName()%></td>
				<td><%=sub.getEmail()%></td>
				<td><%=sub.getAmount()%></td>
				<td><%=sub.getPaymentType()%></td>
				<td><%=sub.getPaymentStatus()%></td>
				<td>
					<%
					// If payment status is "pending", show "Pay Bill" button
					if ("pending".equalsIgnoreCase(sub.getPaymentStatus())) {
					%> <a
					href="cheque.jsp?uid=<%=sub.getUid()%>&&amount=<%=sub.getAmount()%>"
					class="btn btn-success btn-sm">Pay Bill</a> <%
 } else {
 %> <span class="text-success">Paid</span> <%
 }
 %>
				</td>
			</tr>
			<%
			}
			%>
			<tr class="bg-light">
				<td colspan="3"></td>
				<td><strong>Total Amount:</strong></td>
				<td colspan="2"><strong><%=totalAmount%></strong></td>
			</tr>
		</tbody>
	</table>

	<div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%>
	</div>
</body>
</html>

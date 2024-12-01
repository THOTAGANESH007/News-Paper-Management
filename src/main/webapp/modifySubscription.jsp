<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.models.Subscriptions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Subscription</title>
<%@ include file="includes/cdns.jsp"%>
</head>
<body>
	<%@ include file="includes/navbar.jsp"%>
	<%
	User u = (User) session.getAttribute("userObj");
	if (u != null) {
		PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());
		List<Subscriptions> subscriptions = dao.getSubscriptionsByUid(u.getId());
		if (subscriptions != null && !subscriptions.isEmpty()) {
	%>

	<table class="table table-hover text-center">
		<thead class="bg-primary text-white">
			<tr>
				<th>Subscription Id</th>
				<th>Publication Name</th>
				<th>Amount</th>
				<th>Payment Type</th>
				<th>Status</th>
				<th>Date</th>
				<th>Hold</th>
				<th>Unhold</th>
				<th>Unsubscribe</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (Subscriptions sub : subscriptions) {
				boolean isCancelled = "Cancelled".equalsIgnoreCase(sub.getSubscriptionStatus());
				boolean isOnHold = "On Hold".equalsIgnoreCase(sub.getSubscriptionStatus());
			%>
			<tr>
				<td><strong>SUB-ID-00-<%=sub.getSid()%></strong></td>
				<td><%= sub.getPublicationName() %></td>
				<td><%= sub.getAmount() %></td>
				<td><%= sub.getPaymentType() %></td>
				<td><%= sub.getSubscriptionStatus() %></td>
				<td><%= sub.getStartDate() %></td>
				<td>
					<button id="hold-btn-<%= sub.getSid() %>" class="btn btn-warning btn-sm"
						<%= isCancelled || isOnHold ? "disabled" : "" %>
						onclick="openHoldModal(<%= sub.getSid() %>)">Hold</button>
				</td>
				<td>
					<button id="unhold-btn-<%= sub.getSid() %>" class="btn btn-success btn-sm"
						<%= isOnHold ? "" : "disabled" %>
						onclick="updateStatus(<%= sub.getSid() %>, 'unhold')">Unhold</button>
				</td>
				<td>
					<button id="unsubscribe-btn-<%= sub.getSid() %>" class="btn btn-danger btn-sm"
						<%= isCancelled ? "disabled" : "" %>
						onclick="openUnsubscribeModal(<%= sub.getSid() %>)">
						<%= isCancelled ? "Unsubscribed" : "Unsubscribe" %>
					</button>
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<!-- Hold Confirmation Modal -->
	<div class="modal fade" id="holdModal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Hold Confirmation</h5>
	        <button type="button" class="btn" data-bs-dismiss="modal" aria-label="Close" style="border: none; background: none;">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        Your subscription will be hold after 7 days.
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-warning" id="confirmHold">Confirm Hold</button>
	      </div>
	    </div>
	  </div>
	</div>

	<!-- Unsubscribe Confirmation Modal -->
	<div class="modal fade" id="unsubscribeModal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Unsubscribe Confirmation</h5>
	        <button type="button" class="btn" data-bs-dismiss="modal" aria-label="Close" style="border: none; background: none;">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        Are you sure you want to unsubscribe?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-danger" id="confirmUnsubscribe">Unsubscribe</button>
	      </div>
	    </div>
	  </div>
	</div>
    <%
        } else {
            out.println("<h4 class='text-danger'>No Subscriptions found for the given User ID.</h4>");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
    %>

	<!-- Include Bootstrap JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		let subscriptionId = null;

		// Open the hold confirmation modal
		function openHoldModal(sid) {
			subscriptionId = sid;
			let modal = new bootstrap.Modal(document.getElementById('holdModal'));
			modal.show();
		}

		// Open the unsubscribe modal
		function openUnsubscribeModal(sid) {
			subscriptionId = sid;
			let modal = new bootstrap.Modal(document.getElementById('unsubscribeModal'));
			modal.show();
		}

		// Handle hold confirmation
		document.getElementById("confirmHold").addEventListener("click", function () {
			// Update the database and display a message
			alert("Your subscription will be hold after 7 days.");

			// Disable the "Hold" button after confirmation
			document.getElementById('hold-btn-' + subscriptionId).disabled = true;
		});

		// Handle unsubscribe confirmation
		document.getElementById("confirmUnsubscribe").addEventListener("click", function () {
			// Disable the "Hold" button and update unsubscribe button
			document.getElementById('hold-btn-' + subscriptionId).disabled = true;
			let unsubscribeBtn = document.getElementById('unsubscribe-btn-' + subscriptionId);
			unsubscribeBtn.innerText = "Unsubscribed";
			unsubscribeBtn.disabled = true;

			// Proceed to update the database
			window.location.href = "ModifySubscriptionServlet?action=unsubscribe&sid=" + subscriptionId;
		});

		// Handle unhold action
		function updateStatus(sid, action) {
			window.location.href = "ModifySubscriptionServlet?action=" + action + "&sid=" + sid;
		}
	</script>
</body>
</html>

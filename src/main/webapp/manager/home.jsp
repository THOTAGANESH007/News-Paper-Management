<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manager</title>
<style type="text/css">
body {
	background-color: #f4f4f4;
	font-family: Arial, sans-serif;
}

.container {
	margin-top: 20px;
}

.container a {
	text-decoration: none; /* Remove underline by default */
	color: black;
	transition: color 0.3s ease; /* Transition for text color */
}

.container a:hover {
	color: #0056b3; /* Change color on hover */
	text-decoration: none; /* Ensure no underline on hover */
}

.card {
	border: 1px solid #ddd;
	border-radius: 0.5rem; /* Rounded corners */
	transition: background-color 0.3s ease, border-color 0.3s ease;
	margin-bottom: 20px; /* Space between cards */
}

.card:hover {
	background-color: #e9ecef; /* Light background on hover */
	border-color: #0056b3; /* Border color change on hover */
}

.card-body {
	padding: 2rem; /* More padding for card content */
	text-align: center;
}

.card-body:hover {
	background-color: #f8f9fa; /* Background color change on hover */
}

.icon {
	font-size: 3rem; /* Consistent icon size */
	transition: transform 0.3s ease; /* Transition for icon scale */
}

.icon:hover {
	transform: scale(1.1); /* Scale icon on hover */
}

h4, h5 {
	margin-top: 1rem; /* Space above titles */
	font-weight: bold;
	color: #343a40; /* Dark gray color for text */
}
</style>
<%@ include file="cdns.jsp"%>
</head>

<body>
	<%@ include file="navbar.jsp"%>

	<%
	if (userObj != null) {
	%>
	<div class="container">
		<div class="row p-3">
			<div class="col-md-6">
				<a href="addORdel.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-plus-square icon text-primary"></i><br>
							<h4>Add/Delete Publications</h4>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-6">
				<a href="addDeliveryAgent.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-truck fa-3x icon text-primary"></i><br>
							<h5>Add Delivery Agent</h5>
						</div>
					</div>
				</a>
			</div>
		</div>

		<div class="row p-3">
			<div class="col-md-6">
				<a href="postNotices.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-exclamation-triangle fa-3x icon text-danger"></i><br>
							<h4>Post Notices</h4>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-6">
				<a href="allSubscriptions.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-sort-amount-down icon text-success"></i><br>
							<h5>All Subscriptions</h5>
						</div>
					</div>
				</a>
			</div>
		</div>

		<div class="row p-3">
			<div class="col-md-6">
				<a href="assignedToDeliveryAgents.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-location-arrow icon text-warning"></i> <br>
							<h5>Assignments to Delivery Agents</h5>
						</div>
					</div>
				</a>
			</div>


			<div class="col-md-6">
				<a href="deliveryAgents.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-male icon text-danger"></i><br>
							<h5>Delivery Agents</h5>
						</div>
					</div>
				</a>
			</div>
		</div>
	</div>
	<%
	} else {
	response.sendRedirect("../login.jsp");
	}
	%>
</body>

</html>

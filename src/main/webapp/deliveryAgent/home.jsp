<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delivery Person</title>
<style type="text/css">
body {
	background-color: #f4f4f4;
}

.container a {
	text-decoration: none; /* No underline */
	color: #007bff; /* Link color */
	transition: color 0.3s ease; /* Smooth color transition */
	position: relative; /* For positioning pseudo-elements */
}

.container a:hover {
	color: #0056b3; /* Darker color on hover */
	text-decoration: none; /* Ensure no underline on hover */
}

.container a:active {
	color: #0056b3; /* Darker color when active */
}

.card {
	border: 1px solid #ddd;
	border-radius: 0.5rem;
	transition: background-color 0.3s ease, border 0.3s ease;
	margin-bottom: 20px;
}

.card:hover {
	background-color: #f8f9fa; /* Light background on hover */
	border-color: #0056b3; /* Border color change on hover */
}

.card-body {
	padding: 2rem; /* Padding inside card */
	text-align: center; /* Center text */
}

.card-body:hover {
	background-color: #e9ecef;
	/* Slightly darker background on card hover */
}

h4 {
	margin-top: 1rem; /* Space above the heading */
	font-weight: bold; /* Bold heading */
	color: #343a40; /* Dark gray color */
}

.icon {
	font-size: 3rem; /* Size for the icon */
	color: #007bff; /* Icon color */
}
</style>
<%@ include file="cdns.jsp"%>
</head>

<body>
	<%@ include file="navbar.jsp"%>
	<%
	if (userObj != null) {
	%>
	<div class="container mt-4">
		<div class="row">
			<div class="col-md-6 mx-auto">
				<a href="dailyDeliveryList.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-truck fa-2x"></i>
							<h4>Daily Delivery List</h4>
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

	<div style="margin-top: 130px;">
		<%@include file="footer.jsp"%>
	</div>

</body>

</html>

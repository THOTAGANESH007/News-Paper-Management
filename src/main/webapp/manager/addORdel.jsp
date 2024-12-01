<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add or Delete Publications</title>
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
				<a href="addPublications.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-plus-square icon text-primary"></i><br>
							<h4>Add Publications</h4>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-6">
				<a href="removePublications.jsp">
					<div class="card">
						<div class="card-body">
							<i class="fas fa-folder-minus icon text-danger"></i><br>
							<h5>Remove Publications</h5>
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

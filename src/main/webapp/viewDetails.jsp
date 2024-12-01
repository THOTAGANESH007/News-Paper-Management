<%@page import="com.models.Publications"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<%@page import="com.db.DBConnect"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Details</title>
<%@include file="includes/cdns.jsp"%>
<style>
body {
	background-color: #f7f7f7;
}

.card {
	margin: 20px auto; /* Center card horizontally */
	max-width: 600px; /* Set maximum card width */
	border-radius: 10px; /* Rounded corners */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Subtle shadow */
	transition: transform 0.2s; /* Smooth transition for hover effect */
}

.card:hover {
	transform: scale(1.02); /* Slight zoom on hover */
}

.card-img-top {
	border-top-left-radius: 10px; /* Rounded corners */
	border-top-right-radius: 10px; /* Rounded corners */
	width: 100%; /* Make image responsive */
	height: auto; /* Maintain aspect ratio */
}

.btn-custom {
	margin: 5px; /* Add some spacing between buttons */
	border-radius: 5px; /* Rounded button corners */
	padding: 10px 20px; /* Button padding */
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<%
		// Get the publication ID from the request
		User u = (User) session.getAttribute("userObj");
		int pid = Integer.parseInt(request.getParameter("pid"));

		// Fetch publication details using the PublicationDAO
		PublicationDAOImpl publicationDAO = new PublicationDAOImpl(DBConnect.getConn());
		Publications publication = publicationDAO.getPublicationById(pid); // Method to fetch publication by ID

		// Display publication details or error message
		if (publication != null) {
		%>
		<div class="card">
			<img class="card-img-top"
				src="publications/<%=publication.getPhoto()%>"
				alt="<%=publication.getPublicationName()%>">
			<div class="card-body text-center">
				<h4 class="card-title">
					<strong>Publication Name:</strong><%=publication.getPublicationName()%></h4>
				<h5 class="card-text">
					<strong>Author:</strong>
					<%=publication.getAuthor()%></h5>
				<p class="card-text">
					<strong>Summary:</strong>
					<%=publication.getSummary()%></p>
				<div class="d-flex justify-content-center">
					<a href="index.jsp" class="btn btn-primary btn-custom">Home</a>
					<%
					if (u != null) {
					%>
					<a
						href="cartServlet?pid=<%=publication.getPid()%>&uid=<%=u.getId()%>"
						class="btn btn-success btn-custom">Add to Cart</a> <a
						href="cartServlet?pid=<%=publication.getPid()%>&uid=<%=u.getId()%>"
						class="btn btn-danger btn-custom">Buy Now</a>
					<%
					} else {
					%>
					<a href="login.jsp" class="btn btn-secondary btn-custom">Add to
						Cart</a> <a href="login.jsp" class="btn btn-secondary btn-custom">Buy
						Now</a>
					<%
					}
					%>
				</div>
			</div>
		</div>
		<%
		} else {
		%>
		<div class="alert alert-danger text-center" role="alert">
			Publication not found!</div>
		<%
		}
		%>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>

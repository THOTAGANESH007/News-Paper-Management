<!DOCTYPE html>
<%@page import="com.models.Publications"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<html>
<head>
<style type="text/css">
.crd-ho:hover {
	background-color: #f0f7f7;
}
.card {
	width: 18rem;
	min-height: 25rem; /* Increase the minimum height of the cards */
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	margin-bottom: 20px; /* Add vertical spacing between rows */
}


.card-img-top {
	height: 220px; /* Adjust height to maintain visual balance */
	object-fit: cover;
}

.card-body {
	flex-grow: 1; /* Allow the body to grow and fill space */
	display: flex;
	flex-direction: column;
	justify-content: space-between; /* Ensure content is spaced evenly */
}
.card-title {
	text-align: center;
	font-size: 1.25rem;
}
</style>
<meta charset="UTF-8">
<title>News Papers</title>
<%@include file="includes/cdns.jsp"%>
</head>
<body>
	<%
	User u = (User) session.getAttribute("userObj");
	%>
	<%@include file="includes/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row p-3">

			<%
			// Create an instance of PublicationDAO and fetch all newspapers
			PublicationDAOImpl publicationDAO = new PublicationDAOImpl(DBConnect.getConn());
			List<Publications> news = publicationDAO.getAllNewsPapers(); // Fetch all newspapers

			// Iterate through the list of newspapers and display them
			for (Publications b : news) {
			%>
			<div class="col-md-3 d-flex align-items-stretch mb-3">
				<div class="card crd-ho">
					<img class="card-img-top" src="publications/<%=b.getPhoto()%>"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%=b.getPublicationName()%></h5>
						<div class="row">
							<%
							if (u == null) {
							%>
							<a href="login.jsp" class="btn btn-danger btn-sm ml-2">Add to
								Cart</a> 
							<a href="viewDetails.jsp?pid=<%=b.getPid()%>"
								class="btn btn-success btn-sm ml-1">View Details</a> 
							<a href="login.jsp" class="btn btn-danger btn-sm ml-1"><i
								class="fas fa-rupee-sign"></i> <%=b.getPrice()%></a>
							<%
							} else {
							%>
							<a href="cartServlet?pid=<%=b.getPid()%>&uid=<%=u.getId()%>"
								class="btn btn-danger btn-sm ml-2">Add to Cart</a> 
							<a href="viewDetails.jsp?pid=<%=b.getPid()%>"
								class="btn btn-success btn-sm ml-1">View Details</a> 
							<a href="cartServlet?pid=<%=b.getPid()%>&uid=<%=u.getId()%>"
								class="btn btn-danger btn-sm ml-1"><i
								class="fas fa-rupee-sign"></i> <%=b.getPrice()%></a>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
			<%
			} // End of the for loop
			%>
		</div>
	</div>
	<div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%>
	</div>
</body>
</html>

<%@page import="com.dao.PublicationDAOImpl"%>
<%@page import="com.models.Publications"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.models.User"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.crd-ho:hover {
	background-color: #f0f7f7;
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
			List<Publications> maggi = publicationDAO.getAllMagazines(); // Fetch all Magazines

			// Iterate through the list of newspapers and display them
			for (Publications b : maggi) {
			%>
			<div class="col-md-3">
				<div class="card crd-ho" style="width: 18rem;">
					<img class="card-img-top" src="publications/<%=b.getPhoto()%>"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title text-center"><%=b.getPublicationName()%></h5>
						<p class="card-text">
							Author:
							<%=b.getAuthor()%></p>
						<div class="row">
							<%
							if (u == null) {
							%>
							<a href="login.jsp" class="btn btn-danger btn-sm ml-2">Add to
								Cart</a> <a href="viewDetails.jsp?pid=<%=b.getPid()%>"
								class="btn btn-success btn-sm ml-1">View Details</a> <a
								href="login.jsp" class="btn btn-danger btn-sm ml-1"><i
								class="fas fa-rupee-sign"></i> <%=b.getPrice()%></a>
							<%
							} else {
							%>
							<a href="cartServlet?pid=<%=b.getPid()%>&uid=<%=u.getId()%>"
								class="btn btn-danger btn-sm ml-2">Add to Cart</a> <a
								href="viewDetails.jsp?pid=<%=b.getPid()%>"
								class="btn btn-success btn-sm ml-1">View Details</a> <a
								href="cartServlet?pid=<%=b.getPid()%>&uid=<%=u.getId()%>"
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Success</title>
<%@include file="includes/cdns.jsp"%>
</head>
<body style="background-color: #f7f7f7;">
	<%@include file="includes/navbar.jsp"%>
<%if(userObj != null){ %>
	<div class="container text-center mt-3">
		<!-- Display session messages -->
		<%
		// Check if there's a Success message in the session
		if (session.getAttribute("SuccessMsg") != null) {
		%>
		<div class="alert alert-success">
			<%= session.getAttribute("SuccessMsg") %>
		</div>
		<%
		}

		// Check if there's a Failed message in the session
		if (session.getAttribute("FailedMsg") != null) {
		%>
		<div class="alert alert-danger">
			<%= session.getAttribute("FailedMsg") %>
		</div>
		<%
		}
		%>

		<div class="card">
			<div class="card-body">
				<i class="fas fa-check-circle fa-5x text-success"></i>
				<h1>Thank You</h1>
				<h2>Your Payment <%= (session.getAttribute("SuccessMsg") != null) ? "Successful" : "Failed" %>!!!</h2>
			<%-- 	<%session.removeAttribute("SuccessMsg");  
				session.removeAttribute("FailedMsg");
				%> --%>

				<a href="index.jsp" class="btn btn-primary mt-3">Home</a> 
				<a href="subscriptions.jsp" class="btn btn-danger mt-3">View Order</a>
			</div>
		</div>
	</div>

	<div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%>
	</div>
	<%}else{
		response.sendRedirect("login.jsp");
	} %>
</body>
</html>

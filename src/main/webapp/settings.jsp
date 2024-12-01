<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Settings</title>
<%@include file="includes/cdns.jsp"%>
<style type="text/css">
.anchor-ho {
	text-decoration: none;
	color: black;
}

.anchor-ho:hover {
	text-decoration: none;
}
</style>
</head>
<body style="background-color: #f7f7f7;">
	<%@include file="includes/navbar.jsp"%>

	<%
	User u = (User) session.getAttribute("userObj");
	if (u != null) {
		PublicationDAOImpl sdao = new PublicationDAOImpl(DBConnect.getConn());
		int notificationCount = sdao.getNotificationCount(u.getId());
	%>
	<div class="container">
		<h3 class="text-center">
			Hello&nbsp;<%=u.getName()%></h3>

		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6 mt-3">
				<a href="notifications.jsp" class="anchor-ho">
					<div class="card">
						<div class="card-body text-center">
							<div class="text-warning">
								<i class="fas fa-sms fa-3x"></i>

							</div>
							<button type="button" class="btn btn-danger">
								Notifications <span class="badge badge-light"> <%=notificationCount%>
								</span>
							</button>
							<p>Your Notices</p>
						</div>
					</div>
				</a>
			</div>
		</div>

		<div class="row p-5">
			<div class="col-md-4">
				<a href="receipt.jsp?uid=<%=u.getId()%>" class="anchor-ho">
					<div class="card">
						<div class="card-body text-center">
							<div class="text-primary">

								<i class="fas fa-receipt fa-3x"></i>
							</div>
							<h3><%=u.getName()%>'s Receipts
							</h3>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4">
				<a href="payBills.jsp" class="anchor-ho">
					<div class="card">
						<div class="card-body text-center">
							<div class="text-primary">
								<i class="fas fa-file-invoice fa-3x"></i>
							</div>
							<h3><%=u.getName()%>'s Bills
							</h3>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4">
				<a href="editProfile.jsp" class="anchor-ho">
					<div class="card">
						<div class="card-body text-center">
							<div class="text-primary">
								<i class="fas fa-user-edit fa-3x"></i>
							</div>
							<h4>
								Edit
								<%=u.getName()%>'s Profile
							</h4>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mt-3">
				<a href="userAddress.jsp" class="anchor-ho">
					<div class="card">
						<div class="card-body text-center">
							<div class="text-warning">
								<i class="fas fa-map-marker-alt fa-3x"></i>
							</div>
							<h4>Your Address</h4>
							<p>
								Edit
								<%=u.getName()%>'s Address
							</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mt-3">
				<a href="subscriptions.jsp" class="anchor-ho">
					<div class="card">
						<div class="card-body text-center">
							<div class="text-danger">
								<i class="fas fa-bookmark fa-3x"></i>
							</div>
							<h4><%=u.getName()%>'s Subscriptions
							</h4>
							<p>Track Your Subscriptions</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mt-3">
				<a href="modifySubscription.jsp" class="anchor-ho">
					<div class="card">
						<div class="card-body text-center">
							<div class="text-primary">
								<i class="fas fa-edit fa-3x"></i>
							</div>
							<h4>Modify Subscriptions</h4>
							<p>&nbsp;</p>
						</div>
					</div>
				</a>
			</div>
		</div>
	</div>

	<div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%>
	</div>
	<%
	} else {
	response.sendRedirect("login.jsp");
	}
	%>
</body>
</html>

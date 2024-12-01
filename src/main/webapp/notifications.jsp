<%@page import="com.models.Subscriptions"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notifications</title>
<%@include file="includes/cdns.jsp"%>
<style>
.notification-box {
	background-color: #f8f9fa;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 30px;
	text-align: center;
}

.notification-text {
	font-size: 1.2rem;
	color: #495057;
}

.btn-pay {
	margin-top: 20px;
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<%
		User u = (User) session.getAttribute("userObj");
		if (u != null) {
			PublicationDAOImpl sdao = new PublicationDAOImpl(DBConnect.getConn());
			int notificationCount = sdao.getNotificationCount(u.getId());
			String notificationText = sdao.getNotificationText(u.getId());
			List<Subscriptions> subscriptions = sdao.getSubscriptionsByUid(u.getId());

			if (subscriptions != null && !subscriptions.isEmpty()) {
				if (notificationCount > 0) {
		%>

		<div class="row justify-content-center mt-5">
			<div class="col-md-8">
				<div class="notification-box">
					<h2 class="text-info">
						Hello, Mr.
						<%=u.getName()%>!
					</h2>
					<p class="notification-text">
						You have received <strong class="text-warning"><%=notificationCount%></strong>
						notifications regarding your account.
					</p>
					<p class="notification-text">
						Latest notification: <strong class="text-primary">"<%=notificationText%>"
						</strong>
					</p>

					<a href="payBills.jsp" class="btn btn-danger btn-pay">Pay Your
						Bill</a>
				</div>
			</div>
		</div>
		<%
		} else {
		%>
		<div class="row justify-content-center mt-5">
			<div class="col-md-8">
				<div class="notification-box">
					<h2 class="text-info">
						Hello, Mr.
						<%=u.getName()%>!
					</h2>
					<p class="notification-text">You have Paid All Your Bills and there are no Dues</p>
					<p class="notification-text">
						<strong class="text-primary">Thank You</strong>
					</p>
				</div>
			</div>
		</div>
		<%
		}
		%>
		<div style="margin-top: 130px;">
			<%@include file="includes/footer.jsp"%>
		</div>
		<%
		} else {
		out.println(
				"<h4 class='text-danger'>No Notifications found for the given User ID<br>Because you hadn't Subscribed to any Subscription.</h4>");
		}
		} else {
		response.sendRedirect("login.jsp");
		}
		%>
	
</body>
</html>

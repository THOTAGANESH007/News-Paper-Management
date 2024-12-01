<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success</title>
<%@include file="includes/cdns.jsp"%>
</head>
<body style="background-color: #f7f7f7;">
	<%@include file="includes/navbar.jsp"%>
	<div class="container text-center mt-3">
		<div class="card">
			<div class="card-body">
				<i class="fas fa-check-circle fa-5x text-success"></i>
				<h1>Thank You</h1>
				<h2>Your Order Successful!!!</h2>
				<h5>Our Delivery Person will deliver your subscriptions to your Address Daily!!!</h5>
				<a href="index.jsp" class="btn btn-primary mt-3">Home</a> <a
					href="subscriptions.jsp" class="btn btn-danger mt-3">View Order</a>

			</div>
		</div>

	</div>
	<div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%></div>
</body>
</html>
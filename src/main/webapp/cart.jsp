<%@page import="com.db.DBConnect"%>
<%@page import="com.models.Cart"%>
<%@page import="com.dao.CartDAOImpl"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style type="text/css">
.crd-ho:hover {
	background-color: #f0f7f7;
}

/* toast */
#toast {
	min-width: 300px;
	position: fixed;
	bottom: 30px;
	left: 50%;
	margin-left: -125px;
	background: #333;
	padding: 10px;
	color: white;
	text-align: center;
	z-index: 1;
	font-size: 18px;
	visibility: hidden;
	box-shadow: 0px 0px 100px #000;
}

#toast.display {
	visibility: visible;
	animation: fadeIn 0.5, fadeOut 0.5s 2.5s;
}

@
keyframes fadeIn {from { bottom:0;
	opacity: 0;
}

to {
	bottom: 30px;
	opacity: 1;
}

}
@
keyframes fadeOut {form { bottom:30px;
	opacity: 1;
}

to {
	bottom: 0;
	opacity: 0;
}

}
#toast.toast-success {
	background-color: #28a745; /* Green for success */
}

#toast.toast-failure {
	background-color: #dc3545; /* Red for failure */
}

/* toast */
</style>


<meta charset="UTF-8">
<title>Cart Page</title>
<%@include file="includes/cdns.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@include file="includes/navbar.jsp"%>
	<%
	User u = (User) session.getAttribute("userObj");
	%>
	<%
	if (u != null) {
		// Get SuccessMsg and FailedMsg from session
		String successMsg = (String) session.getAttribute("addToCart");
		String failedMsg = (String) session.getAttribute("failedToAdd");

		// Check if success message is present
		if (successMsg != null && !successMsg.isEmpty()) {
	%>
	<div id="toast" class="toast-success"><%=successMsg%></div>

	<script type="text/javascript">
		showToast();
		function showToast(content)
		{
		    $('#toast').addClass("display");
		    $('#toast').html(content);
		    setTimeout(()=>{
		        $("#toast").removeClass("display");
		    },2000)
		}	
</script>
	<%
	// Remove the message from session after displaying
	session.removeAttribute("addToCart");
	}
	%>

	<%
	// Check if failure message is present
	if (failedMsg != null && !failedMsg.isEmpty()) {
	%>
	<div id="toast" class="toast-failure"><%=failedMsg%></div>

	<script type="text/javascript">
		showToast();
		function showToast(content)
		{
		    $('#toast').addClass("display");
		    $('#toast').html(content);
		    setTimeout(()=>{
		        $("#toast").removeClass("display");
		    },2000)
		}	
</script>
	<%
	// Remove the message from session after displaying
	session.removeAttribute("failedToAdd");
	}
	%>


	<div class="container">
		<div class="row p-4">
			<div class="col-md-6">

				<div class="card bg-white">
					<div class="card-body">
						<h2 class="text-center text-success">Your Selected Items:</h2>
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">Publication Name</th>
									<th scope="col">Author</th>
									<th scope="col">Price</th>
									<th scope="col">Action</th>
								</tr>
							</thead>
							<tbody>

								<%
								CartDAOImpl imp = new CartDAOImpl(DBConnect.getConn());
								List<Cart> cart = imp.getBookByUser(u.getId());
								double totalPrice = 0;

								for (Cart c : cart) {
									totalPrice = c.getTotalPrice();
								%>

								<tr>
									<th scope="row"><%=c.getPublicationName()%></th>
									<td><%=c.getAuthor()%></td>
									<td><%=c.getPrice()%></td>
									<td><a
										href="removePublication?pid=<%=c.getPid()%>&&uid=<%=c.getUid()%>&&cid=<%=c.getCid()%>"
										class="btn btn-sm btn-danger">Remove</a></td>
								</tr>

								<%
								}
								%>

								<tr>
									<td colspan="2"><h3 class="text-center">Total Price:</h3></td>
									<td><h3 class="text-center"><%=totalPrice%></h3></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>


			<div class="col-md-6">

				<div class="card bg-white">
					<div class="card-body">
						<h2 class="text-center text-success">Fill The Subscription
							Details:</h2>


						<form action="subscriptions" method="post">
							<input type="hidden" value="<%=u.getId()%>" name="uid">
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">Name</label> <input type="text"
										name="uname" class="form-control" id="inputEmail4"
										value="<%=u.getName()%>" required="required" readonly="readonly">
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Email</label> <input type="email"
										class="form-control" id="inputPassword4"
										value="<%=u.getEmail()%>" name="email" required="required" readonly="readonly">
								</div>
							</div>

							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="examplePhoneNo">Phone Number</label> <input
										type="text" class="form-control" id="examplePhoneNumber"
										aria-describedby="phoneHelp" value="<%=u.getPhno()%>"
										required="required" name="phno" minlength="10" maxlength="10"
										pattern="[0-9]{10}" title="Phone number must be 10 digits">
									<small id="phoneHelp" class="form-text text-muted">Enter
										a valid 10-digit phone number.</small>
								</div>


								<div class="form-group col-md-6">
									<label for="inputPassword4">Address</label> <input type="text"
										class="form-control" id="inputPassword4"
										placeholder="Enter Your Address" name="address" required="required">
								</div>
							</div>



							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">LandMark</label> <select
										name="landMark" id="areaAssigned" required="required">
										<option value="noSelect">--select your landmark--</option>
										<option value="Aradigunta">Aradigunta</option>
										<option value="Bandlapalle">Bandlapalle</option>
										<option value="Bheemaganipalle">Bheemaganipalle</option>
										<option value="Bodevaripalle">Bodevaripalle</option>
										<option value="Chadalla">Chadalla</option>
										<option value="Chandramakulapalle">Chandramakulapalle</option>
										<option value="Etavakili">Etavakili</option>
										<option value="Eathuru">Eathuru</option>
										<option value="Kummaranatham">Kummaranatham</option>
										<option value="Magandlapalle">Magandlapalle</option>
										<option value="Mangalam">Mangalam</option>
										<option value="Melumdoddi">Melumdoddi</option>
										<option value="Mittachinthavaripalle">Mittachinthavaripalle</option>
										<option value="Nekkondi">Nekkondi</option>
										<option value="Palempalle">Palempalle</option>
										<option value="Gudisabanda">Gudisabanda</option>
										<option value="Raganipalle">Raganipalle</option>
										<option value="Vanamaladinne">Vanamaladinne</option>
									</select>
								</div>

								<div class="form-group col-md-6">
									<label for="inputPassword4">City</label> <input type="text"
										class="form-control" id="inputPassword4" name="city"
										required="required" value="Punganur" readonly="readonly">
								</div>
							</div>



							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">State</label> <input type="text"
										class="form-control" id="inputEmail4" name="state"
										required="required" value="Andhra Pradesh" readonly="readonly">
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Zip</label> <input type="text"
										class="form-control" id="inputPassword4" name="zip"
										required="required" value="517247" readonly="readonly">
								</div>
							</div>


							<div class="form-group">
								<label for="inputState">Payment Mode</label> <select
									id="paymentType" class="form-control" name="paymentType"
									required>
									<option value="noselect">--select--</option>
									<option value="Cash" disabled="disabled">Cash On
										Delivery</option>
									<option value="Cheque">Cheque</option>
								</select>
							</div>

							<div class="text-center">

								<button type="submit" class="btn btn-danger"
									onclick="return validatePhoneNumber()" id="orderNowBtn">Subscribe</button>
								<a href="index.jsp" class="btn btn-primary">Continue
									Shopping</a>
							</div>


							<script>
							function validatePhoneNumber() {
								var phoneNumber = document
										.getElementById('examplePhoneNumber').value;
								var phonePattern = /^[0-9]{10}$/; // Regular expression for 10 digits

								if (!phonePattern.test(phoneNumber)) {
									alert('Phone number must be exactly 10 digits.');
									return false; // Prevent form submission if invalid
								}
								return true; // Allow form submission if valid
							}
						</script>
						</form>



					</div>
				</div>

			</div>


		</div>
	</div>
	<div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%></div>
	<%
	} else {
	response.sendRedirect("login.jsp");
	}
	%>
</body>
</html>
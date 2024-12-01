<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Delivery Agent</title>
<style>
/* Optional styling for a clean layout */
body {
	background-color: #f0f1f2;
}

.card {
	margin-top: 20px;
}
</style>
<%@include file="cdns.jsp"%>
</head>
<body>
	<%@include file="navbar.jsp"%>
	<div class="container p-2">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body">
						<h4 class="text-center">Registration Page</h4>

						<%
						// Get SuccessMsg and FailedMsg from session
						String successMsg = (String) session.getAttribute("SuccessMsg");
						String failedMsg = (String) session.getAttribute("FailedMsg");

						// Check if success message is present
						if (successMsg != null && !successMsg.isEmpty()) {
						%>
						<p class="text-center text-success"><%=successMsg%></p>
						<%
						// Remove the message from session after displaying
						session.removeAttribute("SuccessMsg");
						}
						%>

						<%
						// Check if failure message is present
						if (failedMsg != null && !failedMsg.isEmpty()) {
						%>
						<p class="text-center text-danger"><%=failedMsg%></p>
						<%
						// Remove the message from session after displaying
						session.removeAttribute("FailedMsg");
						}
						%>

						<!-- Registration Form -->
						<form action="../addDeliveryAgent" method="post">
							<div class="form-group">
								<label for="categorySelect">Category</label> <select
									class="form-control" id="categorySelect" required="required"
									name="category">
									<option value="noSelect">--select--</option>
									<option value="delivery">Delivery Agent</option>
								</select>
							</div>

							<div class="form-group">
								<label for="exampleUserName">User Name</label> <input
									type="text" class="form-control" id="exampleUserName"
									aria-describedby="userHelp" placeholder="Enter Your Full Name"
									required="required" name="uname">
							</div>

							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email"
									required="required" name="email">
							</div>

							<div class="form-group">
								<label for="examplePhoneNo">Phone Number</label> <input
									type="text" class="form-control" id="examplePhoneNumber"
									aria-describedby="phoneHelp" required="required" name="phno"
									minlength="10" maxlength="10" pattern="[0-9]{10}"
									title="Phone number must be 10 digits"> <small
									id="phoneHelp" class="form-text text-muted">Enter a
									valid 10-digit phone number.</small>
							</div>

							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" id="exampleInputPassword1"
									placeholder="Password" required="required" name="password">
							</div>

							<!-- Address Fields for Delivery Agents -->
							<div id="addressPanel"">
								<h5 class="text-center">Enter Delivery Person Address</h5>

								<div class="form-row">

									<div class="form-group col-md-6">
										<label for="inputEmail4">Area Assigned</label> <select
											name="areaAssigned" id="areaAssigned" required="required">
											<option value="noSelect">--select--</option>
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
										<label for="inputCity">City</label> <input type="text"
											class="form-control" id="inputCity" placeholder="Enter City"
											name="city" value="Punganur" required readonly="readonly">
									</div>
								</div>

								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="inputState">State</label> <input type="text"
											class="form-control" id="inputState"
											placeholder="Enter State" name="state" value="Andhra Pradesh"
											required readonly="readonly">
									</div>
									<div class="form-group col-md-6">
										<label for="inputZip">Zip</label> <input type="text"
											class="form-control" id="inputZip"
											placeholder="Enter Zip Code" name="pincode" value="517247"
											required readonly="readonly">
									</div>
								</div>
							</div>

							<button type="submit" class="btn btn-primary"
								onclick="return validatePhoneNumber()">Add Delivery
								Agent</button>
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
		<%@include file="footer.jsp"%>
	</div>
</body>
</html>

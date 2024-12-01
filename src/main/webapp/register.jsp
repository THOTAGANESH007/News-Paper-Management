<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page</title>
<style>
/* Optional styling for a clean layout */
body {
	background-color: #f0f1f2;
}

.card {
	margin-top: 20px;
}
</style>
<%@include file="includes/cdns.jsp"%>
<script type="text/javascript">

</script>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<div class="container p-2">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body">
						<h4 class="text-center">Registration Page</h4>

						<%
						// Get SuccessMsg and FailedMsg from session
						//String successMsg = (String) session.getAttribute("SuccessMsg");
						String failedMsg = (String) session.getAttribute("FailedMsg");

						// Check if success message is present
						//if (successMsg != null && !successMsg.isEmpty()) {
						%>
						<!-- <p class="text-center text-success"><%--<%=successMsg%>--%></p>  -->
						<%
						// Remove the message from session after displaying
						//session.removeAttribute("SuccessMsg");
						//}
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
						<form action="register" method="post">
							<div class="form-group">
								<label for="categorySelect">Category</label> <select
									class="form-control" id="categorySelect" required="required"
									name="category">
									<option value="noSelect">--select--</option>
									<option value="user">User</option>
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
							<button type="submit" class="btn btn-primary"
								onclick="return handleFormSubmit()">Register</button>

							<script>
							    function validatePhoneNumber() {
							        var phoneNumber = document.getElementById('examplePhoneNumber').value;
							        var phonePattern = /^[0-9]{10}$/;
							
							        if (!phonePattern.test(phoneNumber)) {
							            alert('Phone number must be exactly 10 digits.');
							            return false; // Prevent form submission if invalid
							        }
							        return true; // Allow form submission if valid
							    }

							    function sendToEmail(email) {
							        fetch("RegistrationSuccessEmail?email=" + encodeURIComponent(email))
							            .then(response => response.text())
							            .then(data => {
							                alert(data); // Display success message
							            })
							            .catch(error => {
							                alert('Failed to send email');
							            });
							    }
							
							    function handleFormSubmit() {
							        // First, validate the phone number
							        if (!validatePhoneNumber()) {
							            return false;
							        }
							
							        // Get the entered email
							        var email = document.getElementById('exampleInputEmail1').value;
							
							        // Send the email to the servlet
							        sendToEmail(email);
							
							        // Return true to allow form submission to proceed
							        return true;
							    }
							</script>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%>
	</div>
</body>
</html>

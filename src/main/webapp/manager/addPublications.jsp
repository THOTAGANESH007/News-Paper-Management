<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Publications</title>
<%@include file="cdns.jsp"%>
</head>
<body style="background-color: #f0f2f2">
	<%@include file="navbar.jsp"%>
	<%
	if (userObj != null) {
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h4 class="text-center">Publish Publications</h4>
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

						<form action="../addPublications" method="post"
							enctype="multipart/form-data">
							<div class="form-group">
								<label for="exampleFormControlInput1">Publication Name*</label>
								<input type="text" class="form-control"
									id="exampleFormControlInput1" placeholder="Name of the Book"
									name="pname" required="required">
							</div>

							<div class="form-group">
								<label for="exampleFormControlInput1">Author Name*</label> <input
									type="text" class="form-control" id="exampleFormControlInput1"
									placeholder="Name of the Author" name="author"
									required="required">
							</div>

							<div class="form-group">
								<label for="exampleFormControlInput1">Price*</label> <input
									type="number" class="form-control"
									id="exampleFormControlInput1"
									placeholder="Price of the publication" name="price"
									required="required">
							</div>

							<div class="form-group">
								<label for="exampleFormControlSelect1">Publication Type*</label>
								<select class="form-control" id="exampleFormControlSelect1"
									name="ptype">
									<option selected>--select--</option>
									<option value="newsPaper">News paper</option>
									<option value="magazine">Magazine</option>
								</select>
							</div>
							
							<div class="form-group">
								<label for="exampleFormControlTextarea1">Summary*</label>
								<textarea class="form-control" id="exampleFormControlTextarea1"
									rows="3" name="summary" required="required"></textarea>
							</div>

							<div class="form-group">
								<label for="exampleFormControlFile1">Upload Photo*</label> <input
									type="file" class="form-control-file"
									id="exampleFormControlFile1" name="bimg" required="required">
							</div>
							<button type="submit" class="btn btn-primary">Publish</button>
						</form>


					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="margin-top: 40px;">
		<%@include file="footer.jsp"%></div>
	<%
	} else {
	response.sendRedirect("../login.jsp");
	}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<%@include file="includes/cdns.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
    <%@include file="includes/navbar.jsp"%>

    <div class="container p-2">
        <div class="row mt-2">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4 class="text-center">Login Page</h4>

                        <% String failedMsg = (String) session.getAttribute("failedMsg");
                           if (failedMsg != null && !failedMsg.isEmpty()) {
                        %>
                        <p class="text-center text-danger"><%= failedMsg %></p>
                        <% session.removeAttribute("failedMsg"); } %>

                        <% String successMsg = (String) session.getAttribute("successMsg");
                           if (successMsg != null && !successMsg.isEmpty()) {
                        %>
                        <p class="text-center text-success"><%= successMsg %></p>
                        <% session.removeAttribute("successMsg"); } %>

                        <form action="login" method="post">
                            <div class="form-group">
                                <label for="categorySelect">Category</label> 
                                <select class="form-control" id="categorySelect" required name="category">
                                    <option value="noSelect">--select--</option>
                                    <option value="user">User</option>
                                    <option value="delivery">Delivery Agent</option>
                                    <option value="manager">Manager</option>
                                    <option value="newsAgent">News Agent</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label> 
                                <input type="email" class="form-control" id="exampleInputEmail1"
                                    placeholder="Enter email" required name="email">
                            </div>
                        
                            <button type="button" class="btn btn-primary btn-sm" onclick="sendToEmail()">Get OTP</button>

                            <script type="text/javascript">
                                function sendToEmail() {
                                    var email = document.getElementById('exampleInputEmail1').value;
                                    fetch("sendOtpToEmail?email=" + encodeURIComponent(email))
                                        .then(response => response.text())
                                        .then(data => alert(data))
                                        .catch(error => alert('Failed to send email'));
                                }
                            </script>
                            
                            <div class="form-group">
                                <label for="exampleInputPassword1">Password</label> 
                                <input type="password" class="form-control" id="exampleInputPassword1"
                                    placeholder="Password" required name="password">
                            </div>

                            <div class="form-group">
                                <label>Enter OTP</label> 
                                <input type="text" class="form-control" placeholder="Enter Your OTP"
                                    required name="otp" id="enteredOtp">
                            </div>
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">Login</button>
                                <br> 
                                <a href="register.jsp">Create Account</a>
                            </div>
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

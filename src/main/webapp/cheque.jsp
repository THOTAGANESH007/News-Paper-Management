<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="includes/cdns.jsp"%>
    <meta charset="UTF-8">
    <title>Cheque Payment</title>
    <script>
        function validateChequeForm() {
            // Validate account holder name (non-empty, letters only)
            const accountHolderName = document.forms["chequeForm"]["accountHolderName"].value;
            if (!/^[a-zA-Z\s]+$/.test(accountHolderName)) {
                alert("Please enter a valid Account Holder Name.");
                return false;
            }

            // Validate bank name (non-empty)
            const bankName = document.forms["chequeForm"]["bankName"].value;
            if (bankName.trim() === "") {
                alert("Please enter the Bank Name.");
                return false;
            }

            // Validate cheque number (6 to 10 digits)
            const chequeNo = document.forms["chequeForm"]["chequeNo"].value;
            if (!/^\d{6,10}$/.test(chequeNo)) {
                alert("Please enter a valid Cheque Number (6 to 10 digits).");
                return false;
            }

            // Validate cheque date (cannot be in the future)
            const chequeDate = document.forms["chequeForm"]["chequeDate"].value;
            if (new Date(chequeDate) > new Date()) {
                alert("Cheque Date cannot be in the future.");
                return false;
            }

            // Validate MICR code (exactly 9 digits)
            const micrCode = document.forms["chequeForm"]["micrCode"].value;
            if (!/^\d{9}$/.test(micrCode)) {
                alert("Please enter a valid MICR Code (9 digits).");
                return false;
            }

            return true; // Form is valid
        }
    </script>
</head>
<body>
    <%@include file="includes/navbar.jsp"%>
    <h3 class="text-center text-danger">Cheque Payment</h3>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <form name="chequeForm" action="processPayment" method="post" onsubmit="return validateChequeForm();">
                    <input type="hidden" name="sid" value="<%= request.getParameter("sid") %>">
                    
                    <div class="form-group">
                        <label for="uid">User ID</label>
                        <input type="text" class="form-control" name="uid" value="<%= request.getParameter("uid") %>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label for="amount">Amount to Pay</label>
                        <input type="text" class="form-control" name="amount" value="<%= request.getParameter("amount") %>" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label for="accountHolderName">Account Holder Name</label>
                        <input type="text" class="form-control" name="accountHolderName" required>
                    </div>

                    <div class="form-group">
                        <label for="bankName">Bank Name</label>
                        <input type="text" class="form-control" name="bankName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="chequeNo">Cheque Number</label>
                        <input type="text" class="form-control" name="chequeNo" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="chequeDate">Cheque Date</label>
                        <input type="date" class="form-control" name="chequeDate" required>
                    </div>

                    <div class="form-group">
                        <label for="micrCode">MICR Code</label>
                        <input type="text" class="form-control" name="micrCode" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Pay Now</button>
                </form>
            </div>
        </div>
    </div>

    <div style="margin-top: 130px;">
        <%@include file="includes/footer.jsp"%>
    </div>
</body>
</html>

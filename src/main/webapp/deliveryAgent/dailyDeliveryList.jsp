<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.models.SubscriptionDeliveryInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.SubscriptionDAOImpl"%>
<%@page import="com.models.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Daily Delivery List</title>
<%@include file="cdns.jsp"%>
<style>
    /* Optional: Add some styles for the search input */
    #searchInput {
        margin-bottom: 20px;
    }
</style>
<script>
function searchSubscriptions() {
    // Get the input value and convert it to lowercase
    const input = document.getElementById('searchInput').value.toLowerCase();
    // Get the table rows
    const rows = document.querySelectorAll('#subscriptionsTable tbody tr');

    // Loop through the rows and hide those that don't match the search
    rows.forEach(row => {
        const customerName = row.cells[2].textContent.toLowerCase(); // Assuming customer name is in the third column
        if (customerName.includes(input)) {
            row.style.display = ''; // Show row
        } else {
            row.style.display = 'none'; // Hide row
        }
    });
}
</script>
</head>
<body>
<%@include file="navbar.jsp"%>
<%
    // Retrieve the logged-in user from the session
    User u = (User) session.getAttribute("userObj");
    if (u != null) {
        // Get the delivery agent's email from the user object
        String email = u.getEmail();

        // Fetch subscriptions assigned to the delivery agent
        SubscriptionDAOImpl dao = new SubscriptionDAOImpl(DBConnect.getConn());
        List<SubscriptionDeliveryInfo> subscriptions = dao.getSubscriptionsForDeliveryAgent(email);
%>
<div class="container mt-5">
    <h1 class="text-center text-danger">Your Assigned Subscriptions</h1>

    <!-- Search input -->
    <input type="text" id="searchInput" class="form-control w-50" placeholder="Search by Customer Name" onkeyup="searchSubscriptions()">

    <!-- Subscription table -->
    <table class="table table-hover text-center" id="subscriptionsTable">
        <thead class="bg-primary text-white">
            <tr>
                <th>Subscription ID</th>
                <th>Customer ID</th>
                <th>Customer Name</th>
                <th>Customer Email</th>
                <th>Customer Address</th>
                <th>Publication Name</th>
                <th>Area Assigned</th>
                <th>Subscription Status</th>
                <th>Payment Type</th>
            </tr>
        </thead>
        <tbody>
            <%
            if (subscriptions != null && !subscriptions.isEmpty()) {
                for (SubscriptionDeliveryInfo subscription : subscriptions) {
            %>
            <tr>
                <td><strong>SUB-ID-00-<%= subscription.getSid() %></strong></td>
                <td><strong>USR-ID-00-<%= subscription.getUid() %></strong></td>
                <td><%= subscription.getCustomerName() %></td>
                <td><%= subscription.getEmail() %></td>
                <td><%= subscription.getAddress() %></td>
                <td><%= subscription.getPublicationName() %></td>
                <td><%= subscription.getAreaAssigned() %></td>
                <td><%= subscription.getSubscriptionStatus() %></td>
                <td><%= subscription.getPaymentType() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="9" class="text-center">No assigned subscriptions found.</td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
</div>

<%
    } else {
        // Redirect to the login page if user is not logged in
        response.sendRedirect("../login.jsp");
    }
%>

<div style="margin-top: 130px;">
    <%@include file="footer.jsp" %>
</div>
</body>
</html>

<%@ page import="com.models.User" %>
<%@ page import="com.db.DBConnect" %>
<%@ page import="com.dao.PublicationDAOImpl" %>
<%@ page import="com.models.Subscriptions" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="includes/cdns.jsp" %>
<%User u = (User) session.getAttribute("userObj"); %>
<meta charset="UTF-8">
<title>Receipt</title>
<script>
    function filterTable() {
        const filter = document.getElementById("publicationName").value.toLowerCase();
        const statusFilter = document.getElementById("subscriptionStatus").value.toLowerCase();
        const rows = document.querySelectorAll("#subscriptionTable tbody tr");

        rows.forEach(row => {
            const publicationName = row.querySelector(".publication-name").textContent.toLowerCase();
            const subscriptionStatus = row.querySelector(".subscription-status").textContent.toLowerCase();

            const matchesPublication = publicationName.includes(filter);
            const matchesStatus = statusFilter === "all" || subscriptionStatus === statusFilter;

            row.style.display = matchesPublication && matchesStatus ? "" : "none";
        });
    }

    function printReceipts() {
        window.print();
    }

    function sendToEmail() {
        const uid = '<%= u != null ? u.getId() : "" %>';
        if (!uid) {
            alert("User ID is missing.");
            return;
        }
        fetch("EmailReceiptServlet?uid=" + uid)
            .then(response => response.text())
            .then(data => {
                alert(data);
            })
            .catch(error => {
                alert('Failed to send email');
            });
    }
</script>
</head>
<body>
    <%@ include file="includes/navbar.jsp" %>
    <%
    if (u != null) {
        PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());
        List<Subscriptions> subscriptions = dao.getSubscriptionById_Receipt(u.getId());
        
        if (subscriptions != null && !subscriptions.isEmpty()) {
    %>
    <h3 class="text-center text-danger"><%= u.getName() %>'s Receipts</h3>
    
    <div class="container mb-3">
        <div class="row">
            <div class="col-md-6">
                <label for="publicationName">Filter by Publication Name:</label>
                <input type="text" id="publicationName" class="form-control" onkeyup="filterTable()" placeholder="Enter publication name to filter">
            </div>
            <div class="col-md-6 text-right">
                <label for="subscriptionStatus">Filter by Subscription Status:</label>
                <select id="subscriptionStatus" class="form-control" onchange="filterTable()">
                    <option value="all">All</option>
                    <option value="active">Active</option>
                    <option value="on hold">On Hold</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
        </div>
        
        <div class="text-center mt-3">
            <button type="button" class="btn btn-success" onclick="printReceipts()">Print Receipts</button>
            <button type="button" class="btn btn-primary" onclick="sendToEmail()">Send to your email</button>
        </div>
    </div>

    <table class="table table-hover text-center" id="subscriptionTable">
        <thead class="bg-primary text-white">
            <tr> 
                <th>Subscription Id</th>
                <th>Publication Name</th>
                <th>Amount</th>
                <th>Payment Type</th>
                <th>Subscription Status</th>
                <th>Subscription Date</th>
                <th>Payment Status</th>
            </tr>
        </thead>
        <tbody>
            <%
            for (Subscriptions subscription : subscriptions) {
            %>
            <tr>
                <td><strong>SUB-ID-00-<%= subscription.getSid() %></strong></td>
                <td class="publication-name"><%= subscription.getPublicationName() %></td>
                <td><%= subscription.getAmount() %></td>
                <td><%= subscription.getPaymentType() %></td>
                <td class="subscription-status"><%= subscription.getSubscriptionStatus() %></td>
                <td><%= subscription.getStartDate() %></td>
                <td class="text-success"><%= subscription.getPaymentStatus() %></td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <div style="margin-top: 130px;">
		<%@include file="includes/footer.jsp"%>
	</div>
    <%
        } else {
            out.println("<h4 class='text-danger'>No Receipts found for the given User ID.</h4>");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
    %>
</body>
</html>

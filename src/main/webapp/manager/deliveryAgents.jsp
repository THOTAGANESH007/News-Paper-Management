<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.UserDAOImpl"%>
<%@page import="com.models.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delivery Agents</title>
<%@include file="cdns.jsp"%>
</head>
<body>
	<%@include file="navbar.jsp"%>
	<div class="container mt-5">
		<h2 class="text text-center text-danger">Delivery Agents List</h2>
		<table class="table table-hover mt-3 text-center">
			<thead class="bg-primary text-white">
				<tr>
					<th>Name</th>
					<th>Email</th>
					<th>Phone</th>
					<th>Areas Assigned</th>
				</tr>
			</thead>
			<tbody>
				<%
				UserDAOImpl dao = new UserDAOImpl(DBConnect.getConn());
				List<User> agents = dao.allDeliveryAgents();
				if (agents != null && !agents.isEmpty()) {
					for (User agent : agents) {
				%>
				<tr>
					<td><%=agent.getName()%></td>
					<td><%=agent.getEmail()%></td>
					<td><%=agent.getPhno()%></td>
					<td><%=agent.getAddress() %></td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="4" class="text-center">No delivery agents found.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>

<%@page import="com.db.DBConnect"%>
<%@page import="com.dao.PublicationDAOImpl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.models.Publications"%>
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

.card {
    width: 100%; /* Ensure cards take full width */
    min-height: 300px; /* Set a minimum height */
    margin: 15px; /* Adjust margin to create uniform spacing */
}

.card-body {
    padding: 20px; /* Adjust padding for consistent inner spacing */
}

.card-title, .card-text {
    overflow: hidden;
    white-space: nowrap; /* Prevent text wrapping */
    text-overflow: ellipsis; /* Add ellipsis for overflow text */
}

.card-img-top {
    width: 100%; /* Make images responsive */
    height: 300px; /* Set a fixed height */
    object-fit: cover;
    /* Ensure the image covers the area without stretching */
}
</style>
<meta charset="UTF-8">
<title>Search Results</title>
<%@include file="includes/cdns.jsp"%>
</head>
<body style="background-color: #f7f7f7;">
    <%@include file="includes/navbar.jsp"%>

    <div class="container-fluid">
        <h3 align="center">Search Results</h3>
        <div class="row">
            <%
            // Retrieve the search term
            String search = request.getParameter("searchQuery");
            if (search != null && !search.isEmpty()) {
                User u = (User) session.getAttribute("userObj");
                PublicationDAOImpl publicationDAO = new PublicationDAOImpl(DBConnect.getConn());
                
                // Get search results for both newspapers and magazines
                List<Publications> searchResults = publicationDAO.searchPublicationsByQuery(search);
                
                if (searchResults != null && !searchResults.isEmpty()) {
                    for (Publications b : searchResults) {
            %>
            <div class="col-md-3">
                <div class="card crd-ho" style="width: 18rem;">
                    <img class="card-img-top" src="publications/<%=b.getPhoto()%>"
                        alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title text-center"><%=b.getPublicationName()%></h5>
                        <p class="card-text">Author: <%=b.getAuthor()%></p>
                        <div class="row">
                            <%
                            if (u == null) {
                            %>
                            <a href="login.jsp" class="btn btn-danger btn-sm ml-2">Add to Cart</a>
                            <a href="viewDetails.jsp?pid=<%=b.getPid()%>" class="btn btn-success btn-sm ml-1">View Details</a>
                            <a href="login.jsp" class="btn btn-danger btn-sm ml-1"><i class="fas fa-rupee-sign"></i> <%=b.getPrice()%></a>
                            <%
                            } else {
                            %>
                            <a href="cartServlet?pid=<%=b.getPid()%>&uid=<%=u.getId()%>" class="btn btn-danger btn-sm ml-2">Add to Cart</a>
                            <a href="viewDetails.jsp?pid=<%=b.getPid()%>" class="btn btn-success btn-sm ml-1">View Details</a>
                            <a href="cartServlet?pid=<%=b.getPid()%>&uid=<%=u.getId()%>" class="btn btn-danger btn-sm ml-1"><i class="fas fa-rupee-sign"></i> <%=b.getPrice()%></a>
                            <%
                            }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12 text-center">
                <h5>No publications found matching "<%=search%>"</h5>
            </div>
            <%
                }
            } else {
            %>
            <div class="col-12 text-center">
                <h5>Please enter a search term.</h5>
            </div>
            <%
            }
            %>
        </div>
    </div>

    <%@include file="includes/footer.jsp"%>
</body>
</html>

package com.user.servlet;

import com.dao.PublicationDAOImpl;
import com.db.DBConnect;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ModifySubscriptionServlet")
public class ModifySubscriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		int sid = Integer.parseInt(request.getParameter("sid"));

		PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());

		if ("unsubscribe".equalsIgnoreCase(action)) {
			dao.updateSubscriptionStatus(sid, "Cancelled");
		} else if ("hold".equalsIgnoreCase(action)) {
			dao.updateSubscriptionStatus(sid, "On Hold");
		} else if ("unhold".equals(action)) {
			dao.updateSubscriptionStatus(sid, "Active");
		}

		response.sendRedirect("modifySubscription.jsp");
	}
}

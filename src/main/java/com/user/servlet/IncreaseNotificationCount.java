package com.user.servlet;

import java.io.IOException;

import com.dao.PublicationDAOImpl;
import com.db.DBConnect;
import com.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/increaseNotificationCount")

public class IncreaseNotificationCount extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// Get the user ID from the request
		int userId = Integer.parseInt(req.getParameter("userId"));

		// get the Session
		HttpSession session = req.getSession();

		// Get the DAO instance
		PublicationDAOImpl sdao = new PublicationDAOImpl(DBConnect.getConn());

		// Increase the notification count
		sdao.increaseNotificationCount(userId);

		// Set session attribute
		session.setAttribute("sent", "Notice Sent SuccessFully");

		// Redirect back to the same page or to notifications.jsp
		res.sendRedirect("manager/postNotices.jsp");
	}
}

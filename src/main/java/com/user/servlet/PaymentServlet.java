package com.user.servlet;

import java.io.IOException;

import com.dao.PublicationDAOImpl;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/processPayment")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// Get the current session, if one exists
		HttpSession session = req.getSession();

		// Get user ID and other parameters
		int uid = Integer.parseInt(req.getParameter("uid"));
		int sid=Integer.parseInt(req.getParameter("sid"));
		double amount = Double.parseDouble(req.getParameter("amount"));
		String chequeNo = req.getParameter("chequeNo");

		// Create DAO instance to handle database updates
		PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());

		// Update the payment status to "paid" and decrement daysCount by 30
		boolean isPaymentSuccessful = dao.updatePaymentStatus(uid,sid);

		// Set session attributes based on payment status
		if (isPaymentSuccessful) {
			session.setAttribute("SuccessMsg", "Payment processed successfully!");
			res.sendRedirect("paymentSuccess.jsp");
		} else {
			session.setAttribute("FailedMsg", "Payment failed! Please try again.");
			res.sendRedirect("paymentSuccess.jsp");
		}
	}
}

package com.manager.servlet;

import java.io.IOException;

import com.dao.UserDAOImpl;
import com.db.DBConnect;
import com.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addDeliveryAgent")
public class AddDeliveryAgent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {
			// Common fields for both users and delivery agents
			String uname = req.getParameter("uname");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			String password = req.getParameter("password");
			String category = req.getParameter("category");
			String areaAssigned = req.getParameter("areaAssigned");

			// Create a user object (update the User model to handle delivery agent fields)

			User user = new User(uname, email, password, phno, category);

			// Check for Delivery Agent's Area selection

			if (!areaAssigned.equalsIgnoreCase("noSelect")) {
				user.setAddress(areaAssigned);
			} else {
				session.setAttribute("FailedMsg", "Please Select the area !!!");
				res.sendRedirect("manager/addDeliveryAgent.jsp");
			}

			UserDAOImpl udao = new UserDAOImpl(DBConnect.getConn());

			boolean auth = false;
			// Register users differently based on the category
			if (category.equalsIgnoreCase("delivery")) {
				auth = udao.deliveryAgentRegister(user); // Use the delivery registration method

				if (auth) {
					// Registration successful
					session.setAttribute("SuccessMsg", "Registration Successful!!!");
					res.sendRedirect("manager/addDeliveryAgent.jsp");
				} else {
					// Registration failed
					session.setAttribute("FailedMsg", "Registration Failed!!!");
					res.sendRedirect("manager/addDeliveryAgent.jsp");
				}
			} else {
				session.setAttribute("FailedMsg", "Please Select the Option!!!");
				res.sendRedirect("manager/addDeliveryAgent.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("FailedMsg", "Something Went Wrong!!!"); // Error in DB or code
			res.sendRedirect("manager/addDeliveryAgent.jsp");

		} finally {
			// Ensure DB connection is closed
			DBConnect.destroy();
		}
	}
}

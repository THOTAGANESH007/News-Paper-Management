package com.user.servlet;

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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			HttpSession session = req.getSession();

			// Retrieve parameters
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			String category = req.getParameter("category");
			String enteredOtp = req.getParameter("otp");

			// Retrieve OTP from session
			String sessionOtp = (String) session.getAttribute("otp");
			//String manager_email = System.getenv("EMAIL_MANAGER"); --> manager email
			//String newsAgent_email = System.getenv("EMAIL_NEWSAGENT"); --> manager email
			//String delivery_email = System.getenv("EMAIL_DELIVERY"); --> manager email
			

			// Check if OTP matches for all the users
			
			/*if (sessionOtp == null || !sessionOtp.equals(enteredOtp)) {
				session.setAttribute("failedMsg", "Invalid OTP. Please try again.");
				res.sendRedirect("login.jsp");
				return;
			}*/
			
			
			// Initialize UserDAOImpl and User object
			UserDAOImpl udao = new UserDAOImpl(DBConnect.getConn());
			User auth = null;

			// Validate category selection and proceed with login logic
			if (!category.equals("noSelect")) {

				if ("manager@gmail.com".equals(email) && "password".equals(password) && "manager".equals(category)) {
					auth = new User();
					auth.setName("Manager");
					session.setAttribute("userObj", auth);
					res.sendRedirect("manager/home.jsp");

				} else if ("newsAgent@gmail.com".equals(email) && "password".equals(password)
						&& "newsAgent".equals(category)) {
					auth = new User();
					auth.setName("News Agent");
					session.setAttribute("userObj", auth);
					res.sendRedirect("newsAgent/home.jsp");

				} else if ("delivery".equals(category)) {
					// Delivery agent login
					auth = udao.deliveryAgentLogin(email, password);

					if (auth != null) {
						session.setAttribute("userObj", auth);
						res.sendRedirect("deliveryAgent/home.jsp");
					} else {
						session.setAttribute("failedMsg", "Email or Password Invalid!!!");
						res.sendRedirect("login.jsp");
					}

				} else {
					// Regular user login
					auth = udao.userLogin(email, password);

					if (auth != null) {
						
						// Check if OTP matches only for user
						if (sessionOtp == null || !sessionOtp.equals(enteredOtp)) {
							session.setAttribute("failedMsg", "Invalid OTP. Please try again.");
							res.sendRedirect("login.jsp");
							return;
						}
						
						
						session.setAttribute("userObj", auth);
						res.sendRedirect("index.jsp");
					} else {
						session.setAttribute("failedMsg", "Email or Password Invalid!!!");
						res.sendRedirect("login.jsp");
					}
				}

			} else {
				session.setAttribute("failedMsg", "Please Select Your Category!!!");
				res.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// Ensure DB connection is closed
			DBConnect.destroy();
		}
	}
}

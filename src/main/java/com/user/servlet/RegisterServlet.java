
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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
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

			// Create a user object (update the User model to handle delivery agent fields)

			User user = new User(uname, email, password, phno, category);

			UserDAOImpl udao = new UserDAOImpl(DBConnect.getConn());
			boolean checkUser = udao.checkUser(email);
			
			
			
			if (checkUser) {
				boolean auth = false;
				// Register users differently based on the category
				if (category.equalsIgnoreCase("user")) {
					auth = udao.userRegister(user); // Use the user registration method
					if (auth) {
						// Registration successful
						session.setAttribute("SuccessMsg", "Registration Successful!!!");
						res.sendRedirect("login.jsp");
					} else {
						// Registration failed
						session.setAttribute("FailedMsg", "Registration Failed!!!");
						res.sendRedirect("register.jsp");
					}
				} else {
					session.setAttribute("FailedMsg", "Please Select the Option!!!");
					res.sendRedirect("register.jsp");
				}

			} else {
				// User already exists
				session.setAttribute("FailedMsg", "User Already Exists, Please try with another Email!!!");
				res.sendRedirect("register.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("FailedMsg", "Something Went Wrong!!!"); // Error in DB or code
			res.sendRedirect("register.jsp");

		} finally {
			// Ensure DB connection is closed
			DBConnect.destroy();
		}
	}
}

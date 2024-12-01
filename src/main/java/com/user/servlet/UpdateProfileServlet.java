package com.user.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.dao.UserDAOImpl;
import com.db.DBConnect;
import com.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		try {
			String uname = req.getParameter("uname");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			String password = req.getParameter("password");
			int uid = Integer.parseInt(req.getParameter("uid"));

			// System.out.println(uname+email+phno+password);
			User user = new User();
			user.setName(uname);
			user.setEmail(email);
			user.setPhno(phno);
			user.setPassword(password);
			user.setId(uid);

			UserDAOImpl udao = new UserDAOImpl(DBConnect.getConn());
			boolean update = udao.updateProfile(user);
			if (update) {
				// out.println("Success!!!");
				session.setAttribute("UpdatedMsg", "Updation SuccessFul!!!");
				res.sendRedirect("editProfile.jsp");
			} else {
				// out.println("Failed!!!");
				session.setAttribute("FailedMsg", "Something Went Wrong!!!");
				res.sendRedirect("editProfile.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
            // Ensure DB connection is closed
            DBConnect.destroy();
        }
	}

}

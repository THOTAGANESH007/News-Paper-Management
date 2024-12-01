package com.manager.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.dao.PublicationDAOImpl;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/removePublications")
public class RemovePublications extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		try {
			int pid = Integer.parseInt(req.getParameter("pid"));
			String publicationName = req.getParameter("pname");
			String publicationType = req.getParameter("ptype");
			if ("noSelect".equals(publicationType)) {
				session.setAttribute("failedMsg", "Please Select the Publication Type!!!");
				return;
			}

			PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());
			boolean del = dao.DeletePublication(pid, publicationName, publicationType);
			out.print(del);
			if (del) {
				session.setAttribute("SuccessMsg", "Publication Deleted SuccessFully!!!");

			} else {
				session.setAttribute("FailedMsg", "Failed to delete");
			}
			res.sendRedirect("newsAgent/removePublications.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

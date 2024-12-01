package com.user.servlet;

import java.io.IOException;

import com.dao.CartDAOImpl;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/removePublication")
public class RemoveFromCart extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		try {
		int pid = Integer.parseInt(req.getParameter("pid"));
		int uid = Integer.parseInt(req.getParameter("uid"));
		int cid = Integer.parseInt(req.getParameter("cid"));
		CartDAOImpl cdao = new CartDAOImpl(DBConnect.getConn());
		boolean del = cdao.deleteBook(pid,uid,cid);
		
		if(del) {
			session.setAttribute("SuccessMsg", "Book Removed From Cart!!!");
			res.sendRedirect("cart.jsp");
		}else {
			session.setAttribute("FailedMsg", "Something Went Wrong!!!");
			res.sendRedirect("cart.jsp");
		}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
            // Ensure DB connection is closed
            DBConnect.destroy();
        }
		
	}

}

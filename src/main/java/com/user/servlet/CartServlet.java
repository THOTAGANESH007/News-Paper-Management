package com.user.servlet;

import java.io.IOException;

import com.dao.CartDAOImpl;
import com.dao.PublicationDAOImpl;
import com.db.DBConnect;
import com.models.Cart;
import com.models.Publications;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cartServlet")
public class CartServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			// PrintWriter out = res.getWriter();
			HttpSession session = req.getSession();
			
			int pid = Integer.parseInt(req.getParameter("pid"));
			int uid = Integer.parseInt(req.getParameter("uid"));
			PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());
			Publications pub = dao.getPublicationById(pid);
			Cart cart = new Cart();
			cart.setPid(pid);
			cart.setUid(uid);
			cart.setPublicationName(pub.getPublicationName());
			cart.setAuthor(pub.getAuthor());
			cart.setPrice(pub.getPrice());
			cart.setTotalPrice(pub.getPrice());
			
			CartDAOImpl cartDao = new CartDAOImpl(DBConnect.getConn());
			boolean bool= cartDao.addToCart(cart);
			if(bool) {
				session.setAttribute("addToCart","Book Added to Cart!!!");
				res.sendRedirect("cart.jsp");
				//out.println("Success!!!");
			}else {
				session.setAttribute("failedToAdd","Something Went Wrong!!!");
				res.sendRedirect("cart.jsp");
				//out.println("Failed!!!");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

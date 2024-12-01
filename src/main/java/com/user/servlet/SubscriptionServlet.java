package com.user.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.dao.CartDAOImpl;
import com.dao.PublicationDAOImpl;
import com.db.DBConnect;
import com.models.Cart;
import com.models.Subscriptions;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/subscriptions")
public class SubscriptionServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		try {
			int uid = Integer.parseInt(req.getParameter("uid"));
			String uname = req.getParameter("uname");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			String address = req.getParameter("address");

			String landMark = req.getParameter("landMark");
			String city = req.getParameter("city");
			String state = req.getParameter("state");
			String zip = req.getParameter("zip");
			String paymentType = req.getParameter("paymentType");

			String fullAddress = address + "," + landMark + "," + city + "," + state + "," + zip;

			// out.println(uname+email+phno+fullAddress+paymentType);

			CartDAOImpl cdao = new CartDAOImpl(DBConnect.getConn());
			List<Cart> clist = cdao.getBookByUser(uid);

			if (clist.isEmpty()) {
				session.setAttribute("failedToAdd", "Please Add an Item to the cart!!!"); // FailedMsg
				res.sendRedirect("cart.jsp");
			} else {

				Subscriptions order = null;
				ArrayList<Subscriptions> orderList = new ArrayList<Subscriptions>();

				for (Cart c : clist) {
					// out.print(c.getBookName()+c.getAuthor()+c.getPrice());
					order = new Subscriptions();
					order.setUid(uid);
					order.setCustomerName(uname);
					order.setEmail(email);
					order.setPhno(phno);
					order.setAddress(fullAddress);
					order.setPublicationName(c.getPublicationName());
					order.setAmount(c.getPrice());
					order.setPaymentType(paymentType);
					order.setLandMark(landMark);

					order.setStartDate(LocalDate.now()); // Set current date as
															// LocalDateorder.setPaymentStatus("Pending"); // Default
															// status
					order.setPaymentStatus("Pending"); // Default status
					order.setSubscriptionStatus("Active"); // Default subscription status

					orderList.add(order);
				}
				// out.print(orderList);
				if ("noselect".equals(paymentType)) {
					session.setAttribute("failedToAdd", "Please Choose Your Payment Gateway!!!"); // FailedMsg
					res.sendRedirect("cart.jsp");
				} else if ("noSelect".equals(landMark)) {
					session.setAttribute("failedToAdd", "Please Choose Your LandMark!!!"); // FailedMsg
					res.sendRedirect("cart.jsp");
				} else {
					PublicationDAOImpl pdao = new PublicationDAOImpl(DBConnect.getConn());
					boolean saveOrder = pdao.saveOrder(orderList);
					// out.println(saveOrder);
					if (saveOrder) {
						cdao.clearCartByUserId(uid);
						res.sendRedirect("orderSuccess.jsp");
						// out.print("OrderSuccess");
					} else {
						session.setAttribute("failedToAdd", "Something Went Wrong!!!"); // FailedMsg
						res.sendRedirect("cart.jsp");
						// out.print("OrderFailed");
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// Ensure DB connection is closed
			DBConnect.destroy();
		}
	}

}

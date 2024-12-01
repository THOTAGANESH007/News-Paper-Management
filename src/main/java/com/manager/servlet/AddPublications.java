package com.manager.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.db.DBConnect;
import com.dao.PublicationDAOImpl;

import com.models.Publications;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/addPublications")
@MultipartConfig
public class AddPublications extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			PrintWriter out = res.getWriter();
			HttpSession session = req.getSession();
			String publicationName = req.getParameter("pname");
			String author = req.getParameter("author");
			Double price = Double.parseDouble(req.getParameter("price"));
			String publicationType = req.getParameter("ptype");
			String publicationStatus = req.getParameter("status");
			String summary = req.getParameter("summary");
			Part part = req.getPart("bimg");
			String fileName = part.getSubmittedFileName();
			String fileType = part.getContentType();

			// Validate that the uploaded file is an image
			if (!fileType.startsWith("image/")) {

				session.setAttribute("FailedMsg", "Invalid file type! Please upload an image.");
				res.sendRedirect("manager/addPublications.jsp");
				return;
			}
			// Data is set to the respective variables
			Publications details = new Publications(publicationName, author, publicationType, price, publicationStatus,
					fileName, summary);
			// out.println(bDet.toString());
			PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());

			/*
			 * // To set the path of the uploaded image String path =
			 * getServletContext().getRealPath("") + "books"; out.println(path); // Java.io
			 * class File uploadDir = new File(path); if (!uploadDir.exists()) {
			 * uploadDir.mkdir(); // Creates the directory if it does not exist } // Store
			 * into that folder part.write(path + File.separator + fileName);
			 */

			boolean bool = dao.addPublications(details);
			if (bool) {
				String path = getServletContext().getRealPath("") + "publications";

				File uploadDir = new File(path);
				if (!uploadDir.exists()) {
					uploadDir.mkdir(); // Creates the directory if it does not exist
				}

				part.write(path + File.separator + fileName);

				session.setAttribute("SuccessMsg", "Publication Added Successfully!!!");
				res.sendRedirect("manager/addPublications.jsp");
			} else {
				session.setAttribute("FailedMsg", "Something Wrong on the Server!!!");
				res.sendRedirect("manager/addPublications.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

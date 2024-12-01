package com.user.servlet;

import java.io.IOException;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegistrationSuccessEmail")
public class RegistrationSuccessEmail extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		//Required Fields
        String toEmail = req.getParameter("email"); //User Email
        String fromEmail = System.getenv("EMAIL_USERNAME"); // Retrieve from environment
        String password = System.getenv("EMAIL_PASSWORD"); // Retrieve securely from environment
        String emailContent="Your Registration to NMS site is successful!!!";
        
        // Set mail properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Create a mail session
        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });
        
        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Your Subscription Receipt");
            message.setContent(emailContent.toString(), "text/html");

            Transport.send(message);
            res.getWriter().println("Email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace(); // Log the error
            res.getWriter().println("Failed to send email: " + e.getMessage());
        }
	}
	
	

}

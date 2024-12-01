package com.user.servlet;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import com.models.Subscriptions;
import com.models.User;
import com.dao.PublicationDAOImpl;
import com.db.DBConnect;

@WebServlet("/EmailReceiptServlet")
public class EmailReceiptServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID from the request parameter
        String uidParam = request.getParameter("uid");
        HttpSession session = request.getSession();
        if (uidParam != null) {
            int uid = Integer.parseInt(uidParam);
            User u = (User)session.getAttribute("userObj");
            // Fetch subscriptions for the user
            PublicationDAOImpl dao = new PublicationDAOImpl(DBConnect.getConn());
            List<Subscriptions> subscriptions = dao.getSubscriptionById_Receipt(uid);

            // Prepare email content
            StringBuilder emailContent = new StringBuilder();
            emailContent.append("<h3>Your Receipt Details</h3><table border='1'><tr><th>Subscription Id</th><th>Publication Name</th><th>Amount</th><th>Payment Type</th><th>Subscription Status</th><th>Subscription Date</th><th>Payment Status</th></tr>");
            
            for (Subscriptions subscription : subscriptions) {
                emailContent.append("<tr>")
                    .append("<td>SUB-ID-00-").append(subscription.getSid()).append("</td>")
                    .append("<td>").append(subscription.getPublicationName()).append("</td>")
                    .append("<td>").append(subscription.getAmount()).append("</td>")
                    .append("<td>").append(subscription.getPaymentType()).append("</td>")
                    .append("<td>").append(subscription.getSubscriptionStatus()).append("</td>")
                    .append("<td>").append(subscription.getStartDate()).append("</td>")
                    .append("<td>").append(subscription.getPaymentStatus()).append("</td>")
                    .append("</tr>");
            }
            emailContent.append("</table>");

            // Retrieve user's email from session
            String toEmail = u.getEmail(); 
            String fromEmail = System.getenv("EMAIL_USERNAME"); // Retrieve from environment
            String password = System.getenv("EMAIL_PASSWORD"); // Retrieve securely from environment

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
                response.getWriter().println("Email sent successfully to " + toEmail);
            } catch (MessagingException e) {
                e.printStackTrace(); // Log the error
                response.getWriter().println("Failed to send email: " + e.getMessage());
            }
        } else {
            response.getWriter().println("User ID is missing.");
        }
    }
}


package com.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.db.DBConnect;
import com.models.Publications;
import com.models.Subscriptions;
import java.time.LocalDate;

public class PublicationDAOImpl implements PublicationDAO {
	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;

	public PublicationDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	@Override
	public boolean addPublications(Publications det) {
		boolean bool = false;
		try {
			String query = "insert into publications (publicationName, author, publicationType, price, publicationStatus, photo, summary) values (?, ?, ?, ?, ?, ?, ?)";
			pst = this.conn.prepareStatement(query);

			pst.setString(1, det.getPublicationName());
			pst.setString(2, det.getAuthor());
			pst.setString(3, det.getPublicationType());
			pst.setDouble(4, det.getPrice());
			pst.setString(5, det.getPublicationStatus());
			pst.setString(6, det.getPhoto());
			pst.setString(7, det.getSummary());

			int result = pst.executeUpdate();
			if (result == 1)
				bool = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bool;
	}

	@Override
	public List<Subscriptions> allSubscriptions() {
		List<Subscriptions> list = new ArrayList<>();
		Subscriptions sub = null;
		try {
			String query = "select * from subscriptions";
			pst = this.conn.prepareStatement(query);
			rs = pst.executeQuery();

			while (rs.next()) {
				sub = new Subscriptions();
				sub.setSid(rs.getInt("sid"));
				sub.setUid(rs.getInt("uid"));
				sub.setCustomerName(rs.getString("customerName"));
				sub.setEmail(rs.getString("email"));
				sub.setPhno(rs.getString("phno"));
				sub.setAddress(rs.getString("address"));
				sub.setPublicationName(rs.getString("publicationName"));
				sub.setAmount(rs.getDouble("amount"));
				sub.setPaymentType(rs.getString("paymentType"));
				sub.setPaymentStatus(rs.getString("paymentStatus"));
				sub.setSubscriptionStatus(rs.getString("subscriptionStatus"));
				sub.setDaysCount(rs.getInt("daysCount"));

				// Fetch the 'startDate' from the result set
				Date startDate = rs.getDate("startDate"); // Assuming startDate column exists
				// Set startDate as LocalDate
				if (startDate != null) {
					sub.setStartDate(startDate.toLocalDate()); // Convert Date to LocalDate
				}

				// Add the subscription object to the list
				list.add(sub);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Subscriptions> getSubscriptionsByUid(int uid) {
	    List<Subscriptions> list = new ArrayList<>();
	    try {
	        String query = "SELECT * FROM subscriptions WHERE uid = ? AND subscriptionStatus IN ('Active', 'On Hold', 'Cancelled')";
	        pst = this.conn.prepareStatement(query);
	        pst.setInt(1, uid);
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            Subscriptions sub = new Subscriptions();
	            sub.setSid(rs.getInt("sid"));
	            sub.setUid(rs.getInt("uid"));
	            sub.setCustomerName(rs.getString("customerName"));
	            sub.setEmail(rs.getString("email"));
	            sub.setPhno(rs.getString("phno"));
	            sub.setAddress(rs.getString("address"));
	            sub.setPublicationName(rs.getString("publicationName"));
	            sub.setAmount(rs.getDouble("amount"));
	            sub.setPaymentType(rs.getString("paymentType"));
	            sub.setPaymentStatus(rs.getString("paymentStatus"));
	            sub.setSubscriptionStatus(rs.getString("subscriptionStatus"));
	            sub.setDaysCount(rs.getInt("daysCount"));

	            // Set startDate as LocalDate
	            Date startDate = rs.getDate("startDate");
	            if (startDate != null) {
	                sub.setStartDate(startDate.toLocalDate()); // Convert Date to LocalDate
	            }

	            list.add(sub);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}


	@Override
	public boolean updatePaymentStatus(int uid,int sid) {
		boolean result = false;
		try {
			String query = "UPDATE subscriptions SET paymentStatus = 'paid', daysCount = daysCount - 30 WHERE uid = ? and sid=?";
			pst = conn.prepareStatement(query);
			pst.setInt(1, uid);
			pst.setInt(2,sid);
			int updatedRows = pst.executeUpdate();
			if (updatedRows > 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Publications> getAllNewsPapers() {
		List<Publications> publicationsList = new ArrayList<>();
		try {
			String query = "SELECT * FROM publications WHERE publicationType = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, "newsPaper");
			rs = pst.executeQuery();

			while (rs.next()) {
				Publications publication = new Publications();
				publication.setPid(rs.getInt("pid"));
				publication.setPublicationName(rs.getString("publicationName"));
				publication.setAuthor(rs.getString("author"));
				publication.setPublicationType(rs.getString("publicationType"));
				publication.setPrice(rs.getDouble("price"));
				publication.setPublicationStatus(rs.getString("publicationStatus"));
				publication.setPhoto(rs.getString("photo"));
				publication.setSummary(rs.getString("summary"));

				publicationsList.add(publication);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return publicationsList;
	}

	@Override
	public List<Publications> getAllMagazines() {
		List<Publications> magazinesList = new ArrayList<>();
		try {
			String query = "SELECT * FROM publications WHERE publicationType = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, "magazine"); // Set the publication type parameter to 'magazine'
			rs = pst.executeQuery();

			while (rs.next()) {
				Publications publication = new Publications();
				publication.setPid(rs.getInt("pid"));
				publication.setPublicationName(rs.getString("publicationName"));
				publication.setAuthor(rs.getString("author"));
				publication.setPublicationType(rs.getString("publicationType"));
				publication.setPrice(rs.getDouble("price"));
				publication.setPublicationStatus(rs.getString("publicationStatus"));
				publication.setPhoto(rs.getString("photo"));
				publication.setSummary(rs.getString("summary"));

				magazinesList.add(publication);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return magazinesList;
	}

	@Override
	public List<Publications> getRecentNewsPapers() {
		List<Publications> recentNewsPapersList = new ArrayList<>();
		try {
			String query = "SELECT * FROM publications WHERE publicationType = ? ORDER BY pid DESC LIMIT 4"; // Limit to
																												// 4
																												// newspapers
			pst = this.conn.prepareStatement(query);
			pst.setString(1, "newsPaper"); // Set the publication type parameter to 'newsPaper'
			rs = pst.executeQuery();

			while (rs.next()) {
				Publications publication = new Publications();
				publication.setPid(rs.getInt("pid"));
				publication.setPublicationName(rs.getString("publicationName"));
				publication.setAuthor(rs.getString("author"));
				publication.setPublicationType(rs.getString("publicationType"));
				publication.setPrice(rs.getDouble("price"));
				publication.setPublicationStatus(rs.getString("publicationStatus"));
				publication.setPhoto(rs.getString("photo"));
				publication.setSummary(rs.getString("summary"));

				recentNewsPapersList.add(publication);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return recentNewsPapersList;
	}

	@Override
	public List<Publications> getRecentMagazines() {
		List<Publications> recentMagazinesList = new ArrayList<>();
		try {
			String query = "SELECT * FROM publications WHERE publicationType = ? ORDER BY pid DESC LIMIT 4"; // Limit to
																												// 4
																												// magazines
			pst = this.conn.prepareStatement(query);
			pst.setString(1, "magazine"); // Set the publication type parameter to 'magazine'
			rs = pst.executeQuery();

			while (rs.next()) {
				Publications publication = new Publications();
				publication.setPid(rs.getInt("pid"));
				publication.setPublicationName(rs.getString("publicationName"));
				publication.setAuthor(rs.getString("author"));
				publication.setPublicationType(rs.getString("publicationType"));
				publication.setPrice(rs.getDouble("price"));
				publication.setPublicationStatus(rs.getString("publicationStatus"));
				publication.setPhoto(rs.getString("photo"));
				publication.setSummary(rs.getString("summary"));

				recentMagazinesList.add(publication);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return recentMagazinesList;
	}

	public Publications getPublicationById(int id) {
		Publications publication = null;
		String query = "SELECT * FROM publications WHERE pid = ?";

		try {
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();

			if (rs.next()) {
				publication = new Publications();
				publication.setPid(rs.getInt("pid"));
				publication.setPublicationName(rs.getString("publicationName"));
				publication.setAuthor(rs.getString("author"));
				publication.setPublicationType(rs.getString("publicationType"));
				publication.setPrice(rs.getDouble("price"));
				publication.setPublicationStatus(rs.getString("publicationStatus"));
				publication.setPhoto(rs.getString("photo"));
				publication.setSummary(rs.getString("summary"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return publication;
	}

	public boolean saveOrder(List<Subscriptions> blist) {
		boolean order = false;

		try (Connection conn = DBConnect.getConn();
				PreparedStatement pst = conn.prepareStatement(
						"insert into subscriptions(sid, uid, customerName, email, phno, address, publicationName, amount, paymentType, startDate, paymentStatus, subscriptionStatus, daysCount,landMark) "
								+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)")) {
			conn.setAutoCommit(false);

			for (Subscriptions b : blist) {
				pst.setInt(1, b.getSid());
				pst.setInt(2, b.getUid());
				pst.setString(3, b.getCustomerName() != null ? b.getCustomerName() : "");
				pst.setString(4, b.getEmail() != null ? b.getEmail() : "");
				pst.setString(5, b.getPhno() != null ? b.getPhno() : "");
				pst.setString(6, b.getAddress() != null ? b.getAddress() : "");
				pst.setString(7, b.getPublicationName() != null ? b.getPublicationName() : "");
				pst.setDouble(8, b.getAmount());
				pst.setString(9, b.getPaymentType() != null ? b.getPaymentType() : "");

				// Set date values for startDate
				if (b.getStartDate() != null) {
					pst.setDate(10, Date.valueOf(b.getStartDate()));
				} else {
					pst.setNull(10, java.sql.Types.DATE);
				}

				pst.setString(11, b.getPaymentStatus() != null ? b.getPaymentStatus() : "");
				pst.setString(12, b.getSubscriptionStatus() != null ? b.getSubscriptionStatus() : "");
				pst.setInt(13, b.getDaysCount());
				pst.setString(14, b.getLandMark());

				pst.addBatch();
			}

			int[] count = pst.executeBatch();
			conn.commit();
			order = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return order;
	}

	public List<Subscriptions> getSubscriptionsByUser(String email) {
		List<Subscriptions> subscriptionsList = new ArrayList<>();
		Subscriptions sub = null;

		try {
			String query = "SELECT * FROM subscriptions WHERE email = ?";
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, email);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				sub = new Subscriptions();
				sub.setSid(rs.getInt("sid")); // Assuming sid is an int
				sub.setUid(rs.getInt("uid")); // Assuming uid is an int
				sub.setCustomerName(rs.getString("customerName"));
				sub.setEmail(rs.getString("email"));
				sub.setPhno(rs.getString("phno"));
				sub.setAddress(rs.getString("address"));
				sub.setPublicationName(rs.getString("publicationName"));
				sub.setAmount(rs.getDouble("amount"));
				sub.setPaymentType(rs.getString("paymentType"));
				sub.setStartDate(rs.getDate("startDate").toLocalDate()); // Convert SQL Date to LocalDate
				sub.setPaymentStatus(rs.getString("paymentStatus"));
				sub.setSubscriptionStatus(rs.getString("subscriptionStatus"));
				sub.setDaysCount(rs.getInt("daysCount"));

				// Add the subscription to the list
				subscriptionsList.add(sub);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return subscriptionsList;
	}

	public boolean updateAddress(String fullAddress, String email) {
		boolean update = false;

		try {
			String query = "update subscriptions set address=? where email=?";
			PreparedStatement pst = conn.prepareStatement(query);
			// System.out.print(fullAddress+email);
			pst.setString(1, fullAddress);
			pst.setString(2, email);

			int result = pst.executeUpdate();
			if (result == 1)
				update = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnect.destroy();
		}
		return update;
	}

	public List<Subscriptions> getSubscriptionById_Receipt(int uid) {
		List<Subscriptions> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM subscriptions WHERE uid = ? and paymentStatus = ? and subscriptionStatus IN ('Active', 'On Hold', 'Cancelled')";
			pst = this.conn.prepareStatement(query);
			pst.setInt(1, uid);
			pst.setString(2, "Paid");
			rs = pst.executeQuery();

			while (rs.next()) {
				Subscriptions sub = new Subscriptions();
				sub.setSid(rs.getInt("sid"));
				sub.setUid(rs.getInt("uid"));
				sub.setCustomerName(rs.getString("customerName"));
				sub.setEmail(rs.getString("email"));
				sub.setPhno(rs.getString("phno"));
				sub.setAddress(rs.getString("address"));
				sub.setPublicationName(rs.getString("publicationName"));
				sub.setAmount(rs.getDouble("amount"));
				sub.setPaymentType(rs.getString("paymentType"));
				sub.setPaymentStatus(rs.getString("paymentStatus"));
				sub.setSubscriptionStatus(rs.getString("subscriptionStatus"));
				sub.setDaysCount(rs.getInt("daysCount"));

				// Set startDate as LocalDate
				Date startDate = rs.getDate("startDate");
				if (startDate != null) {
					sub.setStartDate(startDate.toLocalDate()); // Convert Date to LocalDate
				}

				list.add(sub);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updateSubscriptionStatus(int sid, String status) {
		boolean result = false;
		try {
			String query = "UPDATE subscriptions SET subscriptionStatus=? WHERE sid=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, status);
			ps.setInt(2, sid);

			int i = ps.executeUpdate();
			if (i == 1) {
				result = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	/*public boolean updateSubscriptionStatusUnsubscribe(int sid, String status) {
	    boolean result = false;
	    try {
	        String query = "DELETE FROM subscriptions WHERE subscriptionStatus=? AND sid=?";
	        PreparedStatement ps = conn.prepareStatement(query);
	        ps.setString(1, status);
	        ps.setInt(2, sid);

	        int i = ps.executeUpdate();
	        if (i == 1) {
	            result = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}*/

	

	// Method to increase notification count for the user
	public void increaseNotificationCount(int userId) {
		try {
			String query = "UPDATE users SET notificationCount = notificationCount + 1 WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, userId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Method to fetch the current notification count for the user
	public int getNotificationCount(int userId) {
		int count = 0;
		try {
			String query = "SELECT notificationCount FROM users WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("notificationCount");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public String getNotificationText(int userId) {
		String text=null;
		try {
			String query = "SELECT text FROM users WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				text = rs.getString("text");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return text;	
		
	}
	
	public List<Publications> searchPublicationsByQuery(String searchQuery) {
	    List<Publications> list = new ArrayList<>();
	    try {
	        String query = "SELECT * FROM publications WHERE publicationName LIKE ? OR author LIKE ?";
	        PreparedStatement ps = conn.prepareStatement(query);
	        ps.setString(1, "%" + searchQuery + "%");
	        ps.setString(2, "%" + searchQuery + "%");

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            Publications p = new Publications();
	            p.setPid(rs.getInt("pid"));
	            p.setPublicationName(rs.getString("publicationName"));
	            p.setAuthor(rs.getString("author"));
	            p.setPublicationType(rs.getString("publicationType"));
	            p.setPrice(rs.getDouble("price"));
	            p.setPublicationStatus(rs.getString("publicationStatus"));
	            p.setPhoto(rs.getString("photo"));
	            p.setSummary(rs.getString("summary"));
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	@Override
	public boolean DeletePublication(int pid, String publicationName, String publicationType) {
	    boolean del = false;
	    try {
	        String query = "DELETE FROM publications WHERE pid = ? AND publicationName = ? AND publicationType = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, pid);
	        pstmt.setString(2, publicationName);
	        pstmt.setString(3, publicationType);

	        int isDel = pstmt.executeUpdate();
	        if (isDel == 1) {
	            del = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return del;
	}


	
	
}

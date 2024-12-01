package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.models.DeliveryAgent;
import com.models.User;

public class UserDAOImpl implements UserDAO {
	private PreparedStatement pst;
	private ResultSet rs;
	private Connection conn;

	public UserDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	@Override
	public boolean userRegister(User user) {
		boolean register = false;
		try {
			String query = "insert into users(name,email,phno,password,category) values(?,?,?,?,?)";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPhno());
			pst.setString(4, user.getPassword());
			pst.setString(5, user.getCategory());

			int result = pst.executeUpdate();

			if (result == 1)
				register = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return register;
	}

	@Override
	public boolean deliveryAgentRegister(User user) {
		boolean register = false;
		try {
			String query = "insert into deliveryAgent(name,email,phno,password,areaAssigned) values(?,?,?,?,?)";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPhno());
			pst.setString(4, user.getPassword());
			pst.setString(5, user.getAddress());

			int result = pst.executeUpdate();

			if (result == 1)
				register = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return register;
	}

	@Override
	public User userLogin(String email, String password) {
		User user = null;
		try {
			String query = "SELECT * FROM users WHERE email = ? and password = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			while (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setPhno(rs.getString("phno"));
				user.setAddress(rs.getString("address"));
				user.setCategory(rs.getString("category"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public User deliveryAgentLogin(String email, String password) {
		User deliver = null;
		try {
			String query = "SELECT * FROM deliveryAgent WHERE email = ? and password = ?";
			pst = this.conn.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			while (rs.next()) {
				deliver = new User();
				deliver.setId(rs.getInt("did"));
				deliver.setName(rs.getString("name"));
				deliver.setEmail(rs.getString("email"));
				deliver.setPassword(rs.getString("password"));
				deliver.setPhno(rs.getString("phno"));
				deliver.setAddress(rs.getString("areaAssigned"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return deliver;
	}

	public boolean checkUser(String email) {
		boolean bool = true;
		try {
			String query = "select * from users where email=?";
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, email);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				bool = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return bool;
	}

	public boolean updateProfile(User user) {
		boolean update = false;

		try {
			String query = "update users set name=?,email=?,phno=?,password=? where id=?";
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPhno());
			pst.setString(4, user.getPassword());
			pst.setInt(5, user.getId());
			int result = pst.executeUpdate();
			if (result == 1)
				update = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return update;
	}

	@Override
	public List<User> allDeliveryAgents() {
	    List<User> list = new ArrayList<User>();
	    User deliver = null;
	    try {
	        // Use GROUP_CONCAT to concatenate areaAssigned values
	        String query = "SELECT name, email, phno, GROUP_CONCAT(areaAssigned SEPARATOR ', ') AS areas "
	                     + "FROM deliveryAgent "
	                     + "GROUP BY name, email, phno";
	        pst = this.conn.prepareStatement(query);
	        rs = pst.executeQuery();
	        while (rs.next()) {
	            deliver = new User();
	            deliver.setName(rs.getString("name"));
	            deliver.setEmail(rs.getString("email"));
	            deliver.setPhno(rs.getString("phno"));
	            // Get the concatenated areas assigned
	            String areas = rs.getString("areas");
	            
	            deliver.setAddress(areas);
	            list.add(deliver);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}


}

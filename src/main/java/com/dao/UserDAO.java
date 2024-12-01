package com.dao;

import java.util.List;

import com.models.User;

public interface UserDAO {

	public boolean userRegister(User user);

	public boolean deliveryAgentRegister(User user);

	public User userLogin(String email, String password);

	public User deliveryAgentLogin(String email, String password);

	public boolean checkUser(String email);

	public boolean updateProfile(User user);
	
	public List<User> allDeliveryAgents();
}

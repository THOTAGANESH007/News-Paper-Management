package com.dao;

import java.util.List;

import com.models.Cart;

public interface CartDAO {

	public boolean addToCart(Cart c);

	public List<Cart> getBookByUser(int userId);

	public boolean deleteBook(int pid, int uid, int cid);

	public void clearCartByUserId(int userId);
}

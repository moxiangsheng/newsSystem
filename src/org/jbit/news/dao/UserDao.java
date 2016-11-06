package org.jbit.news.dao;


import org.jbit.news.entity.User;

public interface UserDao{
	//查找是否登录成功
	public User findUser(String uname, String password);		 
}
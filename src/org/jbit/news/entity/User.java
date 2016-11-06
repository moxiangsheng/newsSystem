package org.jbit.news.entity;

/*
 * �û� ʵ����
 * @author
 */


public class User {
	
	private String uid;
	private String uname;
	private String upwd;

	public void setUid(String uid) {
		this.uid = uid;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}

	public String getUid() {
		return uid;
	}

	public String getUname() {
		return uname;
	}

	public String getUpwd() {
		return upwd;
	}
}

package org.jbit.news.entity;

/*
 * 评论  实体类
 * @author 
 **/


public class Comment {
	
	private String cid;
	private String cnid;
	private String ccontent;
	private String cdate;
	private String cip;
	private String cauthor;

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getCnid() {
		return cnid;
	}

	public void setCnid(String cnid) {
		this.cnid = cnid;
	}

	public String getCcontent() {
		return ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	public String getCdate() {
		return cdate;
	}

	public void setCdate(String cdate) {
		this.cdate = cdate;
	}

	public String getCip() {
		return cip;
	}

	public void setCip(String cip) {
		this.cip = cip;
	}

	public String getCauthor() {
		return cauthor;
	}

	public void setCauthor(String cauthor) {
		this.cauthor = cauthor;
	}
}

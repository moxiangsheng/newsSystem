package org.jbit.news.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.jbit.news.dao.BaseDao;
import org.jbit.news.dao.UserDao;
import org.jbit.news.entity.User;

public class UserDaoImpl extends BaseDao implements UserDao {
	
	public User findUser(String uname, String password) {
		Connection con=getConnection();
		PreparedStatement ps=null;
		User user=null;
		//获取所有主题
		String sql = "select * from NEWS_USERS where uname=? and upwd=?";
		try{			
			ps = con.prepareStatement(sql);			
			ps.setString(1,uname);
			ps.setString(2,password);
			rs = ps.executeQuery();	
			if(rs.next()){
				user= new User();
				user.setUid(rs.getString("uid"));
				user.setUname(uname);
				user.setUpwd(password);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeAll(con, ps,  rs);
		}		
		return user;
	}	
}

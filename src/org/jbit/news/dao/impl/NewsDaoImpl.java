package org.jbit.news.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import org.jbit.news.dao.BaseDao;
import org.jbit.news.dao.CommentsDao;
import org.jbit.news.dao.NewsDao;
import org.jbit.news.entity.Comment;
import org.jbit.news.entity.News;

public class NewsDaoImpl extends BaseDao implements NewsDao {
	public List<News> getAllnews() {
		Connection con = getConnection();
		PreparedStatement ps = null;
		List<News> list = new ArrayList<News>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		// 获取所有新闻
		String sql = "select * from news,topic where news.ntid = topic.tid order by ncreatedate desc";
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				News news = new News();
				news.setNid(String.valueOf(rs.getObject("nid")));
				news.setNtid(String.valueOf(rs.getObject("ntid")));
				news.setNtitle((String) rs.getObject("ntitle"));
				news.setNauthor((String) rs.getObject("nauthor"));
				news.setNcontent((String) rs.getObject("ncontent"));
				news.setNcreatedate(sdf.format(rs.getTimestamp("NCREATEDATE")));
				news.setNtname(String.valueOf(rs.getObject("tname")));
				list.add(news);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(con, ps, rs);
		}
		return list;
	}

	public List<News> getAllnewsByTID(int Tid) {
		Connection con = getConnection();
		PreparedStatement ps = null;
		List<News> list = new ArrayList<News>();
		// 获取某主题下的所有新闻
		String sql = "select * from news  where ntid = ? order by ncreatedate desc";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, Tid);
			rs = ps.executeQuery();
			while (rs.next()) {
				News news = new News();
				news.setNid(String.valueOf(rs.getObject("nid")));
				news.setNtid(String.valueOf(rs.getObject("ntid")));
				news.setNtitle((String) rs.getObject("ntitle"));
				news.setNauthor((String) rs.getObject("nauthor"));
				news.setNcontent((String) rs.getObject("ncontent"));
				news.setNcreatedate(sdf.format(rs.getTimestamp("NCREATEDATE")));
				news.setNtname(String.valueOf(rs.getObject("ntitle")));
				list.add(news);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(con, ps, rs);
		}
		return list;
	}

	public List<News> getAllnewsByTName(String Tname) {
		Connection con = getConnection();
		PreparedStatement ps = null;
		List<News> list = new ArrayList<News>();
		// 获取某主题下的所有新闻
		String sql = "select * from topic ,news where topic.tid = news.ntid and topic.tname=?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, Tname);
			rs = ps.executeQuery();
			while (rs.next()) {
				News news = new News();
				news.setNid(String.valueOf(rs.getObject("nid")));
				news.setNtid(String.valueOf(rs.getObject("ntid")));
				news.setNtitle((String) rs.getObject("ntitle"));
				news.setNauthor((String) rs.getObject("nauthor"));
				news.setNcontent((String) rs.getObject("ncontent"));
				news.setNtname(String.valueOf(rs.getObject("ntitle")));
				list.add(news);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(con, ps, rs);
		}
		return list;
	}

	public News getNewsByNID(int Nid) {
		Connection con = getConnection();
		PreparedStatement ps = null;
		// 获取某条新闻
		String sql = "select * from news  where nid = ? ";
		News news = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, Nid);
			rs = ps.executeQuery();
			if (rs.next()) {
				news = new News();
				news.setNid(String.valueOf(rs.getObject("nid")));
				news.setNtid(String.valueOf(rs.getObject("ntid")));
				news.setNtitle((String) rs.getObject("ntitle"));
				news.setNsummary((String) rs.getObject("NSUMMARY"));
				news.setNauthor((String) rs.getObject("nauthor"));
				news.setNcontent((String) rs.getObject("ncontent"));
				news.setNcreatedate(sdf.format(rs.getTimestamp("NCREATEDATE")));
				news.setNtname(String.valueOf(rs.getObject("ntitle")));
			}
			CommentsDao commentsDao = new CommentsDaoImpl();
			List<Comment> comments = commentsDao.getCommentsByNid(String
					.valueOf(Nid));
			news.setComments(comments);// 设置此新闻下的所有评论
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(con, ps, rs);
		}
		return news;
	}

	// 删除新闻
	public int deleteNews(String nid) {
		String sql = "delete from news where nid = ?"; // 删除此新闻
		return exceuteUpdate(sql, new Object[] { Integer.valueOf(nid) });
	}

	// 获取所有新闻数目
	public int countNews(String Tid) {
		Connection con = getConnection();
		PreparedStatement ps = null;
		int count = 0;
		String sql ="";
		// 获取所有新闻数目
		if(Tid==null){
			sql = "select count(*) from news";
		}else{
			sql = "select count(*) from news where ntid="+Integer.valueOf(Tid);
		}		
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(con, ps, rs);
		}
		return count;
	}

	// 通过分页获取所有新闻
	public List<News> getAllnewsByPage(int Tid,int page_info_no, int page_no){
		Connection con=getConnection();
		PreparedStatement ps=null;
		List<News> list=new ArrayList<News>();		
		//获取所有新闻数目
			String sql = "select top "+page_info_no+" * "
				+ "from news,topic"
				+ " where news.ntid = topic.tid and ntid="+Tid+" and nid not in( select top "
				+ (page_info_no*(page_no-1))
				+" nid from news,topic where news.ntid = topic.tid and ntid="+Tid+"order by news.ncreatedate desc)"
				+" order by news.ncreatedate desc";	
		try{			
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();	
			while(rs.next()){
				News news = new News();
				news.setNcontent( rs.getString("ncontent"));
				news.setNsummary( rs.getString("nsummary"));	
				news.setNid( String.valueOf(rs.getObject("nid")));
				news.setNtid(String.valueOf(rs.getObject("ntid")));
				news.setNtitle(rs.getString("ntitle"));
				news.setNauthor( rs.getString("nauthor"));
				news.setNtname( rs.getString("tname"));				
				news.setNcreatedate( rs.getString("ncreatedate"));
				news.setNpicpath(rs.getString("npicpath"));								
				list.add(news);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeAll(con, ps,  rs);
		}		
		return list;		
	}
	
    //添加新闻
	public int addNews(News news) {			
		String sql = "insert into news(NTID,NTITLE,NAUTHOR,NCONTENT,NSUMMARY,NCREATEDATE,NMODIFYDATE,NPICPATH) values(?,?,?,?,?,getdate(),getdate(),?)";		
				return exceuteUpdate(sql,new Object[]{news.getNtid(),news.getNtitle(),news.getNauthor()
						,news.getNcontent(),news.getNsummary(),news.getNpicpath()});		
	}

	//编辑新闻
	public int updateNews(News news) {		
		String sql = "update news set NTID=?,NTITLE=?,NAUTHOR=?,NCONTENT=?,NSUMMARY=?,NCREATEDATE=getdate(),NMODIFYDATE=getdate(),NPICPATH=? "
				+ "where nid = ?" ;	
		return exceuteUpdate(sql,new Object[]{news.getNtid(),news.getNtitle(),news.getNauthor()
				,news.getNcontent(),news.getNsummary(),news.getNpicpath(),news.getNid()});
	}
}

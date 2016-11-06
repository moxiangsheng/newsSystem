package org.jbit.news.biz.impl;

import java.util.List;

import org.jbit.news.biz.CommentsBiz;
import org.jbit.news.biz.NewsBiz;
import org.jbit.news.dao.NewsDao;
import org.jbit.news.dao.impl.NewsDaoImpl;
import org.jbit.news.entity.News;

public class NewsBizImpl implements NewsBiz {

	// 删除某条新闻
	public int deleteNews(String nid) {
		CommentsBiz commentsBiz = new CommentsBizImpl();
		commentsBiz.delCommentsByCNID(nid);// 删除此新闻下的所有评论
		NewsDao newsDao = new NewsDaoImpl();
		// 判断此新闻
		if (newsDao.deleteNews(nid) > 0) {
			return 1; // 删除成功
		} else {
			return -1; // 删除失败
		}
	}
    // 添加新闻
	public int addNews(News news) {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.addNews(news);
	}
	
	// 获取某条新闻
	public News getNewsByNID(int Nid) {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.getNewsByNID(Nid);
	}

	// 获取所有新闻
	public List<News> getAllnews() {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.getAllnews();
	}

	// 获取某主题下的所有新闻
	public List<News> getAllnewsByTID(int Tid) {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.getAllnewsByTID(Tid);
	}

	// 获取某主题下的所有新闻
	public List<News> getAllnewsByTName(String Tname) {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.getAllnewsByTName(Tname);
	}

	// 返回新闻数目
	public int countNews(String Tid) {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.countNews(Tid);
	}

	// 通过分页获取所有新闻
	public List<News> getAllnewsByPage(int Tid,int page_info_no, int page_no) {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.getAllnewsByPage(Tid,page_info_no, page_no);
	}
	//编辑新闻
	public int updateNews(News news) {
		NewsDao newsDao = new NewsDaoImpl();
		return newsDao.updateNews(news);
	}
}

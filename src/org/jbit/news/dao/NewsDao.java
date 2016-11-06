package org.jbit.news.dao;

import java.util.List;

import org.jbit.news.entity.News;

public interface NewsDao{
	//获取所有新闻
	public List<News> getAllnews();	
	//获取某主题下的所有新闻
	public List<News> getAllnewsByTID(int Tid);	
	//获取某主题下的所有新闻
	public List<News> getAllnewsByTName(String Tname);	
	//获取某条新闻
	public News getNewsByNID(int Nid);
    //删除某条新闻
	public int deleteNews(String nid);
	//返回新闻数目
    public int countNews(String Tid);
	//通过分页获取所有新闻
	public List<News> getAllnewsByPage(int Tid,int page_info_no, int page_no);
	//添加新闻
	public int addNews(News news);
	//编辑新闻
	public int updateNews(News news);
}
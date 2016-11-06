package org.jbit.news.biz.impl;

import java.util.List;
import java.util.Map;

import org.jbit.news.biz.TopicsBiz;
import org.jbit.news.dao.NewsDao;
import org.jbit.news.dao.TopicsDao;
import org.jbit.news.dao.impl.NewsDaoImpl;
import org.jbit.news.dao.impl.TopicsDaoImpl;
import org.jbit.news.entity.Topic;

public class TopicsBizImpl implements TopicsBiz {
	
	//获取所有主题
	public List<Topic> getAllTopics() {
		TopicsDao topicsDao=new TopicsDaoImpl();
		return topicsDao.getAllTopics();
	}

	//更新所有主题
	public int updateTopic(Map<String,String> topic) {
		TopicsDao topicsDao=new TopicsDaoImpl();
		return topicsDao.updateTopic(topic);
	}

	//根据名字查找主题
	public Topic findTopicByName(String name) {
		TopicsDao topicsDao=new TopicsDaoImpl();
		return topicsDao.findTopicByName(name);
	}

	//添加主题
	public int addTopic(String name) {
		TopicsDao topicsDao=new TopicsDaoImpl();
		return topicsDao.addTopic(name);
	}

	//通过tid删除主题
	public int deleteTopic(String tid) {
		NewsDao newsDao=new NewsDaoImpl();
		TopicsDao topicsDao=new TopicsDaoImpl();
		//判断此主题下是否有文章
		if(newsDao.getAllnewsByTID(Integer.valueOf(tid)).size()<=0){
			if(topicsDao.deleteTopic(tid)>0){
				return 1;	//删除成功
	        }else{
	        	return -1;  //删除失败
	        }
		}else{
			return 0;    //该主题下有文章
	    }
	}
}

package org.jbit.news.biz.impl;

import org.jbit.news.biz.CommentsBiz;
import org.jbit.news.dao.CommentsDao;
import org.jbit.news.dao.impl.CommentsDaoImpl;
import org.jbit.news.entity.Comment;

public class CommentsBizImpl implements CommentsBiz {

	//删除某新闻下的所有评论
	public int delCommentsByCNID(String nid) {
		 CommentsDao commentsDao=new CommentsDaoImpl();
		 return commentsDao.delCommentsByCNID(nid);
	}

	public int addComment(Comment comment) {
		CommentsDao commentsDao=new CommentsDaoImpl();
		return commentsDao.addComment(comment);
	}
	//根据ID删除评论
	public int deleteComment(String cid){
		CommentsDao commentsDao=new CommentsDaoImpl();
		return commentsDao.deleteComment(cid);
	}
}

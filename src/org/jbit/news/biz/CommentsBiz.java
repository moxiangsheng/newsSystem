package org.jbit.news.biz;

import org.jbit.news.entity.Comment;

public interface CommentsBiz {
	//删除某新闻下的所有评论
	public int delCommentsByCNID(String nid);
	//添加评论
	public int addComment(Comment comment);
	//根据ID删除评论
	public int deleteComment(String cid);
}

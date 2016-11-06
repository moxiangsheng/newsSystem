package org.jbit.news.dao;

import java.util.List;

import org.jbit.news.entity.Comment;

public interface CommentsDao{
	//通过nid查找评论
	public List<Comment> getCommentsByNid(String nid);
	//添加评论
	public int addComment(Comment comment);
	//删除某新闻下的所有评论
	public int delCommentsByCNID(String nid);
	//根据ID删除评论
	public int deleteComment(String cid);
}
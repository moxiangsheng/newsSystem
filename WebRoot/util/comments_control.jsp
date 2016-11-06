<%@page import="org.jbit.news.biz.CommentsBiz"%>
<%@page import="org.jbit.news.biz.impl.CommentsBizImpl"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	String opr = request.getParameter("opr");
	String nid = request.getParameter("nid");
	System.out.print("nid:"+nid);
	CommentsBiz topicsBiz=new CommentsBizImpl();
	if(opr.equals("del")){//删除评论
		String cid = request.getParameter("cid");
		int result=topicsBiz.deleteComment(cid);
		if(result==1){			
	%>
			<script type="text/javascript">
				alert("已经成功删除此评论，点击确认返回原来页面");
				location.href="news_control.jsp?opr=findNew&nid=<%=nid%>";					
			</script>				
				
	<%	    
	     }else if(result==-1){
	 %>
			<script type="text/javascript">
				alert("删除此评论失败！请联系管理员查找原因！点击确认返回原来页面");
				location.href="news_control.jsp?opr=findNew&nid=<%=nid%>";	
			</script>
	 <%    
		}
	}%>




<%@page import="org.jbit.news.entity.Comment"%>
<%@page import="org.jbit.news.entity.Topic"%>
<%@page import="org.jbit.news.entity.News"%>
<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="console_element/top.jsp" %>
<script type="text/javascript">
	function check(){
		var ntitle = document.getElementById("ntitle");
		var nauthor = document.getElementById("nauthor");
		var nsummary = document.getElementById("nsummary");
		var ncontent = document.getElementById("ncontent");
		
		if(ntitle.value == ""){
			alert("标题不能为空！！");
			ntitle.focus();
			return false;
		}else if(nauthor.value == ""){
			alert("作者不能为空！！");
			nauthor.focus();
			return false;
		}else if(nsummary.value == ""){
			alert("摘要不能为空！！");
			nsummary.focus();
			return false;
		}else if(ncontent.value == ""){
			alert("内容不能为空！！");
			ncontent.focus();
			return false;
		}		
		return true;
	}
</script>
<%	
	News news=(News )request.getAttribute("news");
	List<Topic> topics=(List<Topic> )request.getAttribute("topics");
	List<Comment>  comments = news.getComments();
%>
<div id="main">
  <%@include file="console_element/left.html" %>
  <div id="opt_area">
    <h1 id="opt_type"> 编辑新闻： </h1>
    <form action="../util/news_control.jsp?opr=updateNews" method="post" enctype="multipart/form-data" onsubmit="return check()">
      <p>
        <label> 主题 </label>
        <select name="ntid">
        <% 
        for(Topic topic: topics){
        	if(news.getNtname() == topic.getTname()){%>
        	<option value='<%= topic.getTid()%>' selected="selected"><%= topic.getTname()%></option>
        	<%}else{%>
        	<option value='<%= topic.getTid()%>' ><%= topic.getTname()%></option>
        	<%}
        }        	
        %>        	
        </select>
        <input type="hidden" name="nid" value="<%=news.getNid() %>" />
      </p>
      <p>
        <label> 标题 </label>
        <input name="ntitle" id="ntitle" type="text" class="opt_input" value="<%=news.getNtitle()%>"/>
      </p>
      <p>
        <label> 作者 </label>
        <input name="nauthor" id="nauthor" type="text" class="opt_input" value="<%=news.getNauthor()%>"/>
      </p>
      <p>
        <label> 摘要 </label>
        <textarea name="nsummary" id="nsummary" cols="40" rows="3"><%=news.getNsummary()%></textarea>
      </p>
      <p>
        <label> 内容 </label>
        <textarea name="ncontent" id="ncontent" cols="70" rows="10"><%=news.getNcontent()%></textarea>
      </p>
      <p>
        <label> 上传图片 </label>
        <input name="file" id="file" type="file" class="opt_input" />
      </p>
      <input type="submit" value="提交" class="opt_sub" />
      <input type="reset" value="重置" class="opt_sub" />
    </form>
    <h1 id="opt_type">
		修改新闻评论：
	</h1>
      <table width="80%" align="left">
      <%if(comments.size()<=0){%>
      	<td colspan="6"> 暂无评论！ </td>
         <tr>
           <td colspan="6"><hr />
           </td>
         </tr>
       <%}else{
       		for(Comment comment: comments){%>
       			<tr>
	          <td> 留言人： </td>
	          <td><%=comment.getCauthor() %></td>
	          <td> IP： </td>
	          <td><%=comment.getCip()%></td>
	          <td> 留言时间： </td>
	          <td><%=comment.getCdate() %></td>
	          <td><a href="../util/comments_control.jsp?opr=del&nid=<%=news.getNid()%>&cid=<%=comment.getCid()%>">删除</a></td>
	        </tr>
	        <tr>
	          <td colspan="6"><%=comment.getCcontent()%></td>
	        </tr>
	        <tr>
	          <td colspan="6"><hr />
	          </td>
	        </tr>
       		<%}
       } %>
      </table>
  </div>
</div>
<%
	request.removeAttribute("news");
	request.removeAttribute("topics");
%>
<%@include file="console_element/bottom.html" %>
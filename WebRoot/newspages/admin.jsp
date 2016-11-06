<%@ page language="java" import="java.util.*,java.sql.*,org.jbit.news.entity.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
<meta http-equiv="description" content="This is my page"/>
<title>添加主题--管理后台</title>
<link href="../css/admin.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%@include file="console_element/top.jsp" %>
<div id="main">
  <%@include file="console_element/left.html" %>
  <div id="opt_area">    
    <script language="javascript">
	function clickdel(){
		return confirm("删除请点击确认");
	}
	
</script>
    <ul class="classlist">
      <%	
      List<News> list=( List<News>)session.getAttribute("list");
      if(list==null){
      	response.sendRedirect("../util/news_control.jsp?opr=list");
      	return;
      }else{
	      session.removeAttribute("list");
		  int n=0;
		  for(News tempNew:list){
		    n++;		
	     %> 
	      <li><%=tempNew.getNtitle() %><span> 作者：<%=tempNew.getNauthor() %> &#160;&#160;&#160;&#160; <a href='../util/news_control.jsp?opr=findNew&nid=<%=tempNew.getNid()%>'>修改</a> &#160;&#160;&#160;&#160; <a href='../util/news_control.jsp?opr=del&nid=<%=tempNew.getNid() %>' onclick='return clickdel()'>删除</a> </span> </li>
	      <%if(n%5==0){ %>
	      <li class='space'></li>
	      <%}} }%>
    </ul>
  </div>
</div>
<div id="footer">
  <%@include file="console_element/bottom.html" %>
</div>
</body>
</html>

<%@page import="org.jbit.news.entity.Page"%>
<%@page import="org.jbit.news.entity.Topic"%>
<%@page import="org.jbit.news.entity.News"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>">  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻中国</title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<script language="javascript">
	function check(){
		var login_username = document.getElementById("uname");
		var login_password = document.getElementById("upwd");
		if(login_username.value == ""){
			alert("用户名不能为空！请重新填入！");
			login_username.focus();	
			return false;
		}else if(login_password.value == ""){
			alert("密码不能为空！请重新填入！");
			login_password.focus();
			return false;
		}
		return true;
	}
	
	function focusOnLogin(){
		var login_username = document.getElementById("uname");
		login_username.focus();	
	}
</script>
</head>
<c:if test="${pages==null||(list1==null&&list2==null&&list3==null&&list4==null)}">
<%request.getRequestDispatcher("util/news_control.jsp?opr=listTitle&page_no=1").forward(request, response); %>
</c:if>
<c:if test="${!(pages==null||(list1==null&&list2==null&&list3==null&&list4==null))}">
<c:set value="${pages.getCurrPageNo()}" var="page_no" />  
<c:set value="${pages.getTotalPageCount()}" var="total_page" /> 
<body onload="focusOnLogin()">
  
<div id="header">
  <div id="top_login">
    <form action="util/do_login.jsp" method="post" onsubmit="return check()">
      <label> 登录名 </label>
      <input type="text" name="uname" id="uname" value="" class="login_input" />
      <label> 密&#160;&#160;码 </label>
      <input type="password" name="upwd" id="upwd" value="" class="login_input" />
      <input type="submit" class="login_sub" value="登录" />
      <label id="error"> </label>
      <img src="images/friend_logo.gif" alt="Google" id="friend_logo" />
    </form>
  </div>
  <div id="nav">
    <div id="logo"> <img src="images/logo.jpg" alt="新闻中国" /> </div>
    <div id="a_b01"> <img src="images/a_b01.gif" alt="" /> </div>
    <!--mainnav end-->
  </div>
</div>
<div id="container">

<%@include file="index-elements/index_sidebar.jsp"%>
 
  <div class="main">
    <div class="class_type"> <img src="images/class_type.gif" alt="新闻中心" /> </div>
    <div class="content">
      <ul class="class_date">
      <c:set value="0" var="n" />      
      	<c:forEach var="topic" items="${list4}">         
	      <c:set var="n" value="${n+1}"></c:set>
	      <c:choose>
	      <c:when test="${n%11==1}">
	      	<li id='class_month'><a href="util/news_control.jsp?opr=topicNew&tid=${topic.tid }"><b> ${topic.tname} </b></a>
	      </c:when>
	      <c:when test="${n%11==0}">    
	      	<a href="util/news_control.jsp?opr=topicNew&tid=${topic.tid }"><b> ${topic.tname} </b></a></li>
	      </c:when>
	      <c:otherwise >
	      	<a href="util/news_control.jsp?opr=topicNew&tid=${topic.tid }"><b> ${topic.tname} </b></a>
	      </c:otherwise>        
         </c:choose>
      </c:forEach>
      <c:if test="${n%11!=0}"></li></c:if>	
      </ul>
      <ul class="classlist">
        <c:set value="0" var="n" />      
      	<c:forEach var="news" items="${pages.getNewsList()}">         
	      <li><a href='util/news_control.jsp?opr=readNew&nid=${news.nid }'>${news.ntitle } </a><span> ${news.ncreatedate} </span></li>
	      <c:set var="n" value="${n+1}"></c:set>
	      <c:if test="${n%5==0}"> <li class='space'></li></c:if>
	     </c:forEach>	     
	     <c:choose>
	     	<c:when test="${page_no == 1 && total_page==1}">     	
	   			<p align="right"> 当前页数:[1/${total_page}] </p>
	   		</c:when>
	   		<c:when test="${page_no == 1}"> 	   
	   	         <p align="right"> 当前页数:[1/${total_page}]&nbsp; <a href="util/news_control.jsp?opr=topicNew&page_no=2&tid=${tid } ">下一页&nbsp;&nbsp;</a> <a href="util/news_control.jsp?opr=topicNew&page_no=${total_page}&tid=${tid }">末页</a> </p>
	   		</c:when>
	   		<c:when test="${page_no == total_page}">	   
	   			<p align="right"> 当前页数:[${total_page}/${total_page}]&nbsp; <a href="util/news_control.jsp?opr=topicNew&page_no=1&tid=${tid }">首页</a><a href="util/news_control.jsp?opr=topicNew&page_no=${total_page-1}&tid=${tid }">&nbsp;&nbsp;上一页</a></p>
	   		</c:when>
	   		<c:when test="${page_no < total_page && page_no > 1}">	  
	   			<p align="right"> 当前页数:[${page_no}/${total_page}]&nbsp;&nbsp; <a href="util/news_control.jsp?opr=topicNew&page_no=1&tid=${tid }">首页</a><a href="util/news_control.jsp?opr=topicNew&page_no=${page_no}&tid=${tid }">&nbsp;&nbsp;上一页</a><a href="util/news_control.jsp?opr=topicNew&page_no=${page_no}&tid=${tid }">&nbsp;&nbsp;下一页</a> <a href="util/news_control.jsp?opr=topicNew&page_no=${total_page}&tid=${tid }">&nbsp;&nbsp;末页</a></p>
	   		</c:when>
       </c:choose> 		
      </ul>
    </div>   
<%@include file="index-elements/index_rightbar.html"%>
  </div>
</div>
  <%@include file="index-elements/index_bottom.html"%>
</body>
</c:if>
</html>

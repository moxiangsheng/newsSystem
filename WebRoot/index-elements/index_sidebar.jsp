<%@page import="org.jbit.news.entity.News"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<div class="sidebar">
    <h1> <img src="images/title_1.gif" alt="国内新闻" /> </h1>
    <div class="side_list">
      <ul>      
      <c:forEach var="news" items="${list1}" begin="1" end="6"> 
      	<c:set var="i" value="${i+1}"></c:set>      	
     	<li> <a href='news_read.jsp?nid=${ news.nid }'><b> ${news.ntitle }</b></a> </li>      	
      </c:forEach>	
      </ul>
    </div>
    <h1> <img src="images/title_2.gif" alt="国际新闻" /> </h1>
    <div class="side_list">
      <ul>      
      <c:forEach var="news" items="${list2}" begin="1" end="6"> 
     		<li> <a href='news_read.jsp?nid=${ news.nid }'><b> ${news.ntitle }</b></a> </li>
      </c:forEach>	
      </ul>
    </div>
    <h1> <img src="images/title_3.gif" alt="娱乐新闻" /> </h1>
    <div class="side_list">
      <ul>
      <c:forEach var="news" items="${list2}" begin="1" end="6">       	
     		<li> <a href='news_read.jsp?nid=${ news.nid }'><b> ${news.ntitle }</b></a> </li>
      </c:forEach>	
      </ul>
    </div>
  </div>
<%
	request.removeAttribute("news_in_topic");
%>

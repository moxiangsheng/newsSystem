<%@page import="org.jbit.news.biz.impl.TopicsBizImpl"%>
<%@page import="org.jbit.news.biz.TopicsBiz"%>
<%@page import="java.io.File"%>
<%@page import="org.jbit.news.biz.impl.CommentsBizImpl"%>
<%@page import="org.jbit.news.biz.CommentsBiz"%>
<%@page import="org.jbit.news.biz.impl.NewsBizImpl"%>
<%@page import="org.jbit.news.biz.NewsBiz"%>
<%@page import="org.jbit.news.dao.impl.TopicsDaoImpl"%>
<%@page import="org.jbit.news.dao.TopicsDao"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page
	import="org.jbit.news.dao.impl.NewsDaoImpl,org.jbit.news.entity.*"%>
<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String opr = request.getParameter("opr");
	NewsBiz newsBiz=new NewsBizImpl();
	TopicsBiz topicsBiz=new TopicsBizImpl();	
	CommentsBiz commentsBiz=new CommentsBizImpl();
	if(opr.equals("list")){//编辑新闻时对新闻的查找
		List<News> list=newsBiz.getAllnews();	
		session.setAttribute("list",list);
		response.sendRedirect("../newspages/admin.jsp");
	}else if(opr.equals("listTitle")){//首次进入首页面
		String str = request.getParameter("page_no");
		int page_no=1;
		if(str!=null && !(str.equals(""))){
			page_no=Integer.valueOf(str);			
		}	
		Page pages=new Page();			
		pages.setCurrPageNo(page_no);//当前页数
		List<News> list1 = newsBiz.getAllnewsByTName("国内");
		List<News> list2 = newsBiz.getAllnewsByTName("国际");
		List<News> list3 = newsBiz.getAllnewsByTName("娱乐");
		List<Topic> list4 = topicsBiz.getAllTopics();
		List<News> list5 = newsBiz.getAllnewsByPage(1,pages.getPageSize(),page_no);//默认显示国内新闻
		int total_news =  newsBiz.countNews("1");//国内新闻条数
		session.setAttribute("list1",list1);//左侧国内新闻
		session.setAttribute("list2",list2);//左侧国际新闻
		session.setAttribute("list3",list3);//左侧娱乐新闻
		session.setAttribute("list4",list4);//所有的主题
		pages.setNewsList(list5);//中间的所有新闻
		pages.setTotalCount(total_news);//新闻数目
		pages.setTotalPageCount(((int)total_news+pages.getPageSize()-1)/pages.getPageSize());//总页数		
		request.setAttribute("pages",pages);
		request.setAttribute("tid","1");//当前主题
		request.getRequestDispatcher("../index.jsp").forward(request, response);
	}else if(opr.equals("topicNew")){//中间的某主题下的新闻	
		String str = request.getParameter("page_no");
		int page_no=1;
		if(str!=null && !(str.equals(""))){
			page_no=Integer.valueOf(str);			
		}		
		Page pages=new Page();	
		pages.setCurrPageNo(page_no);//当前页数	    	
		String Tid=request.getParameter("tid");
		List<News> list5 = newsBiz.getAllnewsByPage(Integer.valueOf(Tid),pages.getPageSize(),page_no);
		int total_news =  newsBiz.countNews(Tid);//本主题下的新闻条数
		pages.setNewsList(list5);//中间的某主题下的新闻
		pages.setTotalCount(total_news);//新闻数目
		pages.setTotalPageCount(((int)total_news+pages.getPageSize()-1)/pages.getPageSize());//总页数		
		request.setAttribute("pages",pages);
		request.setAttribute("tid",Tid);//当前主题
		request.getRequestDispatcher("../index.jsp").forward(request, response);
	}else if(opr.equals("readNew")){//读取某条新闻	    
		String Nid=request.getParameter("nid");
		News news=newsBiz.getNewsByNID(Integer.valueOf(Nid));		
		session.setAttribute("news",news);//用户具体点击的某条新闻		
		response.sendRedirect("../news_read.jsp");
	}else if(opr.equals("findNew")){//编辑新闻时先查找某条新闻	    
		String Nid=request.getParameter("nid");
		News news=newsBiz.getNewsByNID(Integer.valueOf(Nid));	
		List<Topic> topics=topicsBiz.getAllTopics();
		request.setAttribute("news",news);//用户具体点击的某条新闻	
		request.setAttribute("topics",topics);//所有主题	
		request.getRequestDispatcher("../newspages/news_modify.jsp").forward(request, response);
	}else if(opr.equals("findTopics")){//查找所有主题
		List<Topic> topics = topicsBiz.getAllTopics();
		session.setAttribute("topics",topics);//所有的主题
		response.sendRedirect("../newspages/news_add.jsp");
	}else if(opr.equals("addNews")){//添加新闻
		News news=new News();
		String fieldName = "";  //表单字段元素的name属性值	
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		//上传文件的存储路径（服务器文件系统上的绝对文件路径）
		String uploadFilePath = getServletContext().getRealPath("upload");
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(1024*1024*5);			
      		//解析form表单中所有文件
			try{List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				while(iter.hasNext()) {   //依次处理每个文件
				FileItem item = (FileItem) iter.next();
					if (item.isFormField()){  //普通表单字段
						fieldName = item.getFieldName();  //表单字段的name属性值							
						if (fieldName.equals("ntid")){   //主题   
						news.setNtid(item.getString("UTF-8"));
						}else if(fieldName.equals("ntitle")){ //标题               	 
						news.setNtitle(item.getString("UTF-8"));
						}else if(fieldName.equals("nauthor")){//作者                	 
						news.setNauthor(item.getString("UTF-8"));
						}else if(fieldName.equals("nsummary")){ //摘要               	 
						news.setNsummary(item.getString("UTF-8"));
						}else if(fieldName.equals("ncontent")){ //内容               	 
						news.setNcontent(item.getString("UTF-8"));
						}
					}else{   //文件表单字段
						String fileName = item.getName();
						List<String> filType=Arrays.asList("gif","jpg","jpeg");
						String ext=fileName.substring(fileName.lastIndexOf(".")+1);
						if(fileName!=null&&!fileName.equals("")&&!filType.contains(ext)){  //判断文件类型是否在允许范围内
%>
						<script type="text/javascript">
							alert("上传失败，文件类型只能是gif、jpg、jpeg");
							location.href = "../newspages/news_add.jsp";
						</script>
<%
						}else if (fileName != null && !fileName.equals("")) {
							File fullFile = new File(item.getName());
							File saveFile = new File(uploadFilePath, fullFile.getName());
							item.write(saveFile);						
							news.setNpicpath(uploadFilePath+"\\"+fullFile.getName());	
						}
					}		
				}
			}catch(FileUploadBase.SizeLimitExceededException ex){
%>
				<script type="text/javascript">
					alert("上传失败，文件太大，单个文件的最大限制是：5MB");
					location.href = "../newspages/news_add.jsp";
				</script>
<%
			}			
		}	    
		if(newsBiz.addNews(news)>=1){
%>
			<script type="text/javascript">
				alert("上传成功！");
				location.href = "../newspages/news_add.jsp";
			</script>
<%
		}else{
%>
			<script type="text/javascript">
				alert("上传失败，请联系管理员！");
				location.href = "../newspages/news_add.jsp";
			</script>
<%
		}		
	}else if(opr.equals("updateNews")){//更新新闻	
		News news=new News();
		String fieldName = "";  //表单字段元素的name属性值	
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		//上传文件的存储路径（服务器文件系统上的绝对文件路径）
		String uploadFilePath = getServletContext().getRealPath("upload");
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(1024*1024*5);			
      		//解析form表单中所有文件
			try{List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				while(iter.hasNext()) {   //依次处理每个文件
				FileItem item = (FileItem) iter.next();
					if (item.isFormField()){  //普通表单字段
						fieldName = item.getFieldName();  //表单字段的name属性值							
						if (fieldName.equals("ntid")){   //主题   
						news.setNtid(item.getString("UTF-8"));
						}else if(fieldName.equals("ntitle")){ //标题               	 
						news.setNtitle(item.getString("UTF-8"));
						}else if(fieldName.equals("nauthor")){//作者                	 
						news.setNauthor(item.getString("UTF-8"));
						}else if(fieldName.equals("nsummary")){ //摘要               	 
						news.setNsummary(item.getString("UTF-8"));
						}else if(fieldName.equals("ncontent")){ //内容               	 
						news.setNcontent(item.getString("UTF-8"));
						}else if(fieldName.equals("nid")){//ID
						news.setNid(item.getString("UTF-8"));
						}
					}else{   //文件表单字段
						String fileName = item.getName();
						List<String> filType=Arrays.asList("gif","jpg","jpeg");
						String ext=fileName.substring(fileName.lastIndexOf(".")+1);
						if(fileName!=null&&!fileName.equals("")&&!filType.contains(ext)){  //判断文件类型是否在允许范围内
%>
						<script type="text/javascript">
							alert("上传失败，文件类型只能是gif、jpg、jpeg");
							location.href = "../newspages/news_add.jsp";
						</script>
<%
						}else if (fileName != null && !fileName.equals("")) {
							File fullFile = new File(item.getName());
							File saveFile = new File(uploadFilePath, fullFile.getName());
							item.write(saveFile);						
							news.setNpicpath(uploadFilePath+"\\"+fullFile.getName());	
						}
					}							
				}
			}catch(FileUploadBase.SizeLimitExceededException ex){
%>
				<script type="text/javascript">
					alert("上传失败，文件太大，单个文件的最大限制是：5MB");
					location.href = "../newspages/news_add.jsp";
				</script>
<%
			}			
		}	    
		if(newsBiz.updateNews(news)>=1){
%>
			<script type="text/javascript">
				alert("更新成功！");
				location.href = "../newspages/admin.jsp";
			</script>
<%
		}else{
%>
			<script type="text/javascript">
				alert("更新失败，请联系管理员！");
				location.href = "../newspages/news_add.jsp";
			</script>
<%
		}		
	}else if(opr.equals("addComment")){//添加评论
		String cauthor = request.getParameter("cauthor");
		String cnid = request.getParameter("nid");
		String cip = request.getParameter("cip");
		String ccontent = request.getParameter("ccontent");
		java.util.Date date = new java.util.Date();
		Timestamp cdate = new Timestamp(date.getTime());
		Comment comment  = new Comment();
		comment.setCnid(cnid);		
		comment.setCcontent(ccontent);
		comment.setCdate(cdate.toString());
		comment.setCip(cip);
		comment.setCauthor(cauthor);		
		if(commentsBiz.addComment(comment)>0){
%>
			<script type="text/javascript">
				alert("已经成功添加评论，点击确认返回原来页面");
				location.href = "../index.jsp";
			</script>
<%
		}else{
%>
			<script type="text/javascript">
				alert("添加新闻失败！请联系管理员查找原因！点击确认返回原来页面");
				location.href = "../index.jsp";
			</script>
<%
		}
	}else if(opr.equals("del")){//删除某条新闻
		String nid = request.getParameter("nid");
		int result=newsBiz.deleteNews(nid);
		if(result==1){
%>
			<script type="text/javascript">
				alert("删除成功，点击确认返回原来页面");
				location.href = "../newspages/admin.jsp";
			</script>
<%
		}else{
%>
			<script type="text/javascript">
				alert("删除新闻失败！请联系管理员查找原因！点击确认返回原来页面");
				location.href = "../newspages/admin.jsp";
			</script>
<%
		}
	}
	
%>


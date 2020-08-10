<%@page import="galleryBoard.GalleryBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>   


<jsp:useBean id="dao" class="galleryBoard.GalleryBoardDAO"/> 
<%
String id=(String)session.getAttribute("id");

int num=Integer.parseInt(request.getParameter("num"));

GalleryBoardBean bean=dao.getBoard(num);

String content=bean.getContent().replace("<br>", "\r\n");


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<nav id="sub_menu"><!-- 왼쪽메뉴 -->
			<ul>
				<li><a href="#">Notice</a></li>
				<li><a href="#">public News</a><li>
				<li><a href="#">Service Policy</a></li>
			</ul>	
		</nav>
		
		<article>
			<h1>Gallery Writer</h1>
			<form action="galleryupdatepro.jsp?num=<%=num %>&pageNum=<%=request.getParameter("pageNum") %>" method="post" >
				<table id="notice">
					<tr>
						<td>Id</td>
						<td><input type="text" name="id" value="<%=id%>" readonly></td>
					</tr>
					<tr>
						<td>PassWord</td>
						<td><input type="password" name="passwd"></td>
					</tr>
					<tr>
						<td>Subject</td>
						<td><input type="text" name="subject" value="<%=bean.getSubject()%>"></td>
					</tr>
					
					<tr>
						<td>Content</td>
						<td><textarea rows="13" cols="40" name="content">
						
						<%=content%>
						</textarea></td>
					</tr>				
				</table>
				<div id="table_search">
					<input type="submit" value="완료" class="btn">
					<input type="reset" value="취소" class="btn">
					<input type="button" value="목록" class="btn"
						   onclick="location.href = 'galleryNotice.jsp?pagaNum=<%=request.getParameter("pageNum")%>'">
				</div>			
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>	
	</div>

</body>
</html>
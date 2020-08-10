<%@page import="sboard.BoardBean" %>
<%@page import="sboard.BoardDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<%
			String id = (String)session.getAttribute("id");	
		
			if(id==null){
				response.sendRedirect("../member/login.jsp");
			}		
			
			int num = Integer.parseInt(request.getParameter("num"));
			
			String pageNum = request.getParameter("pageNum");
						
			BoardDAO dao = new BoardDAO();

			
			BoardBean bean = dao.getboard(num);
			String Content =""; 
			
			if(bean.getContent() != null){
			  Content = bean.getContent().replace("<br>", "\r\n");
			}
			
		%>

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
			<h1>Notice Update</h1>
			<form action="updatepro.jsp?num=<%=num %>&pageNum=<%=pageNum %>" method="post" name="fr">
			
				<table id="notice">
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id" value="<%=bean.getId()%>" readonly></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="passwd"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="<%=bean.getSubject()%>"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="13" cols="40" name="content"><%=Content%></textarea></td>
					</tr>				
				</table>
				<div id="table_search">
					<input type="submit" value="수정" class="btn">
					<input type="reset" value="취소" class="btn"
						onclick="reset1()">
					<input type="button" value="List" class="btn"
						onclick="location.href = 'notice.jsp?pageNum=<%=pageNum%>'">
				</div>			
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		<div id="page_control"></div>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>	
	</div>

</body>
</html>
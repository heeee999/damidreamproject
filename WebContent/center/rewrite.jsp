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
			
			
			int num = Integer.parseInt(request.getParameter("num")); //주글번호
			int re_ref =Integer.parseInt(request.getParameter("re_ref"));//주글그룹값
			int re_lev = Integer.parseInt(request.getParameter("re_lev"));//주글 들여쓰기 정도값
			int re_seq = Integer.parseInt(request.getParameter("re_seq"));//주글 순서			
			
			
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
			<h1>Notice ReWriter</h1>
			<form action="rewritepro.jsp" method="post">
				<%--주글에 대한 정보 전달 --%>
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
				<input type="hidden" name ="num" value="<%=num%>">
				<input type="hidden" name ="re_ref" value="<%=re_ref%>">
				<input type="hidden" name ="re_lev" value="<%=re_lev%>">
				<input type="hidden" name ="re_seq" value="<%=re_seq%>">
				
				
				<table id="notice">
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id" value="<%=id%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="passwd"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="└>re:"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="13" cols="40" name="content"></textarea></td>
					</tr>				
				</table>
				<div id="table_search">
					<input type="submit" value="완료" class="btn">
					<input type="reset" value="취소" class="btn">
					<input type="button" value="목록" class="btn"
						   onclick="location.href = 'notice.jsp?pageNum=<%=request.getParameter("pageNum")%>'">
				</div>			
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>	
	</div>

</body>
</html>
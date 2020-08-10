<%@page import="java.text.SimpleDateFormat"%>

<%@page import="sboard.BoardDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<jsp:useBean id="bean" class="sboard.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
</head>
<%
	request.setCharacterEncoding("UTF-8");

    String id = (String)session.getAttribute("id");
     
   
	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	
	dao.updateReadCount(num);
	
	String dbcontent ="";
	bean= dao.getboard(num);
	
	if(bean.getContent() != null){
		dbcontent = bean.getContent().replace("\r\n", "<br>");
	}
	
	//DB로부터 하나의 글 정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출하여 리턴 받기
%>
<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<nav id="sub_menu"><!-- 왼쪽 메뉴 -->
			<ul>
				<li><a href="#">Notice</a><li>
				<li><a href="#">public News</a><li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>		
		<article>
			<h1>Notice Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td class="content"><%=num%></td>
					<td>조회수</td>
					<td class="content"><%=bean.getReadcount() %></td>
				</tr>
				<tr>
					<td >아이디</td>
					<td class="content"><%=bean.getId() %></td>
					<td>작성일</td>
					<td class="content"><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate()) %></td>
				</tr>
				
				<tr>
					<td>제목</td>
					<td colspan="3" style="text-align: left;" class="content">&nbsp;&nbsp;&nbsp;<%=bean.getSubject() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3" style="text-align: left;" class="content"><%=dbcontent %></td>
				</tr>				
			</table>
			
			<div id="table_search">
			<%
			
				if(id != null ){
					if(id.equals(bean.getId())){
			%>
			
			 
				<input type="button" value="수정" class="btn"				
				onclick="location.href ='update.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"> 
	             <input type="button" value="삭제" class="btn" onclick="location.href ='delete.jsp?num=<%=num%>'">
			<%		} %>
				<input type="button" value="답글" class="btn"	 
				onclick="location.href ='rewrite.jsp?num=<%=num%>&pageNum=<%=pageNum%>&re_ref=<%=bean.getRe_ref()%>&re_lev=<%=bean.getRe_lev()%>&re_seq=<%=bean.getRe_seq()%>'">
			<%
				}			
			%>
			<input type="button" value="목록" class="btn"				
			onclick="location.href ='notice.jsp?pageNum=<%=pageNum%>'">
			
			</div>
			
			
			<div id="page_control"></div>			
		</article>
		
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</div>

</body>
</html>
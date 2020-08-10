<%@page import="java.text.SimpleDateFormat"%>
<%@page import="galleryBoard.*" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="css/front.css" rel="stylesheet" type="text/css">
</head>
<%
	request.setCharacterEncoding("UTF-8");
    String id= (String)session.getAttribute("id");
	int num =Integer.parseInt(request.getParameter("num"));
	
	String pageNum = request.getParameter("pageNum");
	
	GalleryBoardDAO dao = new GalleryBoardDAO();
	

	dao.updateReadCount(num);
	
	String Content ="";
	GalleryBoardBean bean = dao.getBoard(num);
		
	if(bean.getContent() != null){
		Content = bean.getContent().replace("\r\n", "<br>");
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
			<h1>Gallery Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td><%=bean.getNum()%></td>
					
					<td>조회수</td>
					<td><%=bean.getReadcount() %></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><%=bean.getId() %></td>
					<td>게시일</td>
					<td><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate()) %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3" ><%=bean.getSubject() %></td>
				</tr>
				<tr>
					<td>내용</td> 
					<td colspan="3" >	
					<%
						if(bean.getImage()!=null && bean.getImage()!=""){
					%>				
							<img alt="" src="../upload/<%=bean.getImage()%>" style="width: 360px;height:270pxs;">
					<%
						}
					%>
					<%=Content %></td> 
				</tr>				
			</table>
			
			<div id="table_search">
			<%
				
				
				if(id != null ){
					if(id.equals("danmi")){
			%>			
						<input type="button" value="수정" class="btn"				
						onclick="location.href ='galleryupdate.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						
						<input type="button" value="삭제" class="btn"				
						onclick="location.href ='galleryDelete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
			<%		} %>	
				
			 
			<%
			if(!id.equals("danmi")){
				%>
				 <input type="button" value="예약&문의" class="btn"	
				onclick="location.href ='../center/write.jsp?&subject1=<%=bean.getSubject()%>'">
				<%
			}
				}			
			%>
			<input type="button" value="목록" class="btn"				
			onclick="location.href ='galleryNotice.jsp?pageNum=<%=pageNum%>'">
			</div>
			<div id="page_control"></div>			
		</article>
		
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</div>

</body>
</html>
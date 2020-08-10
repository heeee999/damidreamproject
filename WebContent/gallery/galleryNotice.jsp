
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="galleryBoard.GalleryBoardBean" %>
<%@page import="galleryBoard.GalleryBoardDAO" %> 


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
		
		
		<%
		 
			GalleryBoardDAO boardDAO = new GalleryBoardDAO();
			
		 	int count = boardDAO.getBoardCount();
		 	
		 	int pageSize = 5; //한 페이지당 보여줄 글 개수 5
		 	String pageNum = request.getParameter("pageNum");
			
		 	if(pageNum == null){
		 		pageNum ="1";
		 	}
		 	int currentPage = Integer.parseInt(pageNum);
		 	int startRow = (currentPage - 1) * pageSize;
		 	
		 	List<GalleryBoardBean> list = null;
		 	
			if(count > 0){
				
				list = boardDAO.getBoardList(startRow,pageSize);
			}
		
		
		%>
		<article>
			<h1>Gallery[Count of List: <%=count %>]</h1>
			<table id="notice">
				<tr>
					<th class="tno" align="center">No.</th>					
					<th class="ttitle" colspan="2" align="center">Title</th>
					<th class="twrite" align="center">Writer</th>
					<th class="tdate" align="center">Date</th>
					<th class="tread" align="center">Read</th>
				</tr>
		<%
			if(count > 0){
				for(int i=0;i<list.size();i++){
					GalleryBoardBean bean = list.get(i); 
		%>
		<tr onclick="location.href ='galleryContent.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
			<td><%=bean.getNum() %></td>			
			<td class="left" width="45px">
				
				<%
	
					if(bean.getImage()!=null && bean.getImage()!=""){
				%>
				
				<img src="../upload/sm_<%=bean.getImage()%>">
				<%
					}
				%>
				</td>
			<td valign="middle" align="left"><%=bean.getSubject() %></td>
			<td><%=bean.getId() %></td>
			<td><%= new SimpleDateFormat("yyyy/MM/dd").format(bean.getDate())%></td>
			<td><%=bean.getReadcount() %></td>
		</tr> 
		
		<%	
				}
			} else{
		%>
			<tr align="center">
				<td colspan="5">등록된 게시글 없음</td>
			</tr>
		<%				
			}		
		%>					
			</table> 
			 
		<%
			
			String id =(String)session.getAttribute("id");
		
			if(id != null && id.equals("danmi")){
		%>
				<div id ="table_search">
					<input type="button" value="글쓰기" class="btn" onclick="location.href='galleryWrite.jsp'">
				</div>				
		<%					
			}			
		%>
				<div id="table_search">
					<input type="text" name="search" class="input_box">
					<input type="button" value="검색" class="btn">
				</div>
				<div class="clear"></div>
				<div id="page_control">
		<%
			if(count > 0){
				int pageCount = count/pageSize + (count%pageSize ==0 ? 0 : 1);
				
			
				int pageBlock = 2;
				
			
				int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;
				
				int endPage = startPage + pageBlock - 1;
				
				if(endPage > pageCount){
					endPage = pageCount;
				}
				if(startPage > pageBlock){
			%>
					<a href="galleryNotice.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</a>		
			<%						
				}
				for(int i=startPage;i<=endPage;i++){
			%>
					<a href="galleryNotice.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%		
				}
				if(endPage<pageCount){
					%>
					<a href="galleryNotice.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
					<%
				}				
			}		
		%>			
				</div>			
		</article>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>	
	</div>
</body>
</html>
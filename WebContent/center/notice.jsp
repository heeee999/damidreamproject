
<%@page import="sboard.BoardBean"%>
<%@page import="sboard.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
   request.setCharacterEncoding("utf-8");
   %> 
 <%!String keyField="" ;
 String keyWord="" ; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function check(){
	// 만약 검색어를 입력하지 않았다면 그냥 전체리스트를 뿌려주
	
	document.search.submit();
}


</script>


</head>

<%
  String id = (String)session.getAttribute("id");

  if(request.getParameter("keyWord") != null){
	  keyField = request.getParameter("keyField");
	  keyWord = request.getParameter("keyWord"); 
			}

  
	BoardDAO boardDAO = new BoardDAO();

	int count = boardDAO.getBoardCount();

	
	int pageSize = 5;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);//(현재 선택한 페이지 번호를 정수로 변환해서 저장)
	
	
	int startRow = (currentPage - 1) * pageSize;
	
	List<BoardBean> list = null;
	
	
	if(count > 0){
		
		list = boardDAO.getBoardList(startRow, pageSize, keyWord, keyField);
		
	}	
%>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->


<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
	<h1>Notice[전체글 개수 : <%=count%>]</h1>
	<table id="notice">
		<tr>
			<th class="tno">No.</th>
		    <th class="ttitle">Title</th>
		    <th class="twrite">Writer</th>
		    <th class="tdate">Date</th>
		    <th class="tread">Read</th>
		</tr>
	<%
		if(count > 0 && !list.isEmpty()){ //만약 board게시판테이블에 글이 존재 한다면			
			for(int i=0;  i<list.size(); i++){
				BoardBean bean = list.get(i);		
	%>
		<tr>
			<td><%=bean.getNum()%></td>	
			<td class="left"> <a href="content.jsp?num=<%=bean.getNum() %>&pageNum=<%=pageNum%>" ><%=bean.getSubject()%></a></td>	
			<td><%=bean.getId()%></td>	
			<td><%=new SimpleDateFormat("yyyy.MM.dd").format(bean.getDate())%></td>	
			<td><%=bean.getReadcount()%></td>	
		</tr>					
	<%			
			}	
		}else{
	%>		
		<tr>
			<td colspan="5">등록된 게시글이 없습니다 </td>
		</tr>
	<%		
		}
	%>
	</table>
<%
	
	

	if(id != null){//세션영역에 id값이 저장되어 있다면
%>
<div id="table_search">
	<input type="button" value="글쓰기" class="btn" onclick="location.href='write.jsp'">
</div>  
<%		
	}
%>

<div id="table_search">
<form action="notice.jsp" name="search" method="post">

   <table border=0 width=527 align=center cellpadding=4 cellspacing=0>
   <tr>
      <td align=center valign=bottom>
         <select name="keyField" class="input_box" >
            <option value="id"> 아이디</option>
            <option value="subject"> 제목</option>
            <option value="content"> 내용</option>
         </select>
         
<input type="text" name="keyWord" class="input_box">
<input type="button" value="검색" class="btn" onclick="check()">
<input type="hidden" name="startRow" value="<%=startRow %>">
<input type="hidden" name="pageSize" value="<%=pageSize%>">
</td>
</tr>
</table>
</form>


</div>

<div class="clear"></div>
<div id="page_control">
<%
	if(count>0){
		
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		int pageBlock = 1;
		
		
int startPage = 
((currentPage/pageBlock) - (currentPage % pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;

		
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount){
		
			endPage = pageCount;
		}
		
		
		if(startPage > pageBlock){
%>
		<a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>			
<%			
		}	
		
		for(int i=startPage;  i<=endPage; i++){
%>
		<a href="notice.jsp?pageNum=<%=i%>">[<%=i%>]</a>			
<%			
		}
		
		if(endPage < pageCount){
%>
		<a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
<%			
		}	
	}
%>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>






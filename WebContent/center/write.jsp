<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%! String subject1=""; %>
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
		if(request.getParameter("subject1") !=null){
			subject1=request.getParameter("subject1");
		}else{
			subject1="";
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
			<h1>Notice Writer</h1>
			<form action="writepro.jsp" method="post">
				<table id="notice">
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">
				
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id" value="<%=id%>" readonly></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="passwd"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value="[<%=subject1%>예약&문의]"></td>
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
						   onclick="location.href = 'notice.jsp'">
				</div>			
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>	
	</div>

</body>
</html>
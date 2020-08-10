<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");
 %>


<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script language="javascript"
	src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js">
</script>	

</head>
<body>
	<div id="wrap">
	  <jsp:include page="../inc/top.jsp"></jsp:include>
		<nav id="sub_menu">
			
		</nav>
		<article>
		
			<form  action="galleryDeletepro.jsp" id="join" method="post" name="f">
			<input type="hidden" name="pageNum" value="<%=request.getParameter("pageNum")%>">
			<input type="hidden"  name="id" value="<%=id%>">
			<input type="hidden"  name="num" value="<%=request.getParameter("num")%>">
			
				<fieldset>	
					
					<label>비밀번호</label><input type="password" name="passwd" id="passwd" />			
					
									
				</fieldset>
				<div class="clear"></div>
				<div id ="buttons">
					<input type="submit" value="확인" class="submit">
					
				</div>				
			</form>
		</article>
		<div class="clear"></div>
			<jsp:include page="../inc/bottom.jsp"></jsp:include>
	</div>

</body>
</html>
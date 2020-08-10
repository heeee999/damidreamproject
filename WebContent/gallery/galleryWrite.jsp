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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">

 function readURL(input) {
	if(input.files && input.files[0] ){
		$("#tdimg").html("<img src='#' id='preview' width=200 height=200 />");
		var reader = new FileReader();
		
		reader.readAsDataURL(input.files[0]);
		reader.onload = function (ProgressEvent) {
			$('#preview').attr('src', ProgressEvent.target.result);
			
		}
	}
}
</script>

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
		<%
			String id = (String)session.getAttribute("id");
		
			if(id==null){
				response.sendRedirect("../member/login.jsp");
			}		
		%>
		<article>
			<h1>Gallery Writer</h1>
			<form action="galleryWritePro.jsp" method="post" enctype="multipart/form-data">
				<table id="notice">
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
						<td><input type="text" name="subject"></td>
					</tr>
					<tr>
						<td>이미지 업로드</td>
						<td><input type="file" name="image" id="image" onchange="readURL(this);"></td>			
				 <br><td id="tdimg" ></td>
					</tr>
					
					<tr>
						<td>내용</td>
						<td><textarea rows="13" cols="40" name="content"></textarea></td>
					</tr>				
				</table>
				<div id="table_search">
					<input type="submit" value="글쓰기" class="btn">
					<input type="reset" value="취소" class="btn">
					<input type="button" value="목록" class="btn"
						   onclick="location.href = 'galleryNotice.jsp'">
				</div>			
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>	
	</div>

</body>
</html>
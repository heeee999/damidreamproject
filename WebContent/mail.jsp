
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body><link href="css/default.css" rel="stylesheet" type="text/css">
<link href="css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<header>
	<%
		String id = (String)session.getAttribute("id");
	  
		
		if(id==null){
	%>
		<div id = "login">
			<a href="member/login.jsp">login</a> |
			<a href="member/join.jsp">join</a>			
		</div>			
	<%
		} else{
		%>
		<div id="login">
			<span id="myName">
			<%=id%>님 로그인중&nbsp;</span><span id="myInfo"><a href="member/myInfo.jsp">MyIfo</a></span>
					 <span id="mylogout"><a href="member/logout.jsp">LogOut</a></span>		
		</div>
		<% 
		}	
	%>
	<div class="clear"></div>
	<div id ="logo">
		<a href="index.jsp"  title="단미드림 사이트입니다">
			<img src="images/logo1.jpg" width="100px"  alt="danmi">
		</a>
	</div>
		<nav id ="top_menu"> 
			<ul> 
				<li><a href="index.jsp" title="메인 화면">HOME</a></li>	
				<li><a href="#" title="공사중!">LIBRARY</a></li>
				<li><a href="gallery/galleryNotice.jsp" title="상품 게시판입니다">GALLERY</a></li>
				<li><a href="center/notice.jsp" title="예약 &문의 게시판입니다">BOARD</a></li>	
				<li><a href="mail.jsp" title="메일을 보내줘요~">CUSTOMER CENTER</a></li>
			</ul>
		</nav>	  
	</header> 
	<div class="clear"></div> 
		<nav id="sub_menu"><!-- 왼쪽메뉴 -->
			<ul>
				<li><a href="#">Notice</a></li>
				<li><a href="#">public News</a><li>
				<li><a href="#">Service Policy</a></li>
			</ul>	
		</nav>
		<article>
			<form action="mailSend" method="post">
				<h1>Mail</h1>
				<table id="notice">
					<tr>
						<td>Sender</td>
						<td><input type="text" name="sender" value="japandanmi211@gmail.com" readonly></td>
					</tr>
					<tr>
						<td>Receiver</td>
						<td><input type="text" name="receiver" ></td>				
					</tr>
					<tr>
						<td>Subject</td>
						<td><input type="text" name="subject"></td>
					</tr>
					<tr>
						<td>Content</td>
						<td><textarea name="content" cols=40 rows=15></textarea></td>
					</tr>								
				</table>	
				<div id="table_search">
					<input type="submit" value="전송" class="btn">					
				</div>
			</form>
			<div class="clear"></div>		
		</article>
		<div class="clear"></div>
		<footer>
			<hr>	
			 <div id="foot_logo">	
			 	<a href="index.jsp" title="단미드림 사이트입니다">	
					<img src="images/logo1.jpg" width="50px"  alt="danmi">	
				</a>			
			 </div>			 
			<div id="copy">
				All contents Copyright 2020 danmidream 2020 danmidream Inc. all rights
				reserved<br> Contact mail:danmi@danmi.com Tel +82 12 123
				4567 Fax +82 12 123 9876
			</div>
			<div id="social">
				<img src="images/facebook.gif" width="33" height="33" alt="Facebook">
				<img src="images/twitter.gif" width="34" height="34" alt="Twitter">
			</div>
		</footer>
	</div>

</body>
</html>
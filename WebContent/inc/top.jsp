<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<%
		String id = (String)session.getAttribute("id");
		
		if(id==null){
	%>
		<div id = "login">
			<a href="../member/login.jsp">login</a> |
			<a href="../member/join.jsp">join</a>			
		</div>			
	<%
		} else{
		%>
		<div id="login">
		<span id="myName">
			<%=id%>님 로그인중&nbsp;</span><a href="../member/myInfo.jsp"><span id="myInfo">MyInfo</span></a>
					 <a href="../member/logout.jsp"><span id="mylogout">LogOut</span></a>		
		</div>
		<% 
		}	
	%>
	<div class="clear"></div>
	<div id ="logo">
		<a href="../index.jsp"  title="단미드림 사이트 입니다">
			<img src="../images/logo1.jpg" width="100px"  alt="danmi">
		</a>	
	</div>
		<nav id ="top_menu"> 
			<ul>
				<li><a href="../index.jsp" title="메인 화면">HOME</a></li>	
				<li><a href="#" title="공사중!">LIBRARY</a></li>
				<li><a href="../gallery/galleryNotice.jsp" title="상품을 볼 수 있는 갤러리">GALLERY</a></li>
				<li><a href="../center/notice.jsp" title="예약&문의 게시판 입니다">BOARD</a></li>	
				<li><a href="../mail.jsp" title="메일을 보내줘요~">CUSTOMER CENTER</a></li>
			</ul>
		</nav>	 
	</header>
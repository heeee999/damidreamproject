
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");%>
	
<jsp:useBean id="bean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="dao" class="member.MemberDAO"/>
	<%

	String id = (String)session.getAttribute("id");
  
	
	 bean=dao.Memberinfo(id);  

	 SimpleDateFormat s=new SimpleDateFormat("YYYY.MM.dd");
	
	 
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">	
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">

function check() {
	
	location.href="../index.jsp";
	
}
</script>
</head>

<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<nav id="sub_menu">
			<ul>
				<li><a href="./join.jsp">Join us</a></li>
				<li><a href="#">Company Info</a></li>
			</ul>		
		</nav>
		<article>
			<h1>My Information</h1>
			<form action="myInfo2.jsp" id="join" method="post" name="f">
				<fieldset>
					<legend>회원정보</legend>
				
					<label>아이디</label><input type="text" name="id" class="id" value="<%=bean.getId()%>" disabled style="background-color:#fff7fb;border-style: hidden;" ><br>					
					<label>비밀번호</label><input type="password" name="passwd" value="<%=bean.getPasswd() %>" disabled style="background-color:#fff7fb;border-style: hidden;" ><br>
					<label class="clear">가입일</label><input type="text" name="regdate" value="<%=s.format(bean.getRegdate())%>" disabled style="background-color:#fff7fb;border-style: hidden;" ><br>					
					<label class="clear">이름</label><input type="text" name="name" value="<%=bean.getName()%>" disabled style="background-color:#fff7fb;border-style: hidden;" ><br>
			    	<label class="clear">이메일</label><input type="email" name="email" value="<%=bean.getEmail() %>" disabled style="background-color:#fff7fb;border-style: hidden;"><br>	
					<label class="clear">우편번호</label><input type="text" name="postcode" value="<%=bean.getPostcode()%>" disabled style="background-color:#fff7fb;border-style: hidden;" ><br>
					<label class="clear">주소</label><input type="text" name="address" size="40" value="<%=bean.getAddress()%>"disabled style="background-color:#fff7fb;border-style: hidden;" >
					<label class="clear">상세주소</label><input type="text" name="address1" size="40" value="<%=bean.getAddress1()%>"disabled style="background-color:#fff7fb;border-style: hidden;" ><br>
					<label class="clear">참고항목</label><input type="text" name="address2" size="40" value="<%=bean.getAddress2()%>"disabled style="background-color:#fff7fb;border-style: hidden;" ><br>
					<label class="clear">전화번호</label><input type="text" name="tel" value="<%=bean.getTel()%>"disabled style="background-color:#fff7fb;border-style: hidden;" ><br>
				
				</fieldset>
				<div class="clear"></div>
				<div id ="buttons" >
					<input type="submit" value="수정" class="submit" >&nbsp;&nbsp;&nbsp;
					
					<input type="button" onclick="location.href='myInfodelete.jsp'" value="회원탈퇴" class="submit">&nbsp;&nbsp;&nbsp;	
					<input type="button" onclick="check();" value="이전" class="submit" >					
				</div>				
			</form>
		</article>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>		
	</div>
</body>
</html>
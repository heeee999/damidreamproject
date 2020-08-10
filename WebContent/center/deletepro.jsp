<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bdao" class="sboard.BoardDAO"/>
<jsp:useBean id="dao" class="member.MemberDAO"/>

<%
int num=Integer.parseInt(request.getParameter("num"));
String id=request.getParameter("id");
String passwd=request.getParameter("passwd");

int check=dao.usercheck(id, passwd);

if(check == 1){
	bdao.deleteboard(num);
	response.sendRedirect("notice.jsp");
}else{
	%>
	<script>
	alert("비밀번호가 일치하지 않습니다");
	history.back();
	</script>
	<%
	
}



%>
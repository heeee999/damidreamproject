<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");

String passwd=request.getParameter("passwd");

MemberDAO dao=new MemberDAO();
int check=dao.usercheck(id, passwd);

if(check == 1){
	
	dao.deletemyinfo(id);
	session.invalidate();
	response.sendRedirect("../index.jsp");
	
}else{
	%>
	<script>
	alert("비밀번호가 일치하지 않습니다");
	history.back();
	</script>
	<%
	
}



%>


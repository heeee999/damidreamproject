<%@page import="javax.mail.SendFailedException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 request.setCharacterEncoding("UTF-8");
 
 %>
<jsp:useBean id="bean" class="sboard.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="dao" class="sboard.BoardDAO"/>
<jsp:useBean id="mdao"  class="member.MemberDAO"/>
<%



String id = (String)session.getAttribute("id");
String passwd=bean.getPasswd();
int check=mdao.usercheck(id, passwd);

if(check == 1){
	
	dao.insertBoard(bean);
	
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
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

%>
<jsp:useBean id="bean" class="sboard.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="dao" class="sboard.BoardDAO" />

<%



String id=(String)session.getAttribute("id");
String passwd=bean.getPasswd();
int re_ref=Integer.parseInt(request.getParameter("re_ref"));

MemberDAO mdao=new MemberDAO();
int check=mdao.usercheck(id, passwd);

if(check ==1){
	bean.setRe_ref(re_ref);
	dao.reInsertBoard(bean);
	
	%>
	<script>
	
	alert("댓글 완료");
	
	</script>
	
	<%
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
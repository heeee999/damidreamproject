
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("UTF-8");
    %>
    
    <jsp:useBean id="bdao" class="sboard.BoardDAO" />
    <jsp:useBean id="bean" class="sboard.BoardBean" />
    <jsp:setProperty property="*" name="bean" />
	
	<%
	  
	
		String id = (String)session.getAttribute("id");
		String passwd=bean.getPasswd();
	   
		MemberDAO dao=new MemberDAO();
		int check=dao.usercheck(id, passwd);
		
		if(check !=1){
			%>
			<script>
			alert("비밀번호가 틀립니다");
			history.back();
			</script>
			<%
		}else{
			bdao.insertBoard(bean);
		   
			response.sendRedirect("notice.jsp");
			
		}
		
	%>
	






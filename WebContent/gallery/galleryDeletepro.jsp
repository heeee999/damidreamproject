<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bean" class="galleryBoard.GalleryBoardBean"/>
<jsp:useBean id="dao" class="galleryBoard.GalleryBoardDAO"/>
<jsp:setProperty property="*" name="bean"/>

<%
String pageNum=request.getParameter("pageNum");
int num= bean.getNum();
System.out.println(num);

MemberDAO mdao=new MemberDAO();
String id=bean.getId();
String passwd=bean.getPasswd();
System.out.println(id);
System.out.println(passwd);

int check=mdao.usercheck(id,passwd );

if(check ==1){
	dao.deleteboard(num); 
	%>
	<script>
	 alert("삭제성공");
	 location.href="galleryNotice.jsp?pageNume=<%=pageNum%>";
	</script>
	<%
	
}else{
	%>
	<script>
	 alert("비밀번호 불일치");
	 history.back();
	</script>
	<%
}
%>
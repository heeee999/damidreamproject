<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bean"  class="galleryBoard.GalleryBoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="dao" class="galleryBoard.GalleryBoardDAO"/>
<jsp:useBean id="mdao" class="member.MemberDAO" />

<%
String id=(String)session.getAttribute("id");
System.out.println(id);
System.out.println(bean.getPasswd());
int check=mdao.usercheck(id, bean.getPasswd());
if(check == 1){
	
	dao.reinsert(bean);
	%>
	<script>
	alert("답글 성공");
	location.href="galleryNotice.jsp";
	</script>
	
	<%
}else{
	%>
	<script>
	alert("비밀번호가 틀립니다");
	history.back();
	</script>
	<%
}


%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">

function result(){
	opener.document.f.id.value = document.nfr.id.value;
	
	window.close();
	}
	

</script>
    
    
    
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");

String id=request.getParameter("id");

int check=dao.idCheck(id);

if(check == 1 ){
	out.print("사용중인아이디입니다");

}else{
	
	out.print("사용가능한 아이디입니다");
	%>
	<input type="button" value="사용함 " onclick="result();" />
	<%
}
%>

<form id ="join"action="join_IDCheck.jsp" method="post" name="nfr">
아이디:<input type="text" name="id" value="<%= id %>"/>
<input type="submit" value="중복확인">
</form>

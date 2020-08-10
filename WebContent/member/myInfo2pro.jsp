
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<%


String id = (String)session.getAttribute("id");
bean.setId(id);
String passwd=bean.getPasswd();
/* 
System.out.println(bean.getId());
System.out.println(bean.getName());
System.out.println(bean.getEmail());
System.out.println(bean.getPasswd());
System.out.println(bean.getAddress());
System.out.println(bean.getAddress1());
System.out.println(bean.getAddress2()); */

int check=dao.usercheck(id, passwd);



if(check != 1){

	
	%>
	<script>
	window.alert("비밀번호가 틀립니다 재입력부탁합니다");
    history.back();
	</script>
	<%
	
	
}else{

   dao.updateMember(bean);
	%>
   <script>
   alert("수정완료");
   location.href="myInfo.jsp"; 
   </script>
    <%
	
	
}

%>


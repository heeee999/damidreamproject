<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dao" class="member.MemberDAO" />
<jsp:useBean id="bdao" class="sboard.BoardDAO"/>
<jsp:useBean id="bean" class="sboard.BoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
int num =bean.getNum();
String id = bean.getId();
System.out.println(id);
System.out.println(bean.getContent());

String passwd=request.getParameter("passwd");
String pageNum=request.getParameter("pageNum");

int check= dao.usercheck(id, passwd);




if(check == 1){

	bdao.updateboard(bean);

	%>
	<script>
	alert("수정성공");
	location.href="content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>";
	</script>
	<%
	
	
}else{
	%>
	<script>
	 alert("비밀번호가 일치하지 않습니다");
	 history.back();
	
	</script>
	<%
}

%>

<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mdao" class="member.MemberDAO"/>
<jsp:useBean id="dao" class="galleryBoard.GalleryBoardDAO"/>
<jsp:useBean id="bean" class="galleryBoard.GalleryBoardBean"/>
<jsp:setProperty property="*" name="bean"/>
<%

String id=(String)session.getAttribute("id");
System.out.println(id);
System.out.println(bean.getNum());



String passwd=bean.getPasswd();
System.out.println(passwd);
System.out.println(bean.getSubject());
System.out.println(bean.getContent());
	int check= mdao.usercheck(id, passwd);
	
	if(check ==1){
		dao.updateBoard(bean); 
	%>
	<script>
	alert("수정성공");
	
	location.href="galleryContent.jsp?num=<%=bean.getNum()%>&pageNum=<%=request.getParameter("pageNum")%>";
	
	</script>
	<%
}else{
%>
<script>
	alert("수정실패");
	
	history.back();
</script>
<%
}


%>

<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="galleryBoard.GalleryBoardDAO" %>
<%@page import="galleryBoard.GalleryBoardBean" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mdao"  class="member.MemberDAO"/>

<%
	
	
GalleryBoardBean bean = new GalleryBoardBean();

String id=(String)session.getAttribute("id");

	String imagePath = request.getRealPath("/upload");
	int size =10*1024*1024;
	
	String filename ="";
	String originalfilename = "";
	try{
		MultipartRequest multi = new MultipartRequest(
			request,
			imagePath,
			size,
			"UTF-8",
			new DefaultFileRenamePolicy()	);
				
		
	Enumeration files = multi.getFileNames();
	
	String file = (String)files.nextElement();
	filename = multi.getFilesystemName(file);
	originalfilename = multi.getOriginalFileName(file);
	 
    bean.setId(id);
	bean.setPasswd(multi.getParameter("passwd"));
	bean.setSubject(multi.getParameter("subject"));
	bean.setImage(filename);
	bean.setContent(multi.getParameter("content"));
	
	
	} catch(Exception e){
		System.out.println("galleryWriter 오류발생: "+e.getMessage());
	}
	
	
	bean.setIp(request.getRemoteAddr());
	bean.setFile(bean.getImage());
	if(filename != null){
		//parameterblock클래스는 클래스에 변환할 이미지를 담고 그 이미지를 불러온다 ->이걸로만 이미지를 담을 수 있다
		ParameterBlock pb = new ParameterBlock();
		pb.add(imagePath +"/"+filename);
		RenderedOp rOp=JAI.create("fileload", pb);
		
		BufferedImage bi = rOp.getAsBufferedImage();
		BufferedImage thumb = new BufferedImage(50,50,BufferedImage.TYPE_INT_RGB);
		Graphics2D g = thumb.createGraphics();
		g.drawImage(bi, 0, 0,50, 50, null);
		File file = new File(imagePath+"/sm_"+filename);
		ImageIO.write(thumb, "jpg",file);
	}
	
	GalleryBoardDAO bdao = new GalleryBoardDAO();
	
	 String passwd=bean.getPasswd();
	 System.out.print(passwd);
	int check = mdao.usercheck(id, passwd);
	
	if(check == 1){	
		 bdao.insertBoard(bean);  
%>	
		<script type="text/javascript">
			window.alert("입력 성공");
			location.href = "galleryNotice.jsp";			
		</script>	
<%
	}else{
%>			
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>  	
<%
	}
%>
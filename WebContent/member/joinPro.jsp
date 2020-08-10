<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. join.jsp에서 입력한 데이터 한글처리
	request.setCharacterEncoding("UTF-8");
%>	
	<%--
	//2. join.jsp에서 입력한 가입할 회원내용을 request객체영역에서 꺼내와서
	//  MemberBean객체의 각변수에 저장
	//액션태그 사용
	--%>
	<jsp:useBean id="bean" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="bean"/>
	
<%	
	
	
	MemberDAO dao = new MemberDAO();
	
	dao.insertMember(bean);
    
	//4.회원가입에 성공(DB에 새로운 회원정보 추가에 성공)하면?
	// login.jsp페이지를 리다이렉트 방식으로 재요청(포워딩)해  이동 
	response.sendRedirect("login.jsp");

%>



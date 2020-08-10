
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
request.setCharacterEncoding("UTF-8"); 
%>

<jsp:useBean id="dao" class="member.MemberDAO"/>
<%
	
String id = (String)session.getAttribute("id");
		
	MemberBean bean=dao.Memberinfo(id);  

%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">	
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>		
	
	
<script type="text/javascript">

function sample6_execDaumPostcode() {
    
	new daum.Postcode({
    
		oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById("sample6_postcode").value = data.zonecode;
            
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
           
		}
    }).open();
	
}



function check() {
	
	location.href="../index.jsp";
	
}


</script>
</head>

<body>
	<div id="wrap">
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<nav id="sub_menu">
			<ul>
				<li><a href="./join.jsp">Join us</a></li>
				<li><a href="#">Company Info</a></li>
			</ul>		
		</nav>
		<article>
			<h1>My Information</h1>
			<form action="myInfo2pro.jsp" id="join" method="post" name="f">
				<fieldset>
					<legend>회원정보 수정</legend>				
					<label class="clear">아이디</label><input type="text" id="id"name="id" class="id" value="<%=id%>"  disabled style="background-color:#fff7fb;border-style: hidden;" ><br>					
					<label class="clear">비밀번호</label><input type="password" id="passwd"name="passwd" value=""  background-color:#fff7fb;border-style: hidden;"><br>					
					<label class="clear">이름</label><input type="text" name="name" id="name"value="<%=bean.getName()%>"background-color="#fff7fb" border-style="hidden"><br>
			    	<label class="clear">이메일</label><input type="email" name="email" id="email"value="<%=bean.getEmail() %>" background-color="#fff7fb" border-style="hidden"><br>	
					<label>우편번호</label><input type="text" id="sample6_postcode" name="postcode" placeholder="우편번호" value="<%=bean.getPostcode()%>" onblur="postcodecheck();"/>
					<input  class="dup" type="button" onclick="sample6_execDaumPostcode();" value="우편번호 찾기"><br>
					
					<label>주소</label><input type="text" id="sample6_address" name="address" size="40" placeholder="주소" value="<%=bean.getAddress()%>" onblur="addresscheck();"/>
					<input type="text" id="sample4_detailAddress" name="address1" value="<%=bean.getAddress1()%>" placeholder="상세주소"> <br>
					<span id="guide" style="color:#999;display:none"></span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="sample6_extraAddress" name="address2" value="<%=bean.getAddress2()%>" placeholder="참고항목"><br>
					<label class="clear">전화번호</label><input type="text" name="tel" id="tel" value="<%=bean.getTel()%>" background-color="#fff7fb" border-style="hidden" ><br>
				
				</fieldset>
				<div class="clear"></div>
				<div id ="buttons">
					<input type="submit" value="완료" class="submit" >&nbsp;&nbsp;&nbsp;
					<input type="button" onclick="check();" value="홈" class="submit">				
				</div>				
			</form>
		</article>
		<div class="clear"></div>
		<jsp:include page="../inc/bottom.jsp"></jsp:include>		
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userLogin</title>
</head>
<script type="text/javascript">

//엔터 입력시 ID중복검사. 검사 통과상태일시 제출
window.addEventListener("keydown", (e) => {
    if (e.key === 'Enter') {
        	submit();
    }
});

function submit(){
	
	let elem = document.getElementById('userId');
	if(!elem.value){
		elem.focus();
		alert('아이디를 입력해주세요.');
		return;
	}
	
	let elem2 = document.getElementById('userPw');
	if(!elem2.value){
		elem2.focus();
		alert('비밀먼호를 입력해주세요.');
		return;
	}
	
	
	let form = $j('.userLogin :input');
	let param = form.serialize();
	
	$j.ajax({
		url : "/user/login.do",
		dataType : "json",
		type : "POST",
		data : param,
		success : function(data, textStatus, jqXHR) {
			if(data.success=='wrongId'){
				alert('존재하지 않는 아이디입니다.');
				document.getElementById('userId').focus();
			}else if(data.success=='wrongPw'){
				alert('비밀번호가 잘못되었습니다.');
				document.getElementById('userPw').focus();
			}else if(data.success=='loged in'){
				alert('로그인 성공');
				location.href = "/board/boardList.do?pageNo=0";
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("에러");
		}
	});
}

</script>
<body>
<form class="userLogin" action="">
<table align="center">
	<tr><td><a href="/board/boardList.do">List</a></td></tr>
	<tr>
		<td>
			<table border="1">
				<tr>
					<td width="120" align="center">id</td>
					<td width="300"> 
           				<input id="userId" name="userId" type="text" size="25" autofocus> 
       				</td>
				</tr>
				<tr>
					<td width="120" align="center">pw</td>
					<td width="300">
						<input id="userPw" name="userPw" type="password" size="25">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right"><a href="#" onclick="submit()">login</a></td>
	</tr>
</table>
</form>
</body>
</html>
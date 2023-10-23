<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userJoin</title>
</head>
<script type="text/javascript">

//Id 중복 통과여부 플래그
var idSafe = false;

//엔터 입력시 ID중복검사. 검사 통과상태일시 제출
window.addEventListener("keydown", (e) => {
    if (e.key === 'Enter') {
        if(!idSafe){
        	isIdSafe();
        }else{
        	submit();
        }
    }
});

//폰넘버 숫자 이외 검열
$j(document).on("keyup", ".phoneNumber", function() { 
	let current = $j(this).val();
	let notNumber = /[^0-9]/g;
	let replaced = current.replace(notNumber, "");
	$j(this).val(replaced);
});

//우편번호 검열
function censorPostNum(input){
	let current = input.value;
	if(current.length==3){
		current = current+"-";
	}
	let notNumberSlash = /[^0-9|-]/g;
	let replaced = current.replace(notNumberSlash,"");
	let replaced2 = replaced.replaceAll('--',"");
	input.value=replaced2;
}

//id 한글 검열
function censorKorean(input){
	let current = input.value;
	let notNumberEnglish = /[^0-9|a-z|A-Z|!@#$%^&*?]/g;
	let replaced = current.replace(notNumberEnglish,"");
	input.value=replaced;
}

function censorExceptKorean(input){
	let current = input.value;
	let notNumberEnglish = /[0-9|a-z|A-Z|!@#$%^&*?]/g;
	let replaced = current.replace(notNumberEnglish,"");
	input.value=replaced;
}




function isIdSafe(){
	if(!idSafe){
		idDuplicateCheck();
	}else{
		blockIdInput(false);
	}
}
function blockIdInput(block){
	if(block){
		idSafe=true;
		document.getElementById('userId').readOnly=true;
		document.getElementById('idDuplicateCheckBtn').value='변경';
	}else{
		idSafe=false;
		document.getElementById('userId').readOnly=false;
		document.getElementById('idDuplicateCheckBtn').value='중복확인';
	}
}

function pwCheckStringChange(){
	let pwCheckResult = document.getElementById('pwCheckResult');
	if(pwCheck()){
		pwCheckResult.innerText = '일치';
	}else{
		pwCheckResult.innerText = '불일치';
	}
}

function idDuplicateCheck(){
	
	let id = document.getElementById('userId').value;
	if(id==''||!id){
		return;
	}else if(id.length>15){
		alert('id 는 최대 15글자만 가능합니다.');
		return;
	}
//	alert(id);
	id = encodeURIComponent(id);
	$j.ajax({
		url : '/user/'+id+'/duplicateCheck.do',
		dataType : "json",
		type : "GET",
		success : function(data, textStatus, jqXHR) {
			if(data.success=='Y'){
				alert(data.userId+'는 사용할 수 있는 아이디입니다.');
				blockIdInput(true);
			}else{
				alert('아이디 중복. 사용할 수 없는 아이디입니다!');
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("아이디 중복확인 실패");
		}
	});
}

function submit(){
	if(!validCheck()){
		return;
	}
	if(!idSafe){
		alert("아이디 중복 체크를 해주세요.");
		return;
	}
	
	let form = $j('.userJoin :input');
	let param = form.serialize();
	
	$j.ajax({
		url : "/user/insertUser.do",
		dataType : "json",
		type : "POST",
		data : param,
		success : function(data, textStatus, jqXHR) {
			if(data.success=='Y'){
				alert('회원가입에 성공했습니다.');
				location.href = "/board/boardList.do?pageNo=0";
			}else{
				alert('회원가입에 실패했습니다.');
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("회원가입 중 서버에 문제가 발생했습니다.");
		}
	});
	
}
function validCheck(){
	if(!necessaryCheck()){
		alert('필수 입력값들을 입력해주세요');
		return false;
	}
	if(!postNoCheck()){
		alert('우편번호가 형식에 맞지 않습니다.');
		return false;
	}
	if(!phoneCheck()){
		alert('전화번호가 형식에 맞지 않습니다.');
		return false;
	}
	if(!pwCheck()){
		alert('비밀번호확인과 비밀번호가 일치하지 않습니다.');
		return false;
	}
	return true;
}
function pwCheck(){
	let pw = document.getElementById('userPw');
	let pwCheck = document.getElementById('pwCheck');

	if(pw.value==pwCheck.value){
		return true;
	}else{
		return false;
	}
}

function necessaryCheck(){
	let necessary = ['userId','userPw','userPhone2','userPhone3','userName'];
	for(let i=0;i<necessary.length;i++){
		let value = document.getElementById(necessary[i]).value;
		if(!value){
  			return false;
		}
	}
	return true;
}

function phoneCheck(){
	let phone2 = document.getElementById('userPhone2').value;
	let phone3 = document.getElementById('userPhone3').value;
	if(isNaN(phone2)||isNaN(phone3)||phone2.length!=4||phone3.length!=4){
		//alert('Nan');
		return false;
	}else{
	//alert('num');
	return true;
	}
}

function postNoCheck(){
	let postNo = document.getElementById('userAddr1').value;
	let splitted = postNo.split('-');
	if(splitted.length!=2||postNo.length!=7){
		return false;
	}
	if(isNaN(splitted[0])||isNaN(splitted[1])||splitted[1].length!=3||splitted[0].length!=3){
		return false;
	}else{
		return true;
	}
}
</script>
<body>

	<form class="userJoin" action="">
		<table align="center">
			<tr><td><a href="/board/boardList.do">List</a></td></tr>
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">id</td>
							<td width="300"> 
                				<input id="userId" name="userId" type="text" size="25" placeholder="필수입력" onkeyup="censorKorean(this)" onchange="censorKorean(this)" maxlength='15'>
                				<input id="idDuplicateCheckBtn"type="button" value="중복확인" onclick="isIdSafe()"> 
              				</td>
						</tr>
						<tr>
							<td width="120" align="center">name</td>
							<td width="300"> 
                				<input id="userName" name="userName" type="text" size="25" placeholder="필수입력" onkeyup="censorExceptKorean(this)" onchange="censorExceptKorean(this)">
              				</td>
						</tr>
						<tr>
							<td width="120" align="center">pw</td>
							<td width="300"><input id="userPw" name="userPw" type="password" size="30" placeholder="필수입력" onkeyup="pwCheckStringChange()" maxlength="16"></td>
						</tr>
						<tr>
							<td width="120" align="center">pw check</td>
							<td width="300">
								<input id="pwCheck" type="password" size="30"  onkeyup="pwCheckStringChange()">
              					<span id="pwCheckResult">불일치</span>
							</td>
						</tr>
						<tr>
							<td width="120" align="center">phone</td>
							<td width="300">
								<select name="userPhone1">
									<c:forEach var="code" items="${codeList}">
										<option value="${code.codeId}">${code.codeName}</option>
									</c:forEach>
								</select>
								-
								<input id="userPhone2" class="phoneNumber" name="userPhone2" type="text" size="5" maxlength='4' placeholder="필수입력">
								-
								<input id="userPhone3" class="phoneNumber" name="userPhone3" type="text" size="5" maxlength='4' placeholder="필수입력">
								
							</td>
						</tr>
						<tr>
							<td width="120" align="center">postNo</td>
							<td width="300"><input id="userAddr1" name="userAddr1" type="text" size="5" maxlength='7' placeholder="111-111" onkeyup="censorPostNum(this)">
							</td>
						</tr>
						<tr>
							<td width="120" align="center">address</td>
							<td width="300"><input name="userAddr2" type="text" size="40"></td>
						</tr>
						<tr>
							<td width="120" align="center">company</td>
							<td width="300"><input name="userCompany" type="text" size="30"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td align="right"><a href="#" onclick="submit()">join</a></td></tr>
		</table>
	</form>
</body>
</html>
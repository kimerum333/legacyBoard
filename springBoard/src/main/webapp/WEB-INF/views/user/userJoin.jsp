<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userJoin</title>
<style>
.input-empty {
  border: 2px solid red;
}

.input-filled {
  border: 2px solid blue;
}
</style>
</head>
<script type="text/javascript">

//valid checks
var idSafe = false;
var pwSafe = false;
var nameSafe = false;
var phoneSafe = false;
var postNoSafe = false;
var addressSafe = false;
var companySafe = false;

function checkPw(){
	let password1 = document.getElementById('userPw');
	let password2 = document.getElementById('pwCheck');
	let password3 = document.getElementById('pwCheckResult');
	if(password1.value==password2.value&&password1.value){
		pwSafe = true;
		password3.innerText='일치';
		password1.classList.remove('input-empty');
		password1.classList.add('input-filled');
		password2.classList.remove('input-empty');
		password2.classList.add('input-filled');
	}else{
		pwSafe = false;
		password3.innerText='불일치';
		password1.classList.add('input-empty');
		password1.classList.remove('input-filled');
		password2.classList.add('input-empty');
		password2.classList.remove('input-filled');
	}
}


//엔터 입력시 ID중복검사. 검사 통과상태일시 제출
window.addEventListener("keydown", (e) => {
    if (e.key === 'Enter') {
       	if(!idSafe){
       		idDuplicateCheck();
       		return;
       	}else{
       		submit();
       	}
    }
});

function idDuplicateCheck(){
	
	if(idSafe){
		idSafe=false;
		document.getElementById('userId').readOnly=false;
		document.getElementById('idDuplicateCheckBtn').value='중복확인';
		document.getElementById('userId').classList.remove('input-filled');
		document.getElementById('userId').classList.add('input-empty');
		document.getElementById('userId').focus();
		return;
	}
	
	let id = document.getElementById('userId').value;
	if(id==''||!id){
		alert('아이디를 입력해주세요');
		return;
	}else if(id.length>15){
		alert('아이디는 최대 15글자만 가능합니다.');
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
				idSafe=true;
				document.getElementById('userId').readOnly=true;
				document.getElementById('idDuplicateCheckBtn').value='변경';
				document.getElementById('userId').classList.add('input-filled');
				document.getElementById('userId').classList.remove('input-empty');
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
	if(!idSafe){
		let elem = document.getElementById('userId');
		if(!elem.value){
			alert('아이디를 입력해주세요.');
			elem.focus();
			return;
		}
		elem.focus();
		alert('아이디 중복 체크를 해주세요.');
		return;
	}
	if(!pwSafe){
		let elem = document.getElementById('userPw');
		if(!elem.value){
			elem.focus();
			alert('비밀번호를 입력해주세요.');
			return;
		}
		let elem2 = document.getElementById('pwCheck');
		if(!elem2.value){
			elem2.focus();
			alert('비밀번호 확인란을 입력해주세요.');
			return;
		}
		elem2.focus();
		alert('비밀번호와 비밀번호확인이 불일치합니다.');
		return;
	}
	if(!nameSafe){
		let elem = document.getElementById('userName');
		if(!elem.value){
			elem.focus();
			alert('이름을 입력해주세요.');
			return;
		}
		elem.focus();
		alert('이름을 입력해주세요.');
		return;
	}
	if(!phoneSafe){
		let elem = document.getElementById('userPhone2');
		if(!elem.value){
			elem.focus();
			alert('전화번호 중간 4자리를 입력해주세요.');
			return;
		}else if(elem.value.length!=4){
			elem.focus();
			alert('전화번호 중간 4자리를 입력해주세요.');
			return;
		}
		elem = document.getElementById('userPhone3');
		if(!elem.value){
			elem.focus();
			alert('전화번호 마지막 4자리를 입력해주세요.');
			return;
		}else if(elem.value.length!=4){
			elem.focus();
			alert('전화번호 마지막 4자리를 입력해주세요.');
			return;
		}
		elem.focus();
		alert('전화번호를 제대로 입력해주세요.');
		return;
	}
	let postNoV = document.getElementById('userAddr1').value;
	if(postNoV.length!=7&&postNoV){
		alert('우편번호를 입력하시려면 6자리를 전부 입력해주세요');
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

function changeInputColor(element, bool){
	if(bool){
		element.classList.remove('input-empty');
		element.classList.add('input-filled');
	}else{
		element.classList.remove('input-filled');
		element.classList.add('input-empty');
	}
	
}

//폰넘버 숫자 이외 검열
function censorPhone(input) { 
	let current = input.value;
	let notNumber = /[^0-9]/g;
	let replaced = current.replace(notNumber, "");
	input.value=replaced;
	
	let phone2 = document.getElementById('userPhone2');
	let phone3 = document.getElementById('userPhone3');
	if(phone2.value.length==4){
		changeInputColor(phone2,true);
	}else{
		changeInputColor(phone2,false);
	}
	if(phone3.value.length==4){
		changeInputColor(phone3,true);
	}else{
		changeInputColor(phone3,false);
	}
	if(phone3.value.length==4&&phone2.value.length==4){
		phoneSafe = true;
	}else{
		phoneSafe = false;
	}
	
	
};

//우편번호 검열
function censorPostNum(input){
	let current = input.value;
	let notNumber = /[^0-9]/g;
	let replaced = current.replaceAll(notNumber,"");

	//TODO
	if(replaced.length>3){
		let one = replaced.substring(0,3);
		let two = replaced.substring(3);
		replaced = one+'-'+two;
	}
	input.value=replaced;
	if(replaced.length==7){
		postNoSafe=true;
		input.classList.add('input-filled');
		input.classList.remove('input-empty');
	}else{
		postNoSafe=false;
		input.classList.add('input-empty');
		input.classList.remove('input-filled');
	}
}

//id 한글 검열
function censorKorean(input){
	console.log(input.value);
	let current = input.value;
	let notNumberEnglish = /[^0-9|a-z|A-Z|!@#$%^&*?]/g;
	let replaced = current.replace(notNumberEnglish,"");
	input.value=replaced;
}

function censorExceptKorean(input){
	let current = input.value;
	let notNumberEnglish = /[0-9|a-z|A-Z|!@#$%^&*?]/g;
	let replaced = current.replace(notNumberEnglish,"");
	if(replaced.length>5){
		alert('이름은 최대 5글자까지만 입력할 수 있습니다.');
		replaced = replaced.substring(0,5);
	}
	if(replaced.length==0){
		nameSafe=false;
		input.classList.add('input-empty');
		input.classList.remove('input-filled');
	}else{
		nameSafe=true;
		input.classList.remove('input-empty');
		input.classList.add('input-filled');

	}
	input.value=replaced;
}

function censorAddress(input){
	let current = input.value;
	if(current.length>50){
		alert('주소는 최대 50글자까지만 입력할 수 있습니다.');
		let replaced = current.substring(0,50);
		input.value = replaced;
	}
}

function censorCompany(input){
	let current = input.value;
	if(current.length>20){
		alert('회사명은 최대 20글자까지만 입력할 수 있습니다.');
		let replaced = current.substring(0,20);
		input.value = replaced;
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
                				<input name="userId" id="userId" type="text" size="25" maxlength='15' class="necessary input-empty" oninput="censorKorean(this)" autofocus>
                				<input id="idDuplicateCheckBtn"type="button" value="중복확인" onclick="idDuplicateCheck()"> 
              				</td>
						</tr>
						
						<tr>
							<td width="120" align="center">pw</td>
							<td width="300">
								<input name="userPw" id="userPw" type="password" size="30" maxlength="16" class="necessary password input-empty" oninput="checkPw()">
							</td>
						</tr>
						<tr>
							<td width="120" align="center">pw check</td>
							<td width="300">
								<input id="pwCheck" type="password" size="30" class="password input-empty" oninput="checkPw()">
              					<span id="pwCheckResult" class="password"></span>
							</td>
						</tr>
						<tr>
							<td width="120" align="center">name</td>
							<td width="300"> 
                				<input name="userName" id="userName" type="text" size="25" maxlength="5" class="necessary input-empty" oninput="censorExceptKorean(this)" >
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
								<input name="userPhone2" id="userPhone2" name="userPhone2" type="text" size="5" maxlength='4' class="phoneNumber necessary input-empty" oninput="censorPhone(this)">
								-
								<input name="userPhone3" id="userPhone3" name="userPhone3" type="text" size="5" maxlength='4' class="phoneNumber necessary input-empty" oninput="censorPhone(this)" >
								
							</td>
						</tr>
						<tr>
							<td width="120" align="center">postNo</td>
							<td width="300">
								<input name="userAddr1" id="userAddr1" name="userAddr1" type="text" size="5" maxlength='7' placeholder="111-111" oninput="censorPostNum(this)">
							</td>
						</tr>
						<tr>
							<td width="120" align="center">address</td>
							<td width="300">
								<input name="userAddr2" type="text" size="40" oninput="censorAddress(this)">
							</td>
						</tr>
						<tr>
							<td width="120" align="center">company</td>
							<td width="300">
								<input name="userCompany" type="text" size="30" oninput="censorCompany(this)">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td align="right"><a href="#" onclick="submit()">join</a></td></tr>
		</table>
	</form>
</body>
</html>
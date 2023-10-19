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
function pwCheckStringChange(){
	let pwCheckResult = document.getElementById('pwCheckResult');
	if(pwCheck()){
		pwCheckResult.innerText = '��ġ';
	}else{
		pwCheckResult.innerText = '����ġ';
	}
}

function submit(){
	if(!validCheck()){
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
			alert("�Խù� ��ϿϷ�");

			alert("�޼���:" + data.success);

			location.href = "/board/boardList.do?pageNo=0";
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("�Խù� ��� ����");
		}
	});
	
}
function validCheck(){
	if(!necessaryCheck()){
		alert('�ʼ� �Է°����� �Է����ּ���');
		return false;
	}
	if(!postNoCheck()){
		alert('�����ȣ�� ���Ŀ� ���� �ʽ��ϴ�.');
		return false;
	}
	if(!phoneCheck()){
		alert('��ȭ��ȣ�� ���Ŀ� ���� �ʽ��ϴ�.');
		return false;
	}
	if(!pwCheck()){
		alert('��й�ȣȮ�ΰ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.');
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
	let necessary = ['userId','userPw','userPhone2','userPhone3'];
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
                				<input id="userId" name="userId" type="text" size="25" placeholder="�ʼ��Է�">
                				<input type="button" value="�ߺ�Ȯ��"> 
              				</td>
						</tr>
						<tr>
							<td width="120" align="center">pw</td>
							<td width="300"><input id="userPw" name="userPw" type="text" size="30" placeholder="�ʼ��Է�" onkeyup="pwCheckStringChange()"></td>
						</tr>
						<tr>
							<td width="120" align="center">pw check</td>
							<td width="300">
								<input id="pwCheck" type="text" size="30"  onkeyup="pwCheckStringChange()">
              					<span id="pwCheckResult">����ġ</span>
							</td>
						</tr>
						<tr>
							<td width="120" align="center">phone</td>
							<td width="300">
								<input name="userPhone1" type="text" size="5" maxlength='3'>
								-
								<input id="userPhone2" name="userPhone2" type="text" size="5" maxlength='4' placeholder="�ʼ��Է�">
								-
								<input id="userPhone3" name="userPhone3" type="text" size="5" maxlength='4' placeholder="�ʼ��Է�">
								
							</td>
						</tr>
						<tr>
							<td width="120" align="center">postNo</td>
							<td width="300"><input id="userAddr1" name="userAddr1" type="text" size="5" maxlength='7' placeholder="111-111">
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
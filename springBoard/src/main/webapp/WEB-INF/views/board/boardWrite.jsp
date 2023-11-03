<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

const titles = { "max": 16, "name": "제목" };
const comments = { "max": 300, "name": "게시글 내용" };

function maxsLength(input,obj){
	if(input.value.length>obj.max){
		alert(obj.name+'은 최대 '+obj.max+'자 까지만 입력할 수 있습니다.');
		input.value=input.value.substring(0,obj.max);
		input.focus();
	}
}

	var boardWriteRowCount = 1;
	var optionStr = '';

	$j(document).ready(function() {

		let options = document.getElementsByClassName("boardTypeOption");
		for (let i = 0; i < options.length; i++) {
			let value = options[i].value;
			let text = options[i].textContent;
			let opt = '<option value="'+value+'">' + text + '</option>';
			optionStr += opt;
		}

		$j("#submit").on("click", function() {

			let form = $j('.boardWrite :input');
			let param = form.serialize();

			$j.ajax({
				url : "/board/boardWriteAction.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					alert("게시물 등록완료");

					alert("메세지:" + data.success);

					location.href = "/board/boardList.do?pageNo=0";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("게시물 등록 실패");
				}
			});
		});
	});

	function addRow() {
		document.activeElement.blur();
		boardWriteRowCount++;

		let str1 = '<tr class="boardWriteRow'+boardWriteRowCount+'">\
						<td width="120" align="center">Type</td>\
						<td width="400">\
							<select name="boardVoList['+boardWriteRowCount+'].boardType">';
		let str2 = optionStr;
		let str3 = '</select>\
						</td>\
					</tr>\
		    		<tr class ="boardWriteRow' + boardWriteRowCount + '">\
		    			<td width="120" align="center">\
							Title\
						</td>\
						<td width="400">\
							<input name="boardVoList['+boardWriteRowCount+'].boardTitle" type="text" size="47" value="" align="left" oninput="maxsLength(this,titles)"> \
							<input type="button" value="행삭제" onclick="deleteRow('
				+ boardWriteRowCount
				+ ')" align="right">\
						</td>\
					</tr>\
					<tr class ="boardWriteRow'+boardWriteRowCount+'">\
						<td height="300" align="center">\
							Comment\
						</td>\
						<td valign="top">\
							<textarea name="boardVoList['+boardWriteRowCount+'].boardComment"  rows="20" cols="55" oninput="maxsLength(this,comments)"></textarea>\
						</td>\
					</tr>';
		let newRow = $j(str1 + str2 + str3);

		$j('#addPoint').before(newRow);
	}
	function deleteRow(boardWriteRowTarget) {
		//		alert(boardWriteRowTarget);
		document.activeElement.blur();
		let targetString = '.boardWriteRow' + boardWriteRowTarget;
		$j(targetString).remove();
	}
</script>
<body>
	<form class="boardWrite" action="">
		<table align="center">
			<tr>
				<td align="right">
					<input type="button" value="행추가" onclick="addRow()"> 
					<input id="submit" type="button" value="작성">
				</td>
			</tr>
			<tr>
				<td>
					<table border="1">
						<tr class="boardWriteRow1">
							<td width="120" align="center">
								Type
							</td>
							<td width="400">
								<select name="boardType">
									<c:forEach var="code" items="${codeList}">
										<option class="boardTypeOption" value="${code.codeId}">
											${code.codeName}
										</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr class="boardWriteRow1">
							<td width="120" align="center">
								Title
							</td>
							<td width="400">
								<input name="boardTitle" type="text" size="50" value="" oninput="maxsLength(this,titles)">
							</td>
						</tr>
						<tr class="boardWriteRow1">
							<td height="300" align="center">
								Comment
							</td>
							<td valign="top">
								<textarea name="boardComment" rows="20" cols="55" oninput="maxsLength(this,comments)"></textarea>
							</td>
						</tr>
						<tr id="addPoint"></tr>
						<!--  -->
						<tr>
							<td align="center">
								Writer
							</td>
							<td>
								${loginUser.userName}
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href="/board/boardList.do">
						List
					</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
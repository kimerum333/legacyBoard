<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>mbti write</title>
</head>
<script type="text/javascript">

$j(document).ready(function() {
	$j("#submit").on("click", function() {

		let form = $j('.mbtiwrite :input');
		let param = form.serialize();

		$j.ajax({
			url : "/mbti/writeAction.do",
			dataType : "json",
			type : "POST",
			data : param,
			success : function(data, textStatus, jqXHR) {
				alert("mbti ��ϿϷ�");

				alert("�޼���:" + data.success);

				location.href = "/mbti/write.do";
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("�Խù� ��� ����");
			}
		});
	});
}); // This is the missing closing bracket

</script>
<body>
<form class="mbtiwrite" action="/mbti/writeAction.do" method="post">
Ÿ�� <select name="boardType">
	<c:forEach var="code" items="${codeList}">
		<option class="boardTypeOption" value="${code.codeId}">
			${code.codeName}
		</option>
	</c:forEach>
	</select>
<br/>
mbti����<textarea name="boardComment" rows="20" cols="55" ></textarea>
<br/>
<input type="button" id="submit" value="���">
</form>
</body>
</html>
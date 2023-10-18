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
</script>
<body>
	<td align="right"><a href="/board/boardList.do">List</a></td>		
	<form class="boardWrite" action="">
		<table align="center">
			<tr>
				<td>
					<table border="1">
						<tr class="boardWriteRow1">
							<td width="120" align="center">Type</td>
							<td width="400"><select name="boardType">
									<c:forEach var="code" items="${codeList}">
										<option class="boardTypeOption" value="${code.codeId}">${code.codeName}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr class="boardWriteRow1">
							<td width="120" align="center">Title</td>
							<td width="400"><input name="boardTitle" type="text" size="50" value=""></td>
						</tr>
						<tr class="boardWriteRow1">
							<td height="300" align="center">Comment</td>
							<td valign="top"><textarea name="boardComment" rows="20" cols="55"></textarea></td>
						</tr>
						<tr id="addPoint"></tr>
						<!--  -->
						<tr>
							<td align="center">Writer</td>
							<td></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><a href="/board/boardList.do">List</a></td>
			</tr>
		</table>
	</form>
</body>
</html>
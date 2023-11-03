	<%@ page language="java" contentType="text/html; charset=EUC-KR"
	    pageEncoding="EUC-KR"%>
	<%@include file="/WEB-INF/views/common/common.jsp"%>    
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>boardView</title>
	</head>
	
<script type="text/javascript">




	 $j(document).ready(function(){
		 editCancelBtn();
	 })
		function editBtn(){
			$j(".viewer").hide();
			$j(".editor").show();
		}
		function editCancelBtn(){
			$j(".editor").hide();
			$j(".viewer").show();
		}

		function editUpdateBtn(){
			let form = $j('.boardView :input');
			let param = form.serialize();
			let url = window.location.href;
			
			// URL 경로를 분할
			let parts = url.split("/");

			// boardType, boardNum 추출
			let boardType = parts[parts.indexOf("board") + 1];
			let boardNum = parts[parts.indexOf("board") + 2];
			
			param = param+"&boardNum="+boardNum;
			param = param+"&boardType="+boardType;

			$j.ajax({
			    url : "/board/boardUpdateAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("수정완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/"+boardType+"/"+boardNum+"/boardView.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});	 
			
		}
		function deleteBtn(){
			let url = window.location.href;
			
			// URL 경로를 분할
			let parts = url.split("/");

			// boardType, boardNum 추출
			let boardType = parts[parts.indexOf("board") + 1];
			let boardNum = parts[parts.indexOf("board") + 2];
			
			let param = "boardNum="+boardNum;
			param = param+"&boardType="+boardType;
			
			$j.ajax({
			    url : "/board/boardDeleteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("삭제완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=0";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
			
		}
		const titles = { "max": 16, "name": "제목" };
		const comments = { "max": 300, "name": "게시글 내용" };

		function maxsLength(input,obj){
			if(input.value.length>obj.max){
				alert(obj.name+'은 최대 '+obj.max+'자 까지만 입력할 수 있습니다.');
				input.value=input.value.substring(0,obj.max);
				input.focus();
			}
		}
</script>
	<body>
	<form class="boardView">
		<table align="center">
			<tr>
				<td align="right">
					<input type="button" value="수정" class="editor" onclick="editUpdateBtn()">
				</td>
			</tr>
			<tr>
				<td>
					<table border ="1">
						<tr>
							<td width="120" align="center">
								Title
							</td>
							<td width="400" class="viewer">
								${board.boardTitle}
							</td>
							<td width="400" class="editor">
								<input name="boardTitle" type="text" value="${board.boardTitle}" oninput="maxsLength(this,titles)" >
							</td>
						</tr>
						<tr>
							<td height="300" align="center">
								Comment
							</td>
							<td class="viewer">
								${board.boardComment}
							</td>
							<td class="editor">
								<textarea name="boardComment"  rows="20" cols="55" oninput="maxsLength(this,comments)" >${board.boardComment}</textarea>
							</td>
						</tr>
						<tr>
							<td align="center">
								Writer
							</td>
							<td align="left">
								${board.creatorName}
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
			<c:if test="${loginUser.userId eq board.creator}">
				<td align="right" class="viewer">
					<a href="#" onclick="editBtn()">Edit</a>
				</td>
				<td align="right" class="editor">
					<a href="#" onclick="editCancelBtn()">Cancel</a>
				</td>
				<td align="right">
					<a href="#" onclick="deleteBtn()">Delete</a>
				</td>
			</c:if>
				
				<td align="right">
					<a href="/board/boardList.do">List</a>
				</td>
			</tr>
		</table>
	</form>
	</body>
	</html>
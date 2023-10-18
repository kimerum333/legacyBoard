<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	function checkAll(checkAllBox){
		const searchBoxes = document.getElementsByClassName('search_box');
		for(let i=0; i<searchBoxes.length; i++){
	        searchBoxes[i].checked = checkAllBox.checked;
		}
	}
	function checkOne(checkBox){
		let allChecked = true;
		const searchBoxes = document.getElementsByClassName('search_box');
		for(let i=0; i<searchBoxes.length; i++){
	        if(!searchBoxes[i].checked){
	        	allChecked = false;	
	        	break;
	        }
		}
		if(!allChecked){
			document.getElementById('select_all_box').checked=false;
		}else{
			document.getElementById('select_all_box').checked=true;
		}
		
	}
	function loadList(){
		let param = '?';
		let checkedBoxes = [];
		let boxes = document.getElementsByClassName('search_box');
		for(let i=0;i<boxes.length;i++){
			if(boxes[i].checked){
				checkedBoxes.push(boxes[i].value);
			}
		}
		for(let i=0;i<checkedBoxes.length;i++){
			if(i!=0){
				param+='&';
			}
			param+='searchConditions['+i+']='+checkedBoxes[i];
		}
		//param 완성됨
		let encoded = encodeURI(param);
		$j.ajax({
			url: "/board/anotherBoardList.do"+encoded,
			dataType: "Json",
			type: "GET",
			success: function(data, textStatus, jqXHR)
		    {				
				//console.log(JSON.stringify(data.boardList));
				listReload(data.boardList);
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});
	}
	function listReload(boardList){  //받은 map을 바탕으로 리스트를 교체
		//console.log(JSON.stringify(boardList));
		let points = $j('.boardLists');
		for(let i=0;i<points.length;i++){
			points.eq(i).empty();			
		}
		
		for(let i=0;i<boardList.length;i++){
			let element = listElementBuilder(boardList[i]);
			points.eq(i).append(element);
		}
	}
	function listElementBuilder(board){ //적절한 엘리먼트 생성
		//console.log(JSON.stringify(board));
		let htmlStr = '\
			<td align="center">\
				'+board.boardTypeKr+'\
			</td>\
			<td>\
				'+board.boardNum+'\
			</td>\
			<td>\
				<a href = "/board/'+board.boardType+'/'+board.boardNum+'/boardView.do?pageNo=0">'+board.boardTitle+'</a>\
			</td>\
		';
		return $j(htmlStr);
	}
	

</script>
<body>
<table  align="center">
	<tr>
		<td align="left">
			<a href = "#">login</a>
			<a href = "#">join</a>
		</td>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr class="boardLists">
						<td align="center">
							${list.boardTypeKr}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
	<tr>
		<td align="left">
			<input type="checkbox" id="select_all_box" onclick="checkAll(this)">
			<label for="select_all_box">전체</label>			
			<c:forEach items="${codeList}" var="code">
				<input class ="search_box" type="checkbox" id="${code.codeId}_box" onclick="checkOne(this)" value="${code.codeId}">
				<label for="${code.codeId}_box">${code.codeName}</label>								
			</c:forEach>
			<input type="button" id="search_btn" onclick="loadList()" value="조회" />
		</td>
	</tr>
</table>
</body>
</html>
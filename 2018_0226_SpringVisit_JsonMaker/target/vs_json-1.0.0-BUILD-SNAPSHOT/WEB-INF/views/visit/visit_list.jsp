<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"  
      href="${ pageContext.request.contextPath }/resources/css/visit.css">

<script type="text/javascript" 
      src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>

<script type="text/javascript">

var global_f;//전역변수

function del(f)
{
	//f는 지역변수
	global_f = f;
	var idx   = f.idx.value;   //게시물번호
	var c_pwd = f.c_pwd.value; //내가 입력된 비번
	
	if(c_pwd==''){
		alert('삭제할 게시물의 \n비밀번호를 입력하세요');
		return;
	}
	//        VisitCheckPwdAction
	var url = 'check_pwd.do'; // check_pwd.do?idx=10&c_pwd=1234
	var param = 'idx=' + idx + '&c_pwd=' + c_pwd;
	
	sendRequest(url, param, resultFn_Del, "GET");
}

//삭제결과처리 콜백함수
function resultFn_Del(){
	
	if(xhr.readyState==4 && xhr.status==200){
		 //수신데이터 가져오기
		 var data = xhr.responseText;
		 
		 // alert("[" + data + "]");
		 if(data.indexOf('diff') != -1){
			 alert('비밀번호가 틀립니다');
			 return;
		 }
		 
		 if(confirm('정말삭제하시겠습니까?')==false) return;
		 
		 global_f.action='delete.do';
		 global_f.submit();
		 
	}
	
}




function modify(f)
{
	//f는 지역변수
	global_f = f;
	var idx   = f.idx.value;   //게시물번호
	var c_pwd = f.c_pwd.value; //내가 입력된 비번
	
	if(c_pwd==''){
		alert('삭제할 게시물의 \n비밀번호를 입력하세요');
		return;
	}
	//        VisitCheckPwdAction
	var url = 'check_pwd.do'; // check_pwd.do?idx=10&c_pwd=1234
	var param = 'idx=' + idx + '&c_pwd=' + c_pwd;
	
	sendRequest(url, param, resultFn_Modify, "GET");
	
}


function resultFn_Modify(){
	
	if(xhr.readyState==4 && xhr.status==200){
		 //수신데이터 가져오기
		 var data = xhr.responseText;
		 
		 
		 if(data.indexOf('diff') != -1){
			 alert('비밀번호가 틀립니다');
			 return;
		 }
		 
		
		 
		 global_f.action='modify_form.do';
		 global_f.submit();
		 
	}
	
}

function find(){
	var search = document.getElementById("search").value;
	var search_text = document.getElementById("search_text").value;
	
	//전체보기가 아닌데 검색내용이 비어있으면
	if(search != 'all' && search_text==''){
		alert('검색할 내용을 입력하세요');
		document.getElementById("search_text").focus();
		return;
	}
	
	//검색내용을 인자로 list.do요청
	location.href='list.do?search=' + search + 
			      '&search_text=' +
			       encodeURIComponent(search_text)  ;
}


//윈도의 초기화 이벤트
window.onload = function(){
	//                    0      1        2           3  
	var search_array = ['all','name','content','name_content'];
	var search = document.getElementById("search");
	
	for(var i=0;i<search_array.length;i++){
		
		if('${ param.search }' == search_array[i]){
		    search[i].selected = true;
		    break;
		}
	}
};


</script>

</head>
<body>

<%-- 현재 ContextPath : ${ pageContext.request.contextPath }<br> --%>

<div id="main_box">
	<h1>::::방명록 리스트::::</h1>
	<div align="center">
	    <input type="button"  value="글쓰기" 
	           onclick="javascript:location.href='insert_form.do'">
	</div>
	
	<!-- 검색메뉴 -->
	<div align="center" style="margin-top:20px;">
	   <select id="search" class="search_style">
	   		<option value="all">전체보기</option>
	   		<option value="name">이름</option>
	   		<option value="content">내용</option>
	   		<option value="name_content">이름+내용</option>
	   </select>
	   <input id="search_text"  value="${ param.search_text }" class="search_style">
	   <input type="button" value="검색" 
	          onclick="find();" class="search_style">
	</div>
	
	<!--  for(VisitVo vo : list ) -->
	<c:forEach var="vo" items="${ list }">
		<div class="visit_box">
		  <div class="type_content">${ vo.content }</div>
		  <div class="type_name">작성자:${ vo.name } (${ vo.ip })</div>
		  <div class="type_regdate">작성일자:${ vo.regdate }</div>
		  <div>
			  <form>   
			      <input type="hidden" name="idx" value="${ vo.idx }">
			      비밀번호(${ vo.pwd }):<input type="password"  name="c_pwd">
			      <input type="button"    value="수정"
			             onclick="modify(this.form);">
			      <input type="button"    value="삭제"  
			             onclick="del(this.form);"  >
			  </form>    
		  </div>
		</div>
	</c:forEach>
	
</div>






</body>
</html>
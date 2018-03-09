<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
function send(f)
{
	var name = f.name.value;
	//var content = f.content.value;
	var content = CKEDITOR.instances.content.getData();
	
	var pwd = f.pwd.value;
	
	if(name==''){
		alert('작성자 이름을 입력하세요');
		f.name.focus();
		return ;
	}
	
	if(content==''){
		alert('내용을 입력하세요');
		f.content.focus();
		return;
	}
	
	if(pwd==''){
		alert('비밀번호를 입력하세요');
		f.pwd.focus();
		return;
	}
	
	f.action = 'insert.do';
	f.submit();//전송
	
}

</script>

</head>
<body>

<form>
	<table border="1" align="center">
		<caption>::::방명록쓰기::::</caption>
		<tr>
			<th>작성자</th>
			<td><input name="name"></td>
		</tr> 
		<tr>
		    <th>내용</th>
		    <td>
		    	<textarea name="content"  rows="5"  cols="50"></textarea>
		    	<script>
					// Replace the <textarea id="editor1"> with a CKEditor
					// instance, using default configuration.
					CKEDITOR.replace( 'content', {
					filebrowserUploadUrl: '${pageContext.request.contextPath}/ckeditorImageUpload.do'	
					});
						
					CKEDITOR.on('dialogDefinition', function( ev ){
				            var dialogName = ev.data.name;
				            var dialogDefinition = ev.data.definition;
				          
				            switch (dialogName) {
				                case 'image': //Image Properties dialog
						              //dialogDefinition.removeContents('info');
						              dialogDefinition.removeContents('Link');
						              dialogDefinition.removeContents('advanced');
						              break;
					    }
					 });
				</script>
		    </td>
		</tr>

		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="pwd"></td>
		</tr>
		
		
		<tr>
			<td colspan="2" align="center">
			   <input type="button" value="글쓰기"
			          onclick="send(this.form);" >
			   <input type="button" value="목록보기"
			          onclick="location.href='list.do'">
			</td>
		</tr>

	</table>
</form>



</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">

$(function() {
	//댓글수정
	$(".btn-edit").click(function() {
		//alert(this.value); //선택한 버튼 value = 댓글 번호
		console.log(this.value);
		let cm_id = this.value;
		let writer = $("#writer_" + cm_id).val();
		let content = $("#content_" + cm_id).val();

		console.log("writer : "  + writer);
		console.log("content : " + content);

		$("#div_"+ cm_id).empty();
		$("#div_"+ cm_id).append(writer + "<br />");
		$("#div_"+ cm_id).append("<input type='text' id='content_"+ cm_id + "' value ='"+ content + "'>");
		$("#div_"+ cm_id).append("<button class='btn-update' value='" + cm_id+"'>완료</button>");
		$("#div_"+ cm_id).append("<input type='hidden' id='writer_"+ cm_id + "' value ='"+ writer + "'>");

	})


	//댓글저장
	 $(document).on("click",".btn-update",function(){
			console.log(this.value); //선택한 버튼 value = 댓글 번호
			console.log($("#content_"+ this.value).val());
			console.log($("#writer_"+ this.value).val());

			//$.ajax();
     })

})//document.ready()
</script>
</head>
<body>
<div>
	<div id="div_1">
		작성자 <br />
	    댓글내용용 <br />


	    <input type="hidden" id="content_1" value="댓글내용용">
	    <input type="hidden" id="writer_1" value="작성자">

	<button class='btn-edit' value='1'>댓글수정</button> value값에 댓글id 넣기
	</div>
</div>
<div>
	<div id="div_2">
		작성자 <br />
	    댓글내용용 <br />


	    <input type="hidden" id="content_2" value="댓글내용용2222">
	    <input type="hidden" id="writer_2" value="작성자222">
	    <button class='btn-edit' value='2'>댓글수정</button> value값에 댓글id 넣기
    </div>

</div>
<div>
	<div id="div_3">
		작성자 <br />
	    댓글내용용 <br />


	    <input type="hidden" id="content_3" value="댓글내용요용3333">
	    <input type="hidden" id="writer_3" value="작성자33333">
	    <button class='btn-edit' value='3'>댓글수정</button> value값에 댓글id 넣기
    </div>

</div>
</body>
</html>
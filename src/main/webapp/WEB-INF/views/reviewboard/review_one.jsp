<%@page import="com.multi.mini6.reviewboard.vo.ReviewCommentVO"%>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
        	session.setAttribute("user", "1");
        %>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap CSS 추가 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Favicons -->
    <link href="../../../resources/assets/img/favicon.png" rel="icon">
    <link href="../../../resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Muli:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
          rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="../../../resources/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="../../../resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="../../../resources/assets/css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
    $(function() {
        $(".btn-edit").click(function() {


            let cm_id = this.value;
            let content = $("#cm_content_" + cm_id).val();
            let member_id= $("#member_id_" + cm_id).val();


            $("#div_"+ cm_id).empty();
            $("#div_"+ cm_id).append(member_id + "<br />");
            $("#div_"+ cm_id).append("<input type='text' id='content_" + cm_id + "' value ='"+ content + "'>");
            $("#div_"+ cm_id).append("<button class='btn-update' value='" + cm_id + "'>완료</button>");
            $("#div_"+ cm_id).append("<input type='hidden' id='member_id_" + cm_id + "' value ='"+ member_id + "'>");
            //hidden 필드 만들기 member_id

        });

        $(document).on("click", ".btn-delete", function() {

            let cm_id = $(this).val();

             $.ajax({
                 url: "review_comment_delete", // 삭제를 담당하는 컨트롤러 URL
                 data: {
                     cm_id: cm_id // 삭제할 댓글의 ID
                 },
                 success: function(response) {
                     $('#div_${cm_id}').parent().remove();
                     alert("댓글 삭제가 완료되었습니다.");
                 } //success
             }); //ajax
        }); ;//document.on

        $(document).on("click", ".btn-update", function() {
            let cm_id = $(this).val();
            let updatedContent = $("#content_" + cm_id).val()
            let updatedWriter = $("#member_id_" + cm_id).val();

            $("#div_"+ cm_id).empty();
            $("#div_"+ cm_id).append(updatedWriter + "<br />" + updatedContent)
            console.log(cm_id)
            console.log("updatedContent : " + updatedContent)
            console.log("updatedWriter  : " + updatedWriter)


             $.ajax({
             url: "review_comment_update",
             data: {

             cm_id: cm_id,
             cm_content: updatedContent

             },
             success: function(response1) {
             $('#div_').append("<div class='card mb-2'><div class='card-body'>"  + response1 +"</div></div>" )


             alert("댓글 수정이 완료되었습니다.")


             }
        });


    });
         $(function() {
             $('#b1').click(function() {
                 console.log(${reviewVO.review_id})
                 console.log($('#review').val())
                 console.log(${user})

                 $.ajax({
                     url: "review_comment_insert",
                     type: "POST",
                     data: {
                         review_id : '${reviewVO.review_id}',
                         cm_content : $('#review').val(),
                         member_id : '${user}'
                     },
                     success: function(response) {

                         $('#result').append(`
                             <div class='card mb-2'>
                                 <div class='card-body'>
                                    ${response}
                                     <button class='btn-edit' id='btn_${dto.getCm_id()}' value='${dto.getCm_id()}'>댓글수정</button>
                                     <button class='btn-delete' value='${dto.getCm_id()}'>댓글삭제</button>
                                 </div>
                             </div>
                         `);
                         $('#review').val('');
                         alert("댓글 작성이 완료되었습니다." + response)
                     }
                 })
             })
         })
                   })
</script>


    <style>

     .logo-link {
                display: flex;
                align-items: center;
                text-decoration: none; /* 링크 밑줄 제거 */
            }

            .logo-image {
                max-width: 300px; /* 로고 이미지 크기 조정 */
                height: auto; /* 이미지 높이 자동 조절 */
            }

            .logo-text {
                font-size: 24px; /* 로고 텍스트 크기 */
                font-weight: bold; /* 글씨 굵게 */
                color: #333; /* 글씨 색상 */
                /*margin-left: 5px; !* 이미지와 텍스트 간격 *!*/
            }

.title-section {
    text-align: center;
    margin-top: 50px; /* 제목과 상단 간격 조정 */
}

    .edit-delete-buttons {
        position: fixed;
        top: 20px;
        right: 20px;
        /* 추가적인 스타일링이 필요하다면 여기에 작성하세요. */
    }
    .content-section {
        width: 60%;
        float: left;
        padding-right: 20px; /* 이미지와 내용 사이 간격 조정 */
    }

    .image-section {
        width: 30%;
        float: left;
    }

    .edit-delete-buttons {
        position: fixed;
        top: 20px;
        right: 20px;
        /* 추가적인 스타일링이 필요하다면 여기에 작성하세요. */
    }
    </style>
</head>
  <!-- ======= Top Bar ======= -->
  <jsp:include page="/WEB-INF/views/topbar.jsp"/>
  <!-- End Top Bar -->

  <%-- header --%>
  <jsp:include page="/WEB-INF/views/header.jsp"/>

 <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2>Setting</h2>
                <ol>
                    <li><a href="../mainpage/index.jsp">Home</a></li>
                    <li>Setting</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->
<body>
<div class="container">
    <div class="row">
        <div class="col-md-6"></div> <!-- 왼쪽 여백을 만들기 위한 빈 칼럼 -->
        <div class="col-md-6 d-flex justify-content-end"> <!-- 오른쪽 상단 맨 끝으로 버튼 배치 -->
            <a href="review_update_move" class="btn btn-primary mr-2">글 수정하기</a>
            <a href="review_delete_move" class="btn btn-primary">글 삭제하기</a>
        </div>
    </div>
</div>
<div>
<div class="container mt-4">
    <div class="title-section">
        <h2>${reviewVO.review_title}</h2>
    </div>
    <p>작성자: ${reviewVO.member_id}</p>
    <p>작성일자: ${reviewVO.review_createdAt}</p>
    <p>수정일자: ${reviewVO.review_updatedAt}</p>
    <p>조회수: ${reviewVO.review_views}</p>

 <div class="text-right">
                <div style="margin: 0 auto; max-width: 600px;">
                    <p>${reviewVO.review_content}</p>
                </div>
            </div>

        <div class="input-group mb-3">
            <input id="review" type="text" class="form-control" placeholder="댓글입력">
            <div class="input-group-append">
                <button id="b1" class="btn btn-primary" type="button">댓글 달기</button>
            </div>
        </div>
        <hr class="mt-4 mb-4">
         <!-- 댓글 목록 -->
         <div id="result">
             <%
             List<ReviewCommentVO> list = (List<ReviewCommentVO>) request.getAttribute("list");
             for (ReviewCommentVO dto : list) {
             %>
         <div class="card mb-2">
             <div class="card-body">
                 <div id="div_<%=dto.getCm_id()%>">
                     <p class="mb-1"><strong><%=dto.getMember_id()%></strong></p>
                     <p class="mb-1"><%=dto.getCm_content()%></p>
                     <p class="mb-1"><small><%=dto.getCm_createAt()%></small></p>
                     <input type="hidden" id="cm_content_<%=dto.getCm_id()%>" value="<%=dto.getCm_content()%>">
                     <input type="hidden" id="member_id_<%=dto.getCm_id()%>" value="<%=dto.getMember_id()%>">

                      <button class="btn btn-secondary btn-edit" id="btn_<%=dto.getCm_id()%>" value="<%=dto.getCm_id()%>">댓글수정</button>
                      <button class="btn btn-secondary btn-delete" value="<%=dto.getCm_id()%>">댓글삭제</button>
                 </div>
             </div>
         </div>
             <% } %>
         </div>
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

</body>
</html>
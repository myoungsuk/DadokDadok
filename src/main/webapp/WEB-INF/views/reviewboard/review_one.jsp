<%@page import="com.multi.mini6.reviewboard.vo.ReviewCommentVO"%>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
session.setAttribute("user", "1");
%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap CSS 추가 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<jsp:include page="/WEB-INF/views/head.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">


  $(document).ready(function(){
    // 파일 불러오기
                 console.log("review_id: " + ${reviewVO.review_id});
       (function(){


                 let review_id = ${reviewVO.review_id};
                   console.log("review_id22 : " + review_id);

                   let review_id_number = Number(review_id);  // 123
                   console.log("review_id_number : " + review_id_number);


               $.getJSON("getAttachList/?review_id=" + review_id_number).done(function(arr) {



                   let img_str = "";
                   let file_str = "";
                   $(arr).each(function(i, attach){
                      // 이미지 파일인 경우 이미지 보여지기

                     if(attach.review_file_type == "png" || attach.review_file_type == "jpg" || attach.review_file_type == "jpeg" || attach.review_file_type == "gif") {
                         let fileCallPath = "/resources/reviewBoardUpload/" + attach.review_uuid + "_" + encodeURIComponent(attach.review_file_name);

                          img_str += "<span class='img_list' data-uuid='" + attach.review_uuid + "' data-filename='" + attach.review_file_name + "' data-type='" + attach.review_file_type + "'>";
                          img_str += "<span>" + attach.review_file_name + "</span>";
                          img_str += "<div><img src='" + fileCallPath + "'></div></span></div></div>";

                          $(".img_file").html(img_str);
                       } else {
                       // 이미지 파일이 아닌경우

                          file_str += "<div class='file_list' data-uuid='" + attach.review_uuid + "' data-filename='" + attach.review_file_name + "' data-type='" + attach.review_file_type + "'> ";
                          file_str += "<div><img src='/resources/img/attach.png'></div>";
                         file_str += "<span>" + attach.review_file_name + "</span></div>";
                        $(".file").html(file_str);
                       } // if end
                   }); // arr each end

                 }); // getJSON end
             })();// function end
    // ============================================================================================

    $(".btn-edit").click(function() {


                let cm_id = this.value;
                let content = $("#cm_content_" + cm_id).val();
                let member_id= $("#member_id_" + cm_id).val();


                $("#div_"+ cm_id).empty();
                $("#div_"+ cm_id).append(member_id + "<br />");
                $("#div_"+ cm_id).append("<input type='text' id='content_" + cm_id + "' value ='"+ content + "'>");
               $("#div_"+ cm_id).append("<button class='btn btn-success btn-update' value='" + cm_id + "'>완료</button>");
                $("#div_"+ cm_id).append("<input type='hidden' id='member_id_" + cm_id + "' value ='"+ member_id + "'>");
                //hidden 필드 만들기 member_id

    }); // btn-edit click end

    $(document).on("click", ".btn-delete", function() {

                       let cm_id = $(this).val();

                        $.ajax({
                            url: "review_comment_delete", // 삭제를 담당하는 컨트롤러 URL
                            data: {
                                cm_id: cm_id // 삭제할 댓글의 ID
                            },
                            success: function(response) {
                                $('#div_${cm_id}').parent().remove();
                                  location.reload();
                                alert("댓글 삭제가 완료되었습니다.");
                            } //success
                        }); //ajax
    }); //document.on btn-delete click end

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
                        location.reload();

                         alert("댓글 수정이 완료되었습니다.")


                     }
                 }); // ajax end
      }); // btn-update click end

    // ==========================================================================================================================
    $('#b1').click(function() {
                    // 입력된 댓글 내용 및 사용자 정보
                    const reviewId = '${reviewVO.review_id}';
                    const commentContent = $('#review').val();
                    const memberId = '${user}';

                    // Ajax 요청

                      if (commentContent.trim() === '') {
                                alert("댓글 내용을 입력하세요.");
                                return; // Stop further execution
                            }
                    $.ajax({
                        url: "review_comment_insert",
                        type: "POST",
                        data: {
                            review_id: reviewId,
                            cm_content: commentContent,
                            member_id: memberId
                        },
                        success: function(response) {
                            // 성공적으로 저장된 댓글을 화면에 동적으로 추가
                            const commentHtml = `<div class='card mb-2'><div class='card-body'>${response.cm_content}<button class='btn-edit' id='btn_d${response.cm_id}' value='${response.cm_id}'>댓글수정</button><button class='btn-delete' id='btn_d${response.cm_id}' value='${response.cm_id}'>댓글삭제</button></div></div>`;

                            $('#result').append(commentHtml);
                             location.reload();

                            // 입력 필드 초기화
                            $('#review').val('');

                            alert("댓글 작성이 완료되었습니다.");
                        }
                    });// ajax end
     });// b1 click end



  });// document ready end

 function reviewDelete(review_id) {
     let reviewId = ${reviewVO.review_id};

      if(confirm("정말로 삭제하시겠습니까?")) {

         // fileList 변수를 정의
         let fileList = [];

         // fileList 파일 정보 추가
        $(".file_list, .img_list").each(function (i, fileContent) {
        //$(".file").each(function (i, fileContent) {

        var uuid = $(fileContent).data("uuid");
        var fileName = $(fileContent).data("filename");
        var fileType = $(fileContent).data("type");

        console.log("uuid" + uuid)
        console.log("filename" + fileName)
        console.log("fileType" + fileType)

         if (uuid && fileName && fileType) {
                let attach = {
                    review_id: reviewId,
                    review_uuid: uuid,
                    review_file_name: fileName,
                    review_file_type: fileType
              };
              fileList.push(attach);
         } // if end
         }); // each end
        //console.log("fileList : ", fileList);
        //console.log(JSON.stringify(fileList, null, 2));
        console.log(fileList.length)
        // 첨부파일이 있을때 파일+게시글 삭제
        if (fileList.length > 0) {

            $.ajax({
                    type: "POST",
                    url: "/reviewboard/fileDelete",
                    contentType: "application/json",
                    data: JSON.stringify(fileList),
                    success: function(response) {
                      console.log("서버 응답:", response);
                      // 성공적으로 데이터를 전송한  후 목록페이지로 이동
                      window.location.href = "/reviewboard/review_list3";
                    },
                    error: function(xhr, status, error) {
                      console.error("에러 발생:", error);
                      // 에러 처리 로직
                    }
          }); // ajax end
        } else {
              // 첨부파일 없을때 게시글만 삭제
             deleteBoard(review_id);
        }
      }; //confirm end
    }; //boardDelete end
// 첨부파일 없을때 게시글만 삭제
function deleteBoard(review_id) {
  $.ajax({
    type: "POST",
    url: "/reviewboard/review_delete?review_id=" + review_id,
    success: function(response) {
      console.log("게시글 삭제 성공:", response);
      window.location.href = "/reviewboard/review_list3";
    },
    error: function(xhr, status, error) {
      console.error("게시글 삭제 에러 발생:", error);
    }
  });
}

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
                <h2>상세페이지</h2>
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
         <sec:authorize access="isAuthenticated()">
             <a href="review_update_move?review_id=${reviewVO.review_id}" class="btn btn-primary mr-2">글 수정하기</a>
             <button type="button" onclick="reviewDelete(${reviewVO.review_id})" id="deleteBtn" class="btn btn-primary">삭제</button>
         </sec:authorize>
        </div>
    </div>
</div>
<div>
<div class="container mt-4">
    <div class="title-section">
        <h2>${reviewVO.review_title}</h2>
    </div>
    <div class = "rv_title">
    <p>작성자: ${reviewVO.member_id}</p>
    <p>작성일자: <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${reviewVO.review_createdAt}" /></p>
    <%-- <p>수정일자: <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${reviewVO.review_updatedAt}" /></p> --%>
    <p>조회수: ${reviewVO.review_views}</p>
 </div>

<div class="rv_content" style="padding-bottom: 30px;">
           <div class="file_content">
           <div class="img_file_container" style="max-width: 100%; max-height: 200px;">
                                         <!-- Your file image content goes here -->
                                         <div class="img_file" style="width: 100%; height: 100%; background-size: cover; background-position: center; background-repeat: no-repeat;">
                                             <!-- Move your image content here -->
                                         </div>
                                     </div>
                                     <div class="file"></div>
           </div>
           <div class="text-right" style="width: 60%;"> <!-- Adjust the width as needed -->
               <div style="margin: 0 auto; max-width: 600px;">
                   <p>${reviewVO.review_content}</p>
               </div>
           </div>
       </div>

       <div class="input-group mb-3" style="margin-top: 30px;">
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
                     <%=dto.getNickname()%> <br />
                     <%=dto.getCm_content()%> <br />
                     <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="<%=dto.getCm_createAt()%>" /><br />
                     <input type="hidden" id="cm_content_<%=dto.getCm_id()%>"  value="<%=dto.getCm_content()%>">
                     <input type="hidden" id="member_id_<%=dto.getCm_id()%>" value="<%=dto.getMember_id()%>">
                     <sec:authorize access="isAuthenticated()">
                        <%-- 댓글 작성자와 로그인한 사용자가 같을 경우에만 수정 및 삭제 버튼을 표시 --%>
                 <sec:authentication property="principal.member.member_id" var="loggedInMemberId" />
                 <c:if test="${cm_content.member_id eq loggedInMemberId}">
                            <div class="title_btn">
                               <button class='btn btn-primary btn-sm btn-edit' id="btn_<%=dto.getCm_id()%>" value="<%=dto.getCm_id()%>">댓글수정</button>
                               <button class='btn btn-danger btn-sm btn-delete' id="btn_d<%=dto.getCm_id()%>" value="<%=dto.getCm_id()%>">댓글삭제</but
                            </div>
                        </c:if>
                </sec:authorize>
                    </div>
                 </div>
             </div>
             <% } %>
         </div>
</div>


<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

</body>
</html>
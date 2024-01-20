<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Setting</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

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
    <link href="../../../resources/assets/css/style.css" rel="stylesheet">
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
            .center {
              margin-top: 2%; /* Adjust the top margin as a percentage of the viewport height */
              margin-bottom: 2%; /* Adjust the bottom margin as a percentage of the viewport height */
              margin-left: 14%; /* Adjust the left margin as a percentage of the viewport width */
              margin-right: 14%; /* Adjust the right margin as a percentage of the viewport width */
            }
          </style>
</head>

<body>

<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->
<main id="main">

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
<div class="center">
    <h2>공지게시판</h2>
        <c:choose>
            <c:when test="${not empty noticeBoardVO}">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${noticeBoardVO.notc_title}</h5>
                        <p class="card-subtitle">작성일: <fmt:formatDate value="${noticeBoardVO.notc_createdAt}" pattern="yyyy-MM-dd HH:mm"/></p>
                        <p class="card-subtitle">수정일: <fmt:formatDate value="${noticeBoardVO.notc_updatedAt}" pattern="yyyy-MM-dd HH:mm"/></p>
                        <p class="card-subtitle">조회수: ${noticeBoardVO.notc_views}</p>
                        <c:if test="${not empty noticeBoardVO.notice_uuid}">
                            <img src="<c:url value='/upload-dir/${noticeBoardVO.notice_uuid}_${noticeBoardVO.notice_file_name}'/>" alt="${noticeBoardVO.notice_file_name}" class="img-fluid">
                        </c:if>
                        <p class="card-text">${noticeBoardVO.notc_content}</p>
                        <a href="/noticeboard/noticeboard_update/${noticeBoardVO.notc_id}" role="button" class="btn btn-primary">수정</a>
                        <!-- Delete button triggering AJAX request -->
                        <button type="button" onclick="deleteNotice(${noticeBoardVO.notc_id})" class="btn btn-danger">삭제</button>
                        <a href="noticeboard" class="btn btn-secondary">목록으로</a>
                    </div>
                </div>
                <div class="my-3 p-3 bg-white rounded shadow-sm">
                	<c:choose >
                	<c:when test="${move.next != 9999}">

                	<button type="button" class="btn btn-warning mr-3 mb-3" onclick="location.href='/noticeboard/noticeboard_one?notc_id=${move.next}'"> <span class="glyphicon glyphicon-menu-up" aria-hidden="true"></span>다음글</button>
                		<a href="/noticeboard/noticeboard_one?notc_id=${move.next}" style="color: black"> ${move.nexttitle} </a>
                	</c:when>

                	<c:when test="${move.next == 9999}">
                	<button type="button" class="btn btn-warning mr-3 mb-3" disabled>다음글이 없습니다</button>
                	</c:when>
                	</c:choose>
                	<br/>
                	<c:choose>
                	<c:when test="${move.last != 9999}">
                	<button type="button" class="btn btn-info mr-3 " onclick="location.href='/noticeboard/noticeboard_one?notc_id=${move.last}'"> <span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>이전글</button>
                	<a href="/noticeboard/noticeboard_one?notc_id=${move.last}" style="color: black"> ${move.lasttitle} </a>
                	</c:when>

                	<c:when test="${move.last == 9999}">
                	<button type="button" class="btn btn-info mr-3" disabled>이전글이 없습니다</button>
                	</c:when>
                	</c:choose>

                </div>
            </c:when>
            <c:otherwise>
                <p>Notice not found.</p>
            </c:otherwise>
        </c:choose>
        <c:if test="${not empty exception}">
            <p>An error occurred: ${exception.message}</p>
        </c:if>
</main><!-- End #main -->
        <!-- ======= Footer ======= -->
        <jsp:include page="/WEB-INF/views/footer.jsp"/>
        <!-- End Footer -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            function deleteNotice(notc_id) {
                $.ajax({
                    url: '/noticeboard/noticeboard_delete/' + notc_id,
                    type: 'DELETE',
                    success: function(result) {
                        // Handle success response
                        // For example, you can redirect to another page
                        window.location.href = '/noticeboard/noticeboard';
                    },
                    error: function(xhr, status, error) {
                        // Handle error response
                        window.location.href = '/noticeboard/noticeboard';
                    }
                });
            }
        </script>
        </div>

</body>
</html>

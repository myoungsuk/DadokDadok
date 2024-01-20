<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.multi.mini6.noticeboard.vo.NoticeBoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <h2>공지 수정</h2>
    <form action="/noticeboard/noticeboard_update/${existingNotice.notc_id}" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="notc_title">제목</label>
            <input type="text" class="form-control" id="notc_title" name="notc_title" value="${existingNotice.notc_title}" required>
        </div>
        <br>
        <div class="form-group">
            <label for="notc_content">내용</label>
            <textarea class="form-control" id="notc_content" name="notc_content" rows="10" required>${existingNotice.notc_content}</textarea>
        </div>
        <c:if test="${not empty existingNotice.notice_uuid}">
            <div>
                <p>${existingNotice.notice_file_name}</p>
            </div>
        </c:if>
        <br>
        <div class="form-group">
            <label for="attachment">첨부 파일</label>
            <input type="file" class="form-control-file" id="attachment" name="file">
        </div>
        <br>
            상단에 고정<input type="checkbox" id="pinnedCheckbox" name="pinnedCheckbox" value="true">
                    <input type="hidden" id="pinnedHidden" name="pinned" value="false">
        <br><br>
        <button type="submit" class="btn btn-info">수정</button>
        <!-- Delete button for deleting the notice -->
        <a href="#" onclick="deleteNotice(${existingNotice.notc_id})" class="btn btn-danger">삭제</a>
        <a href="/noticeboard/noticeboard" class="btn btn-secondary">목록으로</a>
    </form>

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
    <script>
        document.getElementById('pinnedCheckbox').addEventListener('change', function() {
            var hiddenInput = document.getElementById('pinnedHidden');
            if (this.checked) {
                hiddenInput.value = 'true'; // Set the value to 'true' when checked
            } else {
                hiddenInput.value = 'false'; // Set the value to 'false' when unchecked
            }
        });
    </script>
    </div>

</body>
</html>

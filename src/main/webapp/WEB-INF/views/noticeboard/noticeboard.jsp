<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.multi.mini6.noticeboard.vo.NoticeBoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        .search-form {
            text-align: center; /* Center align the form */
        }

        .input-group {
            display: inline-block; /* Display the group as inline-block */
            vertical-align: middle; /* Align the group vertically */
        }

        .input-group select,
        .input-group input[type="text"],
        .input-group input[type="submit"] {
            margin: 0; /* Remove default margins */
            vertical-align: middle; /* Align elements vertically */
        }

        .pinned-notice {
                background-color: #f2f2f2; /* Light gray background */
                font-weight: bold; /* Make text bold */
            }

        .post-number {
                    color: red; /* Set the text color to red */
                }
        .n_info {
                        text-align: center;
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
                <h2>공지게시판</h2>
                <ol>
                    <li><a href="../mainpage/index.jsp">Home</a></li>
                    <li>공지게시판</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

    <div class="center">
        <div class="n_info">
        <br>
                <p style="font-size: 24px; font-weight: bold;">공지게시판</p>
                <div>공지 사항을 준수해 주세요.</div>
                <div>중요 공지는 상단에 고정되어 있습니다.</div>
                <div><p>총 게시물 수: ${count}</p></div>
                <br>
            </div>
                            <form action="noticeboard_search" method="get" class="search-form">
                                <div class="input-group">
                                    <select id="searchType" name="searchType">
                                        <option value="title">제목</option>
                                        <option value="content">내용</option>
                                        <option value="titleContent">제목+내용</option>
                                    </select>
                                    <input type="text" id="keyword" name="keyword" placeholder="검색어 입력">
                                    <input type="submit" value="검색" class="btn btn-secondary">
                                    <a href="noticeboard_write" class="btn btn-primary">새 글 쓰기</a>
                                </div>
                            </form>
                            <br><br>

        <div class="row">
            <div class="col">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">NO</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성자</th>
                            <th scope="col">조회수</th>
                            <th scope="col">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pinnedNotices}" var="noticeboardVO">
                            <tr class="pinned-notice">
                                <td><span class="post-number">${noticeboardVO.notc_id}</span></td>
                                <td>
                                    <a href="noticeboard_one?notc_id=${noticeboardVO.notc_id}">
                                        <c:out value="${fn:substring(noticeboardVO.notc_title, 0, 20)}${fn:length(noticeboardVO.notc_title) > 20 ? '...' : ''}" />
                                    </a>
                                </td>
                                <td>관리자</td>
                                <td><c:out value="${noticeboardVO.notc_views}" /></td>
                                <td><fmt:formatDate value="${noticeboardVO.notc_createdAt}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        <c:forEach items="${noticeboard}" var="noticeboardVO">
                            <c:if test="${!noticeboardVO.pinned}">
                                <tr>
                                    <td><c:out value="${noticeboardVO.notc_id}" /></td>
                                    <td>
                                        <a href="noticeboard_one?notc_id=${noticeboardVO.notc_id}">
                                            <c:out value="${fn:substring(noticeboardVO.notc_title, 0, 20)}${fn:length(noticeboardVO.notc_title) > 20 ? '...' : ''}" />
                                        </a>
                                    </td>
                                    <td>관리자</td>
                                    <td><c:out value="${noticeboardVO.notc_views}" /></td>
                                    <td><fmt:formatDate value="${noticeboardVO.notc_createdAt}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
                <br>
                <ul class="pagination justify-content-center">
                    <li class="page-item${noticeBoardPageVO.page == 1 ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=1&pageSize=10" aria-label="First">
                            &lt;&lt;<span aria-hidden="true"></span>
                        </a>
                    </li>
                    <li class="page-item${noticeBoardPageVO.page == 1 ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=${noticeBoardPageVO.page - 1}&pageSize=10" aria-label="Previous">
                            &lt;<span aria-hidden="true"></span>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${noticeBoardPageVO.totalPages}" var="i">
                        <li class="page-item${noticeBoardPageVO.page == i ? ' active' : ''}">
                            <a class="page-link" href="noticeboard?page=${i}&pageSize=10">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item${noticeBoardPageVO.page == noticeBoardPageVO.totalPages ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=${noticeBoardPageVO.page + 1}&pageSize=10" aria-label="Next">
                            ><span aria-hidden="true"></span>
                        </a>
                    </li>
                    <li class="page-item${noticeBoardPageVO.page == noticeBoardPageVO.totalPages ? ' disabled' : ''}">
                        <a class="page-link" href="noticeboard?page=${noticeBoardPageVO.totalPages}&pageSize=10" aria-label="Last">
                            >><span aria-hidden="true"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</main><!-- End #main -->
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

</body>
</html>

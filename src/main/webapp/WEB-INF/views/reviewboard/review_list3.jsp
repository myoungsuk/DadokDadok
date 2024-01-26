<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO"%>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewAttachVO"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS (optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../../../resources/js/jquery-3.7.1.js"></script>
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
    .row {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }

    .row img {
        max-width: 200px;
        margin-right: 20px;
    }
</style>
<script type="text/javascript">

    $(function() {
            $('.btn.btn-outline-secondary').click(function() {

            console.log( $(this).text());

                $.ajax({
                    url: "review_search1",
                    data: {
                        page: $(this).text(),
                        keyword: '${keyword}'

                    },
                    success: function(table) {
                     $('#result').html(table);
                          $('#keyword').val('${keyword}');

                    },
                    error: function(error) {
                        console.error(error);
                    }
                });
            });



        });


</script>
</head>
<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2>독서후기게시판</h2>
                <ol>
                    <li><a href="../mainpage/index.jsp">Home</a></li>
                    <li>Setting</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->

<body bgcolor="yellow">
    <div class="container mt-4">
        <!-- 검색창과 버튼 -->
        <div class="row mb-3 justify-content-center">
            <!-- 검색창 -->
            <div class="col-md-6 text-center">
                <form action="review_list3" class="d-flex justify-content-center" >

                    <input type = "hidden" name="page" id = "currentPage" value="1">
                    <input name="keyword" id ="keyword" class="form-control form-control-sm me-2" type="search" placeholder="검색어를 입력하세요" value = "${keyword}"
                        aria-label="Search">

                    <button class="btn btn-outline-success btn-sm" id="btnSearch" >검색</button>

                </form>
            </div>

            <!-- Insert 버튼 -->
            <div class="col-md-6 text-end">
             <sec:authorize access="isAuthenticated()"> <%-- 로그인한 상태에서만 보임 --%>

                               <a href="review_insert_move" class="btn btn-primary">게시글 작성</a>

                      </sec:authorize>

            </div>
        </div>

        <hr>
        <div id="result">
            <%
                //jsp에서 자동 import : 클릭하고 ctrl + shiftl + m
                List<ReviewVO> list = (List<ReviewVO>) request.getAttribute("list");

            %>
            <div class="container mt-4">

                <table class="table">
                    <thead>
                        <tr>
                        <th scope="col">이미지</th>
                            <th scope="col">NO</th>
                            <th scope="col">제목</th>
                            <th scope="col">내용</th>
                            <th scope="col">작성일</th>
                            <th scope="col">수정일</th>
                            <th scope="col">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (ReviewVO review : list) {
                        %>
                        <tr>
                           <td>
<div style="width: 300px; height: 200px; overflow: hidden; position: relative;">

    <% if (review != null && review.getReview_attach() != null) {
        if ((review.getReview_attach().getReview_file_type()).equals("jpg")) { %>
            <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/<%=review.getReview_attach().getReview_uuid()%>_<%=review.getReview_attach().getReview_file_name()%>" style="width: 100%; height: 100%; object-fit: cover;">
        <% } else { %>
            <%=review.getReview_attach().getReview_file_type()%>
            <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/noimg.jpg" style="width: 100%; height: 100%; object-fit: cover;">
        <% }
    } else { %>
        <img src="${pageContext.request.contextPath}/resources/reviewBoardUpload/noimg.jpg" style="width: 100%; height: 100%; object-fit: cover;">
    <% } %>

</div>
                           </div>
  </td>

                            <td><%=review.getReview_id()%></td>
                            <td> <a href="review_one?review_id=<%=review.getReview_id()%>"><%=review.getReview_title()%></a>
                            </td>
                            <td><%=review.getReview_content()%></td>
                             <td><fmt:formatDate pattern="yyyy-MM-dd" value="<%=review.getReview_createdAt()%>" /></td>
                             <td><fmt:formatDate pattern="yyyy-MM-dd" value="<%=review.getReview_updatedAt()%>" /></td>
                            <td><%=review.getReview_views()%></td>


                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>


        <div class="text-center">

            전체 게시물 수 : ${count}개 <br>
            전체 페이지 수 : ${pages}개 <br>
            <div class="btn-group" role="group" aria-label="Basic example">
                <%
                    int pages = (int) request.getAttribute("pages");//int(작) <--- Object(큰)
                    String keyword = (String) request.getAttribute("keyword");

                    for (int p = 1; p <= pages; p++) {
                %>
                <button class="btn btn-outline-secondary"><%= p %></button>


                <%
                    }
                %>
            </div>
        </div>
        <hr color="red">
    </div>
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->
</body>

</html>
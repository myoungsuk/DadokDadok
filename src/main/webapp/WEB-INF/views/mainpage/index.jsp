<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<jsp:include page="/WEB-INF/views/head.jsp"/>

<body>

<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<!-- ======= Header ======= -->
<jsp:include page="/WEB-INF/views/header.jsp"/>
<!-- End Header -->


<!-- ======= Hero Section ======= -->
  <section id="hero">
      <%-- 도서 검색 --%>
      <div class="book_search">
          <div>
             <input type="text" placeholder="원하는 독서 후기를 검색해보세요!">
             <button type="button"><i class="fas fa-search"></i></button>
          </div>
      </div>

  </section><!-- End Hero -->

  <main id="main">
  <div id="heroCarousel" data-bs-interval="5000" class="carousel slide carousel-fade library_slide" data-bs-ride="carousel">

        <div class="carousel-inner" role="listbox">

          <!-- Slide 1 -->
          <div class="carousel-item active test">
            <div class="carousel-container">
              <%-- <div class="carousel-content animate__animated animate__fadeInUp"> --%>
              <div class="carousel-content animate__animated animate__fadeInLeft">
                  <div class="library_slide_inner">
                        <div class="lb_row">
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                        <div class="lb_row">
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                  </div><%-- end library_slide_inner --%>

              </div>
            </div>
          </div>

          <!-- Slide 2 -->
          <div class="carousel-item">
            <div class="carousel-container">
              <div class="carousel-content animate__animated animate__fadeInLeft">
                  <div class="library_slide_inner">
                        <div class="lb_row">
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                        <div class="lb_row">
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                  </div><%-- end library_slide_inner --%>
              </div>
            </div>
          </div>

          <!-- Slide 3 -->
          <div class="carousel-item">
            <div class="carousel-container">
              <div class="carousel-content animate__animated animate__fadeInLeft">
                  <div class="library_slide_inner">
                        <div class="lb_row">
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                        <div class="lb_row">
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="#">2.28 도서관</a></p>
                                        <p>대구광역시 중구 2-28길 9</p>
                                        <p>053-257-2280</p>
                                        <p>화~금 09:00~18:00, 토일 09:00~17:00</p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                  </div><%-- end library_slide_inner --%>
              </div>
            </div>
          </div>


        </div>
        <a class="carousel-control-prev" href="#heroCarousel" role="button" data-bs-slide="prev">
          <span class="carousel-control-prev-icon bx bx-left-arrow" aria-hidden="true">
              <i class="fas fa-chevron-left"></i>
          </span>
        </a>

        <a class="carousel-control-next" href="#heroCarousel" role="button" data-bs-slide="next">
          <span class="carousel-control-next-icon bx bx-right-arrow" aria-hidden="true">
              <i class="fas fa-chevron-right"></i>
          </span>
        </a>

        <ol class="carousel-indicators" id="hero-carousel-indicators"></ol>

      </div>

    <!-- ======= board Section ======= -->
    <section id="board" class="board">
      <div class="container">
         <div class="b_inner">
              <div class="b_title">
                    <p>공지 게시판</p>
                    <a href="/noticeboard/notice_list"><i class="bx bx-plus"></i></a>
              </div>
              <div class="nb_list b_list">
                    <div>
                        <p><a href="/noticeboard">공지사항 제목</a></p>
                        <p>2024-01-17</p>
                    </div>
                    <div>
                        <p><a href="/noticeboard">공지사항 제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목</a></p>
                        <p>2024-01-17</p>
                    </div>
                    <div>
                        <p><a href="/noticeboard">공지사항 제목</a></p>
                        <p>2024-01-17</p>
                    </div>
                    <div>
                        <p><a href="/noticeboard">공지사항 제목</a></p>
                        <p>2024-01-17</p>
                    </div>
                    <div>
                        <p><a href="/noticeboard">공지사항 제목</a></p>
                        <p>2024-01-17</p>
                    </div>
              </div>
         </div> <%-- end notice_board --%>
         <div class="b_inner">
              <div class="b_title">
                    <p>자유 게시판</p>
                    <a href="/freeboard/board_list"><i class="bx bx-plus"></i></a>
              </div>
              <div class="fb_list b_list">
                    <c:forEach items="${freeBoardList}" var="freeboard">
                          <div>
                                <p><a href="/freeboard/board_one?board_id=${freeboard.board_id}">${freeboard.board_title}</a></p>
                                <p>${freeboard.nickname}</p>
                               <p><fmt:formatDate pattern="yyyy-MM-dd" value="${freeboard.board_createdAt}"/></p>

                          </div>
                    </c:forEach>
              </div>
         </div> <%-- end free_board --%>
      </div> <%-- end container --%>
    </section> <!-- End board Section -->

    <!-- ======= review Section ======= -->
  <section id="review" class="review portfolio"> <%-- class portfolio  지우면 안됨 --%>
      <div class="container">
          <div class="rv_title">후기 게시판</div>
          <div class="row portfolio-container" data-aos="fade-up">

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <%-- 이 부분은 독서 후기 상세보기 페이지로 이동하게 해주시면 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link"><i class="bx bx-plus"></i></a>
                  </div>
              </div>

              <div class="col-lg-4 col-md-6 portfolio-item filter-app">
                  <img src="../../../resources/assets/img/portfolio/portfolio-1.jpg" class="img-fluid" alt=""> <%-- 여기에 책 이미지 넣으면 됩니다 --%>
                  <div class="portfolio-info">
                      <h4>도서 이름</h4>
                      <p>지은이</p> <%-- 이부분은 빼도 됩니다 --%>
                      <a href="../../../resources/assets/img/portfolio/portfolio-1.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" ><i class="bx bx-plus"></i></a>
                  </div>
              </div>


       </div>
      </div> <%-- container --%>
   </section><!-- End review Section -->
  </main><!-- End #main -->

<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

  <!-- Vendor JS Files -->
  <script src="../../../resources/assets/vendor/aos/aos.js"></script>
  <script src="../../../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../../../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../../../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../../../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="../../../resources/assets/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="../../../resources/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="../../../resources/assets/js/main.js"></script>

</body>

</html>
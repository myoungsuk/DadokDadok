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
                                        <p><a href="/librarypage/library_one?lib_code=121008">부산광역시립시민도서관</a></p>
                                        <p>부산광역시 부산진구 월드컵대로 462</p>
                                        <p>051-810-8200</p>
                                        <p><a href="https://home.pen.go.kr/siminlib">https://home.pen.go.kr/siminlib</a></p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=50001">국립세종도서관</a></p>
                                        <p>세종특별자치시 다솜3로 48</p>
                                        <p>044-900-9114</p>
                                        <p><a href="http://sejong.nl.go.kr/">http://sejong.nl.go.kr/</a></p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                        <div class="lb_row">
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=141010">경기중앙교육도서관</a></p>
                                        <p>경기도 수원시 장안구 조원로 18</p>
                                        <p>031-240-4064</p>
                                        <p><a href="https://lib.goe.go.kr/gg/">https://lib.goe.go.kr/gg/</a></p>
                                   </div>
                              </div><%-- end lb_content --%>
                              <div class="lb_content">
                                   <div class="lb_icon"><i class="fas fa-book-reader"></i></div>
                                   <div class="lb_info">
                                        <p><a href="/librarypage/library_one?lib_code=141008">경기성남교육도서관</a></p>
                                        <p>경기도 성남시 수정구 공원로370번길 26</p>
                                        <p>031-730-3500</p>
                                        <p><a href="https://lib.goe.go.kr/sn/index.do">https://lib.goe.go.kr/sn/index.do</a></p>
                                   </div>
                              </div><%-- end lb_content --%>
                        </div><%-- end lb_row --%>
                  </div><%-- end library_slide_inner --%>

              </div>
            </div>
          </div>

        <!-- Slide 3 -->
        <div class="carousel-item" style="background-image: url(../../../resources/assets/img/slide/slide-3.jpg);">
          <div class="carousel-container">
            <div class="carousel-content animate__animated animate__fadeInUp">
              <h2>Sequi ea ut et est quaerat</h2>
              <p>Ut velit est quam dolor ad a aliquid qui aliquid. Sequi ea ut et est quaerat sequi nihil ut aliquam. Occaecati alias dolorem mollitia ut. Similique ea voluptatem. Esse doloremque accusamus repellendus deleniti vel. Minus et tempore modi architecto.</p>
              <div class="text-center"><a href="" class="btn-get-started">Read More</a></div>
            </div>
          </div>
        </div>

      </div>

      <a class="carousel-control-prev" href="#heroCarousel" role="button" data-bs-slide="prev">
        <span class="carousel-control-prev-icon bx bx-left-arrow" aria-hidden="true"></span>
      </a>

      <a class="carousel-control-next" href="#heroCarousel" role="button" data-bs-slide="next">
        <span class="carousel-control-next-icon bx bx-right-arrow" aria-hidden="true"></span>
      </a>

      <ol class="carousel-indicators" id="hero-carousel-indicators"></ol>

    </div>
  </section><!-- End Hero -->

  <main id="main">

    <!-- ======= Cta Section ======= -->
    <section id="cta" class="cta">
      <div class="container">

        <div class="row">
          <div class="col-lg-9 text-center text-lg-left">
            <h3>We've created more than <span>200 websites</span> this year!</h3>
            <p> Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
          </div>
          <div class="col-lg-3 cta-btn-container text-center">
            <a class="cta-btn align-middle" href="#">Request a quote</a>
          </div>
        </div>

      </div>
    </section><!-- End Cta Section -->

    <!-- ======= Services Section ======= -->
    <section id="services" class="services">
      <div class="container">

        <div class="row">
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="fade-up">
              <div class="icon"><i class="bi bi-briefcase"></i></div>
              <h4 class="title"><a href="">Lorem Ipsum</a></h4>
              <p class="description">Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="100">
              <div class="icon"><i class="bi bi-card-checklist"></i></div>
              <h4 class="title"><a href="">Dolor Sitema</a></h4>
              <p class="description">Minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat tarad limino ata</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="200">
              <div class="icon"><i class="bi bi-bar-chart"></i></div>
              <h4 class="title"><a href="">Sed ut perspiciatis</a></h4>
              <p class="description">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="200">
              <div class="icon"><i class="bi bi-binoculars"></i></div>
              <h4 class="title"><a href="">Magni Dolores</a></h4>
              <p class="description">Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="300">
              <div class="icon"><i class="bi bi-brightness-high"></i></div>
              <h4 class="title"><a href="">Nemo Enim</a></h4>
              <p class="description">At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque</p>
            </div>
          </div>
          <div class="col-lg-4 col-md-6">
            <div class="icon-box" data-aos="fade-up" data-aos-delay="400">
              <div class="icon"><i class="bi bi-calendar4-week"></i></div>
              <h4 class="title"><a href="">Eiusmod Tempor</a></h4>
              <p class="description">Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi</p>
            </div>
          </div>
        </div>

      </div>
    </section><!-- End Services Section -->

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

          <div class="col-lg-4 col-md-6 portfolio-item filter-web">
            <img src="../../../resources/assets/img/portfolio/portfolio-9.jpg" class="img-fluid" alt="">
            <div class="portfolio-info">
              <h4>Web 3</h4>
              <p>Web</p>
              <a href="../../../resources/assets/img/portfolio/portfolio-9.jpg" data-gallery="portfolioGallery" class="portfolio-lightbox preview-link" title="Web 3"><i class="bx bx-plus"></i></a>
              <a href="../../../portfolio-details.jsp" class="details-link" title="More Details"><i class="bx bx-link"></i></a>
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Portfolio Section -->

    <!-- ======= Our Clients Section ======= -->
    <section id="clients" class="clients">
      <div class="container">

        <div class="section-title" data-aos="fade-up">
          <h2>Our <strong>Clients</strong></h2>
          <p>Magnam dolores commodi suscipit. Necessitatibus eius consequatur ex aliquid fuga eum quidem. Sit sint consectetur velit. Quisquam quos quisquam cupiditate. Et nemo qui impedit suscipit alias ea. Quia fugiat sit in iste officiis commodi quidem hic quas.</p>
        </div>

        <div class="row no-gutters clients-wrap clearfix" data-aos="fade-up">

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-1.png" class="img-fluid" alt="">
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-2.png" class="img-fluid" alt="">
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-3.png" class="img-fluid" alt="">
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-4.png" class="img-fluid" alt="">
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-5.png" class="img-fluid" alt="">
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-6.png" class="img-fluid" alt="">
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-7.png" class="img-fluid" alt="">
            </div>
          </div>

          <div class="col-lg-3 col-md-4 col-xs-6">
            <div class="client-logo">
              <img src="../../../resources/assets/img/clients/client-8.png" class="img-fluid" alt="">
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Our Clients Section -->

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
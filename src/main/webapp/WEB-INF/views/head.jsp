<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>다독다독</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="${pageContext.request.contextPath}/resources/assets/img/favicon.png" rel="icon">
  <link href="${pageContext.request.contextPath}/resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Muli:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="${pageContext.request.contextPath}/resources/assets/vendor/animate.css/animate.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet">

  <!-- font awesome css -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css">

  <link href="${pageContext.request.contextPath}/resources/css/freeboard.css" rel="stylesheet">

<style>
 <!-- 메인페이지 -->
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

    #hero:has(.book_search) { height: 40vh; }
    .book_search { display: flex; width: 100%; height: 100%; justify-content: center; align-items: center; }
    .book_search div { display: flex; }
    .book_search div input { width: 500px; height: 50px; padding: 6px; outline-color: #0a58ca; }
    .book_search div button { width: 50px; height: 50px; font-size: 30px; color: #333; background: transparent; border: 1px solid transparent; }
    .book_search div button:hover { color: #0a58ca; }

    .library_slide { background: #fafafa; }
    .library_slide .library_slide_inner { height: 420px; padding: 20px 80px; }
    .library_slide .lb_row { display: flex; }
    .library_slide .lb_row:nth-child(1) { margin-bottom: 20px; }
    .library_slide .lb_row .lb_content { display: flex; width: calc((100% - (30px * 3)) / 2); margin-right: 30px; padding: 10px; border: 1px solid #eee; border-radius: 10px; }
    .library_slide .lb_row .lb_content:nth-child(1) { margin-left: 30px; }
    .library_slide .lb_row .lb_content .lb_icon { display: flex;width: 15%; height: 100%; font-size: 46px; color: #333; justify-content: center; align-items: center;}
    .library_slide .lb_row .lb_content .lb_info { width: 85%; height: 100%;  text-align: center;}
    .library_slide .lb_row .lb_content .lb_info a { color: #333; font-size: 18px; font-weight: 600; }
    .library_slide .lb_row .lb_content .lb_info a:hover { color: #0a58ca; }
    .library_slide .carousel-control-next, .library_slide .carousel-control-prev  { width: 10%; }
    .library_slide .carousel-control-prev-icon,
    .library_slide .carousel-control-next-icon { font-size: 32px; color: #555; background: transparent; }
    .library_slide .bx-right-arrow:before, .library_slide .bx-left-arrow:before { content: ""; }
    .library_slide .carousel-indicators [data-bs-target] { background-color: rgba(0, 0, 0, 0.3); }

    .board .container { display: flex; }
    .board .container > div { width: calc((100% - 30px) / 2); padding: 30px; border: 1px solid #eee; }
    .board .container > div:nth-child(1) { margin-right: 30px; }
    .board .container > div .b_title { display: flex; font-weight: 600; color: #333; justify-content: space-between; align-items: baseline; }
    .board .container > div .b_title p { font-size: 18px;  }
    .board .container > div .b_title a {color: #333; }
    .board .container > div .b_title a:hover { color: #0a58ca; }
    .board .container > div > div > div { display: flex; }
    .board .container > div .nb_list div p:nth-child(1) { width: 80%; }
    .board .container > div .nb_list div p:nth-child(2) { width: 20%; }
    .board .container > div .fb_list div p:nth-child(1) { width: 65%; }
    .board .container > div .fb_list div p:nth-child(2) { width: 15%; }
    .board .container > div .fb_list div p:nth-child(3) { width: 20%; }

  <!--  end 메인페이지 -->

 </style>

  <!-- =======================================================
  * Template Name: Flattern
  * Updated: Sep 18 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/flattern-multipurpose-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>
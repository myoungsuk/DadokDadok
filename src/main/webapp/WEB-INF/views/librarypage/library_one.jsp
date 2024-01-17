<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.multi.mini6.librarypage.vo.LibraryVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다독다독 도서관 정보</title>
<!-- 부트스트랩 및 사용자 정의 CSS/JS 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 부트스트랩 CSS 링크 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

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

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Template Main CSS File -->
<link href="../../../resources/assets/css/style.css" rel="stylesheet">


<style>
    /* 추가적인 스타일링을 위한 CSS */
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    /* Some basic custom styles */
    .container {
            margin-top: 20px;
        }
    .container2 {
        display : flex;
        justify-content: center; /* 가로 중앙 정렬 */

    }
    #map {
        margin: 0 auto; /* 가로 중앙 정렬 */
        width: 50%;
        height: 350px;
    }

</style>

<%
    LibraryVO libraryVO = (LibraryVO) request.getAttribute("bag");
%>

</head>
<body>
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
            <h2>도서관</h2>
            <ol>
                <li><a href="../mainpage/index">Home</a></li>
                <li>Library</li>
            </ol>
        </div>

    </div>
</section>
<!-- End Breadcrumbs -->

<div class="container">
    <div class="container mt-5 text-center">

        <h3>${bag.lib_name}</h3>
        <br>
    </div>

    <div id="map" style="width:50%;height:350px;"></div>
    <br>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb6a3c31b035f2a61bd30ac29509330"></script>
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(${bag.lib_latitude}, ${bag.lib_longitude}), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커가 표시될 위치입니다
    var markerPosition  = new kakao.maps.LatLng(${bag.lib_latitude}, ${bag.lib_longitude});

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
    // marker.setMap(null);

    var iwContent = '<div style="padding:5px;">${bag.lib_name}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
        iwPosition = new kakao.maps.LatLng(${bag.lib_latitude}, ${bag.lib_longitude}), //인포윈도우 표시 위치입니다
        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

    // 인포윈도우를 생성하고 지도에 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        map: map, // 인포윈도우가 표시될 지도
        position : iwPosition,
        content : iwContent,
        removable : iwRemoveable
    });

    </script>

    <div id="result">
        <table class="table table-bordered">
            <tr>
                <td><strong>주소</strong></td>
                <td>${bag.lib_address }</td>
            </tr>
            <tr>
                <td><strong>전화번호</strong></td>
                <td>${bag.lib_tel }</td>
            </tr>
            <tr>
                <td><strong>FAX번호</strong></td>
                <td>${bag.lib_fax }</td>
            </tr>
            <tr>
                <td><strong>홈페이지</strong></td>
                <td><a href="${bag.lib_homepage}">${bag.lib_homepage}</a></td>
            </tr>
            <tr>
                <td><strong>휴관일</strong></td>
                <td>${bag.lib_closed}</td>
            </tr>
            <tr>
                <td><strong>운영시간</strong></td>
                <td>${bag.lib_operating_time}</td>
            </tr>
            <tr>
                <td><strong>단행본수</strong></td>
                <td>${bag.lib_bookcount}</td>
            </tr>
        </table>
    </div>

    <div class="row justify-content-center">
        <a href="library_list3" class="btn btn-primary">List</a>
    </div>
    <br><br><br>
</div>

<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

</body>
</html>

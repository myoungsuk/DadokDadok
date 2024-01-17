<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
    <meta charset="UTF-8">
    <title>다독다독 도서관 정보</title>

    <!-- 부트스트랩 및 자바스크립트 CDN -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb6a3c31b035f2a61bd30ac29509330&libraries=services"></script>

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

    <!-- 페이징 스크립트 -->
    <script>
        $(function() {
            $('.pages').click(function(e) {
                //e.preventDefault();
                var page = parseInt($(this).data('page'));
                //alert(page)
                if ($(this).text() === '다음 »') {
                    //page = parseInt($('.pages').last().data('page'));
                    location.href = "library_list3?page=" + page
                }
                if ($(this).text() === '« 이전') {
                    location.href = "library_list3?page=" + page
                }
                $.ajax({
                    url: "library_list4",
                    data: {
                        page: page //6
                    },
                    success: function(table) {
                        $('#result').html(table);
                    }
                });
            });
        });
    </script>

    <!-- 이름으로 검색 -->
    <script type="text/javascript">
        $(function() {
            $('#search_name').click(function(e) {
                var page = parseInt($(this).data('page'));
                //e.preventDefault();
                console.log( $(this).text());

                $.ajax({
                    url: "library_search_name",
                    data: {
                        page: $(this).text(),
                        keyword: '${keyword}'
                    },
                    success: function(table) {
                        $('#result').html(table);
                        $('#keyword').val('${keyword}');
                        alert(response);
                    },
                    error: function(error) {
                        console.error(error);
                    }
                });
            });
        });
    </script>

    <!-- 지역으로 검색 카테고리 -->
    <script>
        function updateCategoryOptions() {
            var regionSelect = document.getElementById('regionSelect');
            var categorySelect = document.getElementById('categorySelect');

            // 기존 카테고리 옵션 제거
            while (categorySelect.options.length > 1) {
                categorySelect.remove(1);
            }

            // 선택된 지역에 따라 카테고리 옵션 추가
            var selectedRegion = regionSelect.value;
            switch (selectedRegion) {
                case 'seoul':
                    addCategoryOption('중구');
                    addCategoryOption('동구');
                    addCategoryOption('남구');
                    // 추가적인 옵션 계속 추가
                    break;
                case 'busan':
                    addCategoryOption('해운대구');
                    addCategoryOption('수영구');
                    // 추가적인 옵션 계속 추가
                    break;
                case 'incheon':
                    // Incheon에 따른 카테고리 추가
                    break;
                // 다른 지역에 따른 카테고리 추가
            }
        }

        function addCategoryOption(category) {
            var categorySelect = document.getElementById('categorySelect');
            var option = document.createElement('option');
            option.text = category;
            categorySelect.add(option);
        }
    </script>


    <style>
        .container {
            margin-top: 20px;
        }

        .container2 {
            display: flex;
            justify-content: center;
            /* 가로 중앙 정렬 */

        }

        .left-panel,
        .right-panel {
            flex: 1;
            border: 0px solid #ccc;
            padding: 20px;
        }

        .pages {
            margin: 5px;
        }
        .hidden-column {
            display: none;
        }
        .custom-width-15 {
            width: 15%;
        }
        .custom-width-30 {
            width: 30%;
        }
        .custom-width-40 {
            width: 40%;
        }

        #map {
            width: 100%;
            height: 350px;
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

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2>도서관 찾기</h2>
                <ol>
                    <li><a href="../mainpage/index">Home</a></li>
                    <li>Library</li>
                </ol>
            </div>
        </div>
    </section>
    <!-- End Breadcrumbs -->

    <div class="container">
        <div class="container2">
            <div class="left-panel">
                <!-- 좌측 패널의 내용 -->
                <div class="container mt-4">
                    <p>이름으로 찾기</p>
                    <!-- 검색창 -->
                    <form action="library_search_name" class="form-inline" id="searchForm">
                        <div class="form-group">
                            <input type = "hidden" name="page" id = "currentPage" value="1">
                            <input name = "keyword" id="keyword" type="search" class="form-control mr-2" placeholder="도서관명을 입력하세요" value="${keyword}" aria-label="Search">
                            <button type="submit" class="btn btn-primary" id="search_name">검색</button>
                        </div>
                    </form>
                </div>

                <div class="container mt-4">
                    <p>지역으로 찾기</p>
                    <!-- 지역별 카테고리 검색창 -->
                    <form class="form-inline" id="searchForm2">
                        <div class="form-group mr-2">
                            <select class="form-control" id="regionSelect" onchange="updateCategoryOptions()">
                                <option selected disabled>지역 선택</option>
                                <option value="seoul">서울</option>
                                <option value="busan">부산</option>
                                <option value="incheon">인천</option>
                                <!-- 여기에 추가적인 지역 옵션을 넣어주세요 -->
                            </select>
                        </div>
                        <div class="form-group mr-2">
                            <select class="form-control" id="categorySelect">
                                <option selected disabled>시/군/구 선택</option>
                                <!-- 여기에 추가적인 카테고리 옵션을 넣어주세요 -->
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">검색</button>
                    </form>
                </div>

                <div class="container mt-4">
                    <a href="library_list3?page=1" class="btn btn-primary">전체 리스트 보기</a>
                </div>
            </div>
            <div class="right-panel" id="map">
                <!-- 우측 패널의 내용 -->
                <h2>Right Panel</h2>
                <p>This is the content of the right panel.</p>
            </div>
        </div>
    </div>

    <!-- 카카오맵 API. div 보다 아래 위치해야 작동함 -->
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places();

    // 주변 도서관을 검색하는 함수
    function searchNearbyLibrary(latitude, longitude) {
        var ps = new kakao.maps.services.Places();

        var callback = function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                console.log(result); // 검색 결과 확인

                // 여기서 result 배열에 검색된 '도서관' 목록이 있습니다.
                // 이를 원하는 방식으로 처리하실 수 있습니다.
            }
        };

        var keyword = '도서관'; // 검색할 키워드

        var options = {
            location: new kakao.maps.LatLng(latitude, longitude) // 현재 위치 좌표 설정
        };

        // 키워드로 장소를 검색합니다
        //ps.keywordSearch(keyword, placesSearchCB, options); // 수정된 부분: 콜백 함수로 placesSearchCB를 사용합니다.

        // 콘솔창에도 출력을 하고 키워드로 장소를 검색하는 코드
        // 키워드로 장소를 검색합니다
            ps.keywordSearch(keyword, function(result, status, pagination) {
                placesSearchCB(result, status, pagination);
                console.log(result); // 검색된 장소 정보를 콘솔에 출력
            }, options);
    }

    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
    function placesSearchCB (data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            var bounds = new kakao.maps.LatLngBounds();

            for (var i=0; i<data.length; i++) {
                displayMarker(data[i]);
                bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
            }

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
            // 검색 결과를 모두 포함하고 난 후, 확대 레벨을 조정합니다.
            map.setLevel(5); // 원하는 확대 레벨로 설정, 필요에 따라 지도의 중심도 재조정
        }
    }

    // 중복 함수 제거 후 통합된 displayMarker 함수
    // 큰 지도보기가 위도, 경도로 찾아지지 않아서 지도의 id로 변경
    function displayMarker(place, customMessage) {
        var content = '<div style="padding:5px;font-size:12px;">' + (customMessage || place.place_name) + '<br>' +
                    '<a href="https://map.kakao.com/link/map/' + place.id + '" style="color:blue" target="_blank">큰지도보기</a>' + ' | ' +
                    ' <a href="https://map.kakao.com/link/to/' + place.place_name + ',' + place.x + ',' + place.y +
                    '" style="color:blue" target="_blank">길찾기</a>'
                    + '</div>';
        var iwRemoveable = true;
        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x)
        });

        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: content,
            removable : iwRemoveable
        });

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'click', function() {
        console.log(place);
            infowindow.setContent(content); // 정보창 내용 갱신
            infowindow.open(map, marker);
        });

        // 지도 중심좌표를 마커 위치로 변경합니다
        // 사용자 위치를 표시하는 경우에만 중심좌표를 변경하도록 조건을 추가합니다.
        if (customMessage) {
            map.setCenter(new kakao.maps.LatLng(place.y, place.x));
        }
    }

    // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
    if (navigator.geolocation) {

        // GeoLocation을 이용해서 접속 위치를 얻어옵니다
        navigator.geolocation.getCurrentPosition(function(position) {

            var lat = position.coords.latitude, // 위도
                lon = position.coords.longitude; // 경도

            // 현재 위치를 기준으로 검색하기 위해 검색 함수 호출
            searchNearbyLibrary(lat, lon);
          });

    } else { // HTML5의 GeoLocation을 사용할 수 없을 때 기본 위치로 설정합니다

        var defaultLat = 37.566826, // 기본 위도 값
            defaultLon = 126.9786567; // 기본 경도 값

        // 현재 위치를 기준으로 검색하기 위해 검색 함수 호출
            var locPosition = new kakao.maps.LatLng(defaultLat, defaultLon);
            displayMarker({y: defaultLat, x: defaultLon}, "기본 위치입니다."); // 수정된 부분
    }

    </script>



    <div class="container">
        <div id="result">
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th class="custom-width-15">도서관코드</th>
                        <th class="custom-width-30">도서관명</th>
                        <th class="custom-width-40">도서관주소</th>
                        <th class="custom-width-15">도서관전화번호</th>
                        <th class="hidden-column">도서관위도</th>
                        <th class="hidden-column">도서관경도</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="libraryVO">
                        <tr>
                            <td>${libraryVO.lib_code }</td>
                            <td><a href="library_one?lib_code=${libraryVO.lib_code }">${libraryVO.lib_name }</a></td>
                            <td>${libraryVO.lib_address }</td>
                            <td>${libraryVO.lib_tel }</td>
                            <td class="hidden-column">${libraryVO.lib_latitude}</td>
                            <td class="hidden-column">${libraryVO.lib_longitude}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>



    <!-- 페이징 이전 다음 추가한 것-->
    <div class="pagination justify-content-center">
        <c:if test="${totalPage > 1}">
            <c:set var="startPage" value="${(page - 1) / 5 * 5 + 1}" />
            <c:set var="endPage" value="${startPage + 4}" />
            <c:if test="${endPage > totalPage}">
                <c:set var="endPage" value="${totalPage}" />
            </c:if>

            <!-- 이전 버튼 -->
            <c:if test="${startPage > 1}">
                <a href="#" class="pages" data-page="${startPage - 5}">&laquo; 이전</a>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <a href="#" class="pages" data-page="${i}">${i}</a>
            </c:forEach>

            <!-- 다음 버튼 -->
            <c:if test="${endPage < totalPage}">
                <a href="#" class="pages" data-page="${endPage + 1}">다음 &raquo;</a>
            </c:if>
        </c:if>
    </div>
    <br><br><br>

    <!-- 변수 확인용 -->
    <!-- <div class="container mt-2">
        <p>전체 도서관 수 : ${count } 개</p>
        <p>현재 페이지: ${page} P</p>
        <p>전체 페이지 수: ${totalPage} P</p>
        <p>시작 페이지: ${startPage} P</p>
        <p>끝 페이지: ${endPage} P</p>
        <br>
    </div> -->

    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
</body>

</html>
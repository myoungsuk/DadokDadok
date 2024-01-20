<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.Date" %>
<%@page import="com.multi.mini6.reviewboard.vo.ReviewVO" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        .bo_btn_box {
            display: flex;
            margin-bottom: 50px;
            justify-content: flex-end;
        }

        .bo_btn_box a, .bo_btn_box button {
            display: block;
            padding: 8px 24px;
            background: #0a58ca;
            border: 1px solid #0a58ca;
            border-radius: 5px;
            color: #fff;
        }

        .bo_btn_box .update_btn {
            margin: 0 10px;
        }

        .bo_title {
            padding: 26px 0;
            border: 1px solid #999;
            border-right: none;
            border-left: none;
        }

        .bo_title p {
            padding: 0 6px;
            margin: 0;
            font-size: 28px;
            font-weight: 900;
        }

        .bo_title2 {
            display: flex;
            margin: 10px 0 80px;
            justify-content: space-between;
        }

        .bo_title2 > div > span > span:nth-child(1) {
            margin-right: 6px;
            font-weight: 600;
        }

        .bo_title2 > div > span > span:nth-child(2) {
            margin-right: 12px;
        }

        .bo_title2 .t2_left {
        }

        .bo_content {
            margin-bottom: 100px;
            padding: 0 6px;
        }

        .file_content .img_file:has(.img_list),
        .file_content .file:has(.file_list) {
            width: 100%;
            margin-bottom: 50px;
            padding: 20px;
            background: #f6f6f6;
            border-radius: 10px;
        }

        .file_content .img_file {
            display: flex;
            flex-wrap: wrap;
            text-align: center;
        }

        .file_content .img_file .img_list span {
            text-align: center;
        }

        .file_content .img_file .img_list div {
            width: 200px;
            padding: 10px;
        }

        .file_content .img_file .img_list img {
            width: 100%;
        }

        .file_content .file .file_list {
            display: flex;
            height: 30px;
            margin-bottom: 30px;
            align-items: center;
            cursor: pointer;
        }

        .file_content .file .file_list:last-child {
            margin-bottom: 0;
        }

        .file_content .file .file_list div {
            height: 100%;
            padding: 5px;
        }

        .file_content .file .file_list img {
            height: 100%;
        }
    </style>
    <!-- font awesome css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            // 확장자 확인
            var regex = new RegExp("(.?)\\.(png|jpg|jpeg|gif|pdf|doc|docx|xls|xlsx|ppt|pptx)$");
            // 파일 크기 제한
            var maxSize = 5242880; // 5MB

            function checkExtension(fileName, fileSize) {
                // 파일 크기 확인
                if (fileSize >= maxSize) {
                    alert("파일 크기가 5MB 이상입니다.");
                    return false;
                }
                // 확장자 확인
                if (!regex.test(fileName.toLowerCase())) {
                    alert("지원하지 않는 파일 형식입니다.");
                    return false;
                }

                // 파일 확장자가 허용된 경우
                return true;
            }

            // .file_box 복제
            let cloneFile = $(".file_box").clone();

            $("input[type='file']").change(function (e) {
                let formData = new FormData(); //key-value 형태의 데이터 쌍을 저장하는 객체
                let inputFile = $("input[name='file']");
                let files = inputFile[0].files; // 선택한 파일 목록 가져옴
                console.log("files: " + files);

                // 파일데이터 폼에 집어넣기
                for (let i = 0; i < files.length; i++) {
                    if (!checkExtension(files[i].name, files[i].size)) {
                        return false;
                    }
                    formData.append("file", files[i]);
                } //for
                console.log("----------파일 적재 후 formData 태그------------");
                console.log("formData: " + formData);

                $.ajax({
                    url: "/reviewboard/uploadAjaxFormAction",
                    processData: false,  // 데이터 변환 방지
                    contentType: false,  // 콘텐츠 타입 설정 방지
                    data: formData,
                    type: "POST",
                    dataType: "json",
                    success: function (result) {
                        console.log("result: " + result);
                        console.log(JSON.stringify(result, null, 2));
                        showUploadResult(result); // 업로드 결과 처리 함수

                        //$(".file_box").html(cloneFile.html()); // 복사된 file_box내에 다시 추가해 초기화
                    }
                }); //ajax
            }); //upload_btn change


            // 섬네일
            function showUploadResult(uploadResultArr) {
                if (!uploadResultArr || uploadResultArr.length == 0) {
                    return;
                }
                let uploadUL = $(".file_preview");
                let str = "";
                $(uploadResultArr).each(function (i, obj) {
                    // 이미지 파일인 경우(png, jpg, jpge, gif)
                    let imgType = ["png", "jpg", "jpeg", "gif"];
                    if (imgType.includes(obj.review_file_type)) {
                        console.log("sdf");
                        let fileCallPath = "/resources/reviewBoardUpload/s_" + obj.review_uuid + "_" + encodeURIComponent(obj.review_file_name);
                        str += "<span class='preview_box' data-uuid='" + obj.review_uuid + "' data-filename='" + obj.review_file_name + "' data-type='" + obj.review_file_type + "'><div>";
                        str += "<span>" + obj.review_file_name + "</span>";
                        str += "<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p>";
                        str += "<img src=" + fileCallPath + ">";
                        str += "</div></span>";
                    } else {
                        console.log("****");
                        var fileCallPath = "/resources/reviewBoardUpload/" + obj.review_uuid + "_" + encodeURIComponent(obj.review_file_name);
                        var FileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
                        str += "<span class='preview_box' data-uuid='" + obj.review_uuid + "' data-filename='" + obj.review_file_name + "' data-type='" + obj.review_file_type + "'><div>";
                        str += "<span>" + obj.review_file_name + "</span>";
                        str += "<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='file'><i class='fa fa-times'></i></button></p>";
                        str += "<img src='/resources/img/attach.png'>";
                        str += "</div></span>";
                    } // else end
                }); // uploadResultArr each end

                uploadUL.append(str);

            } // showUploadResult end
            // 파일삭제
            $(".file_preview").on("click", "button", function (e) {
                console.log("삭제버튼 클릭");

                let targetFile = $(this).data("file");
                console.log("targetFile: " + targetFile);
                let type = $(this).data("type");
                console.log("type: " + type);

                // 클릭한 x버튼의 부모중 가장 가까운 .preview_box
                let targetContent = $(this).closest(".preview_box");
                console.log("targetContent: " + targetContent);

                $.ajax({
                    url: "/reviewboard/deleteFile",
                    type: "POST",
                    data: {fileName: targetFile, type: type},
                    success: function (response) {
                        // 성공적으로 삭제되면 섬네일을 DOM에서 제거
                        targetContent.remove();
                    }, //success
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR.responseText);
                        console.error("Error deleting file:", error);
                    } //error
                }); // ajax
            }); //file_preview onclick(파일삭제버튼) end

            $("button[type='submit']").on("click", function (e) {
                // 첨부파일 정보 생성 후 submit 버튼 동작을 하기 위해 기본동작 막기
                //e.preventDefault();
                console.log("submit btn click");

                let formObj = $("form");
                let str = "";

                // 파일이 선택되었을 때만 파일 정보를 추가합니다.
                if ($(".preview_box").length > 0) {
                    $(".preview_box").each(function (i, obj) {
                        let jobj = $(obj);
                        str += "<input type='hidden' name='attachList[" + i + "].review_file_name' value='" + jobj.data("filename") + "'>";
                        str += "<input type='hidden' name='attachList[" + i + "].review_uuid' value='" + jobj.data("uuid") + "'>";
                        str += "<input type='hidden' name='attachList[" + i + "].review_file_type' value='" + jobj.data("type") + "'>";
                    });
                }
                console.log(str)
                formObj.append(str).submit();

            }); // submit btn onclick end

        }); //script

    </script>
<body>

<!-- ======= Top Bar ======= -->
<jsp:include page="/WEB-INF/views/topbar.jsp"/>
<!-- End Top Bar -->

<%-- header --%>
<jsp:include page="/WEB-INF/views/header.jsp"/>

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
<main class="reviewboard">
    <meta charset="UTF-8">
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>게시글 작성 페이지</title>
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
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
    </head>
    <body>
    <%
        session.setAttribute("member_id", "1");
    %>
    <div class="container mt-4">
        <form action="/reviewboard/review_insert" method="post" enctype="multipart/form-data" class="insert_form">
            <div class="form-group">
                <label for="review_title">게시글 제목:</label>
                <input type="text" class="form-control" name="review_title" id="review_title" value="제목을 입력해주세요."
                       onFocus="this.value = ''; return true;">
            </div>

            <div class="form-group">
                <label for="review_content">게시글 내용:</label>
                <textarea class="form-control" name="review_content" id="review_content" rows="5"
                          onFocus="this.value = ''; return true;">내용을 입력해주세요.</textarea>
            </div>
            <div class="form-group">
                <label for="book_isbn">book isbn:</label>
                <input type="text" class="form-control" name="book isbn" id="book isbn" value="고유번호를 입력해주세요."
                       onFocus="this.value = ''; return true;">
            </div>

            <div class="file_row">
                <p>파일첨부</p>
                <div class="file_box">
                    <div class="file_info">
                        <input type="file" name="file" id="upload_btn" multiple>
                        <label for="upload_btn"></label>

                    </div>
                    <div class="file_preview"></div>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">등록</button>
                    <a href="${pageContext.request.contextPath}/reviewboard/review_list3?page=1"
                       class="btn btn-secondary">취소</a>
                </div>

                <input type="hidden" name="member_id" value="${member_id}">
                <p>${path}</p>
        </form>
    </div>

    <!-- jQuery 추가 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Bootstrap JS 추가 -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
    </body>
    </html>
</body>
</html>
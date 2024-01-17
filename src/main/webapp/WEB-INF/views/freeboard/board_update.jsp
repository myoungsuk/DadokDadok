<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/head.jsp"/>
  <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
  <script type="text/javascript">
    $(document).ready(function(){
        // 저장된 파일 불러오기
        (function(){
            let board_id = ${freeBoardVO.board_id};

            $.getJSON("getAttachList/?board_id=" + board_id, function(arr){
             //console.dir("arr: " + arr);

             let img_str = "";
             let file_str = "";
             let str = "";

             $(arr).each(function(i, attach){
                 // 이미지 파일인 경우 이미지 보여지기
                 //console.log("board_file_type(밖): "  + attach.board_file_type);
                 if(attach.board_file_type == "png" || attach.board_file_type == "jpg" || attach.board_file_type == "jpeg" || attach.board_file_type == "gif") {
                    let fileCallPath = "/resources/freeBoardUpload/s_" + attach.board_uuid + "_" + encodeURIComponent(attach.board_file_name);
                    // console.log("fileCallPath: " + fileCallPath);
                    // console.log("board_file_type(안): "  + attach.board_file_type);
                    str += "<span class='preview_box' data-uuid='" + attach.board_uuid + "' data-filename=" + attach.board_file_name + "' data-type='" + attach.board_file_type + "'><div><div class='p_title'>";
                    str += "<span>" + attach.board_file_name + "</span>";
                    str +="<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p></div>";
                    str += "<img src='" + fileCallPath + "'></div></span>";
                    //console.log("img str :  " + img_str);
                    //$(".file_preview").html(img_str);
                } else {
                    // 이미지 파일이 아닌경우
                    //console.log("board_file_type(안2): "  + attach.board_file_type);
                     let fileCallPath = "/resources/freeBoardUpload/" + attach.board_uuid + "_" + encodeURIComponent(attach.board_file_name);
                    str += "<span class='preview_box' data-uuid='" + attach.board_uuid + "' data-filename='" + attach.board_file_name + "' data-type='" + attach.board_file_type + "'><div><div class='p_title'>";
                    str += "<span>" + attach.board_file_name + "</span>";
                    str +="<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p></div>";
                    str += "<img src='/resources/img/attach.png'></div></span>";
                   // $(".file_preview").html(file_str);
                } // else end
                $(".file_preview").html(str);
             }); // arr each end
             }); // getJSON end
        })(); // function end

         // 확장자 확인
         let regex = new RegExp("(.?)\\.(png|jpg|jpeg|gif|pdf|doc|docx|xls|xlsx|ppt|pptx)$");
         // 파일 크기 제한
         let maxSize = 5242880; // 5MB

         function checkExtension(fileName, fileSize){
            // 파일 크기 확인
            if(fileSize >= maxSize){
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
          let cloneFile =  $(".file_box").clone();

          $("input[type='file']").change(function(e) {
            let formData = new FormData(); //key-value 형태의 데이터 쌍을 저장하는 객체
            let inputFile = $("input[name='file']");
            let files = inputFile[0].files; // 선택한 파일 목록 가져옴
            //console.log("files: " + files);

            // 파일데이터 폼에 집어넣기
            for (let i = 0; i < files.length; i++) {
              if (!checkExtension(files[i].name, files[i].size)) {
                return false;
              }
              formData.append("file", files[i]);
            } //for

            $.ajax({
              url: "/freeboard/uploadAjaxFormAction",
              processData: false,  // 데이터 변환 방지
              contentType: false,  // 콘텐츠 타입 설정 방지
              data: formData,
              type: "POST",
              dataType: "json",
              success: function(result) {
                console.log("result: " + result);
                console.log(JSON.stringify(result, null, 2));
                showUploadResult(result); // 업로드 결과 처리 함수

                //$(".file_box").html(cloneFile.html()); // 복사된 file_box내에 다시 추가해 초기화
              }
            }); //ajax
          }); //upload_btn change




          // 섬네일
          function showUploadResult(uploadResultArr){
            if(!uploadResultArr || uploadResultArr.length == 0 ){
              return;
            }
            let uploadUL = $(".file_preview");
            let str = "";

            $(uploadResultArr).each(function(i, obj){
              // 이미지 파일인 경우(png, jpg, jpge, gif)
              let imgType = ["png", "jpg", "jpeg", "gif"];
              if(imgType.includes(obj.board_file_type)){
                let fileCallPath = "/resources/freeBoardUpload/s_" + obj.board_uuid + "_" + encodeURIComponent(obj.board_file_name);
                str += "<span class='preview_box' data-uuid='" + obj.board_uuid + "' data-filename='" + obj.board_file_name + "' data-type='" + obj.board_file_type + "'><div><div class='p_title'>";
                str += "<span>" + obj.board_file_name  + "</span>";
                str += "<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p></div>";
                str += "<img src=" + fileCallPath + ">";
                str += "</div></span>";
              } else {
                var fileCallPath = "/resources/freeBoardUpload/" + obj.board_uuid + "_" + encodeURIComponent(obj.board_file_name);
                var FileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
                str += "<span class='preview_box' data-uuid='" + obj.board_uuid + "' data-filename='" + obj.board_file_name + "' data-type='" + obj.board_file_type + "'><div><div class='p_title'>";
                str += "<span>" + obj.board_file_name  + "</span>";
                str += "<p class='preview_close'><button type='button' data-file=\'" + fileCallPath + "\' data-type='file'><i class='fa fa-times'></i></button></p></div>";
                str += "<img src='/resources/img/attach.png'>";
                str += "</div></span>";
              } // else end
            }); // uploadResultArr each end

            uploadUL.append(str);

          } // showUploadResult end

          // 파일삭제
          $(".file_preview").on("click","button",function(e){
            console.log("삭제버튼 클릭");

            let targetFile = $(this).data("file");
              console.log("targetFile: " + targetFile);
            let type = $(this).data("type");
              console.log("type: " + type);

            // 클릭한 x버튼의 부모중 가장 가까운 .preview_box
            let targetContent = $(this).closest(".preview_box");
              console.log("targetContent: " + targetContent);

            $.ajax({
              url: "/freeboard/deleteFile",
              type: "POST",
              data: { fileName: targetFile, type: type },
              success: function (response) {
                // 성공적으로 삭제되면 섬네일을 DOM에서 제거
                targetContent.remove();
              }, //success
              error: function(jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
                console.error("Error deleting file:", error);
              } //error
            }); // ajax
          }); //file_preview onclick(파일삭제버튼) end

          $("button[type='submit']").on("click", function(e){
            // 기본 form 제출 동작을 막습니다
            e.preventDefault();
            console.log("submit btn click");

            let formObj = $("form");
            let formData = new FormData(formObj[0]);
            let boardId = ${freeBoardVO.board_id};


            // 파일 하나당 이름, uuid, type 정보를 FormData에 담기
            $(".preview_box").each(function(i, obj){
              let jobj = $(obj);
              formData.append('attachList[' + i + '].board_id', boardId);
              formData.append('attachList[' + i + '].board_file_name', jobj.data("filename"));
              formData.append('attachList[' + i + '].board_uuid', jobj.data("uuid"));
              formData.append('attachList[' + i + '].board_file_type', jobj.data("type"));
            }); // preview_box each end

            // AJAX를 사용하여 폼 데이터와 함께 PUT 요청을 서버로 전송
            $.ajax({
              url: formObj.attr('action'), // form의 action 속성 값 사용
              type: 'PUT',
              data: formData,
              processData: false, // FormData를 사용할 때는 processData와 contentType을 false로 설정
              contentType: false,
              success: function(response) {
                console.log('서버 응답:', response);
                window.location.href = "/freeboard/board_one?board_id=" +  boardId;
              },
              error: function(xhr, status, error) {
                console.error('에러 발생:', error);
                // 에러 처리 로직
              }
            }); // ajax end
          }); // submit btn onclick end


        }); //script

  </script>
<body>
    <!-- ======= Top Bar ======= -->
    <jsp:include page="/WEB-INF/views/topbar.jsp"/>
    <!-- End Top Bar -->
    <%-- header --%>
    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <main>
        <!-- ======= Breadcrumbs ======= -->
        <section id="breadcrumbs" class="breadcrumbs">
            <div class="container">
                 <div class="d-flex justify-content-between align-items-center">
                      <h2>자유게시판</h2>
                      <ol>
                          <li><a href="../mainpage/index">Home</a></li>
                          <li>자유게시판</li>
                      </ol>
                 </div>
            </div>
        </section><!-- End Breadcrumbs -->
        <section class="freeboard">
              <div class="b_info">
                    <p>자유게시판 게시글 수정</p>
                    <div>공포심, 불안감 또는 불쾌감을 유발할 수 있는 게시물 작성은 금지합니다.</div>
              </div>
              <form action="/freeboard/board_update" method="post" class="insert_form">
                    <input type="hidden" name="board_id" value="${freeBoardVO.board_id}">
                    <div class="in_row">
                          <p>제 목:</p>
                           <input type="text" name="board_title" value="${freeBoardVO.board_title}">
                    </div>
                    <div class="in_row">
                          <p>내 용:</p>
                           <textarea name="board_content">${freeBoardVO.board_content}</textarea>
                   </div>
                    <div class="file_row">
                           <p>파일첨부</p>
                           <div class="file_box">
                                 <div class="file_info">
                                      <input type="file" name="file" id="upload_btn" multiple>
                                      <label for="upload_btn">파일선택</label>
                                      <div> png, jpg, jpeg, gif, pdf, doc/docx, xls/xlsx, ppt/pptx 만 업로드 가능합니다.</div>
                                 </div>
                              <div class="file_preview"> </div>
                           </div>
                    </div>
                    <div class="in_btn">
                          <button type="submit">수정완료</button>
                          <a href="${pageContext.request.contextPath}/freeboard/board_list">취소하기</a>
                    </div>
              </form>
        </section>
    </main>
    <!-- ======= Footer ======= -->
    <jsp:include page="/WEB-INF/views/footer.jsp"/>
    <!-- End Footer -->
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/head.jsp"/>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
  <script type="text/javascript">
    $(document).ready(function(){
        // 확장자 확인
        var regex = new RegExp("(.?)\\.(png|jpg|jpeg|gif|pdf|doc|docx|xls|xlsx|ppt|pptx)$");
        // 파일 크기 제한
        var maxSize = 5242880; // 5MB

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
            console.log("files: " + files);

            // 파일데이터 폼에 집어넣기
            for (let i = 0; i < files.length; i++) {
              if (!checkExtension(files[i].name, files[i].size)) {
                return false;
              }
              formData.append("file", files[i]);
            } //for
            //console.log("----------파일 적재 후 formData 태그------------");
            //console.log("formData: " + formData);

            $.ajax({
              url: "/freeboard/uploadAjaxFormAction",
              processData: false,  // 데이터 변환 방지
              contentType: false,  // 콘텐츠 타입 설정 방지
              data: formData,
              type: "POST",
              dataType: "json",
              success: function(result) {
                 //console.log("result: " + result);
                 //console.log(JSON.stringify(result, null, 2));
                 showUploadResult(result); // 업로드 결과 처리 함수
              }
            }); //ajax
        }); //input[type=file] change


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
                    str += "<p><button type='button' data-file=\'" + fileCallPath + "\' data-type='image'><i class='fa fa-times'></i></button></p></div>";
                    str += "<img src=" + fileCallPath + ">";
                    str += "</div></span>";
                } else {
                    var fileCallPath = "/resources/freeBoardUpload/" + obj.board_uuid + "_" + encodeURIComponent(obj.board_file_name);
                    var FileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
                    str += "<span class='preview_box' data-uuid='" + obj.board_uuid + "' data-filename='" + obj.board_file_name + "' data-type='" + obj.board_file_type + "'><div><div class='p_title'>";
                    str += "<span>" + obj.board_file_name  + "</span>";
                    str += "<p><button type='button' data-file=\'" + fileCallPath + "\' data-type='file'><i class='fa fa-times'></i></button></p></div>";
                    str += "<img src='/resources/img/attach.png'>";
                    str += "</div></span>";
              } // else end
             }); // uploadResultArr each end

            uploadUL.append(str);
        } // showUploadResult end

        // 파일삭제
        $(".file_preview").on("click","button",function(e){
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
            // 첨부파일 정보 생성 후 submit 버튼 동작을 하기 위해 이벤트 버블링만을 막기
            //e.preventDefault();
            e.stopPropagation();
             console.log("submit btn click");

             let formObj = $("form");
             let str = "";

              // 파일 하나당 이름, uuid, type 정보를 input에 담기
              $(".preview_box").each(function(i, obj){
                  let jobj = $(obj);
                  //console.dir("jobj dir: " + jobj); // dir: json형태 출력가능

                  str += "<input type='hidden' name='attachList[" + i + "].board_file_name' value='" + jobj.data("filename") + "'>";
                  str += "<input type='hidden' name='attachList[" + i + "].board_uuid' value='" + jobj.data("uuid") + "'>";
                  str += "<input type='hidden' name='attachList[" + i + "].board_file_type' value='" + jobj.data("type") + "'>";
              }); // preview_box each end

              // 추가된 input를 form에 추가 후 데이터 전송
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
      </section>
      <section class="freeboard">
            <div class="b_info">
                <p>자유게시판 게시글 작성</p>
                <div>공포심, 불안감 또는 불쾌감을 유발할 수 있는 게시물 작성은 금지합니다.</div>
            </div>
            <form action="/freeboard/board_insert" method="post" enctype="multipart/form-data" class="insert_form">
                <div class="in_row">
                   <p>제 목:</p>
                   <input type="text" name="board_title">
                </div>
                <div class="in_row">
                   <p>내 용:</p>
                   <textarea name="board_content"></textarea>
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
                    <button type="submit">등록</button>
                    <a href="${pageContext.request.contextPath}/freeboard/board_list">취소</a>
                </div>
               <input type="hidden" name="member_id" value="<sec:authentication property='principal.member.member_id'/>" />
            </form>
      </section>
  </main>
  <!-- ======= Footer ======= -->
  <jsp:include page="/WEB-INF/views/footer.jsp"/>
  <!-- End Footer -->
</body>
</html>
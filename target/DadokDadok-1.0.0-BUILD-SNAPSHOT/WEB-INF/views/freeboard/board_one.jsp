<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/views/head.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
 <script type="text/javascript">



     $(document).ready(function(){

     // 파일 불러오기
         //console.log("board_id: " + ${result.board_id});
       (function(){
         let board_id = "<c:out value='${result.board_id}'/>";

           let board_id_number = Number(board_id);  // 123
        // console.log("board_id: " + board_id);
        // console.log("board_id_number: " + board_id_number);

         $.getJSON("getAttachList/?board_id=" + board_id_number, function(arr){
           // console.log(board_id);
           // console.dir("arr: " + arr);
           // console.log(JSON.stringify(  arr, null, 2));

           let img_str = "";
           let file_str = "";
           $(arr).each(function(i, attach){
              // 이미지 파일인 경우 이미지 보여지기
             //console.log("board_file_type(밖): "  + attach.board_file_type);
             if(attach.board_file_type == "png" || attach.board_file_type == "jpg" || attach.board_file_type == "jpeg" || attach.board_file_type == "gif") {
                 let fileCallPath = "/resources/freeBoardUpload/" + attach.board_uuid + "_" + encodeURIComponent(attach.board_file_name);
                 console.log("fileCallPath: " + fileCallPath);
                  console.log("board_file_type(안): "  + attach.board_file_type);
                  img_str += "<span class='img_list' data-uuid='" + attach.board_uuid + "' data-filename='" + attach.board_file_name + "' data-type='" + attach.board_file_type + "'>";
                  img_str += "<span>" + attach.board_file_name + "</span>";
                  img_str += "<div><img src='" + fileCallPath + "'></div></span></div></div>";
                  //console.log("img str :  " + img_str);
                  $(".img_file").html(img_str);
               } else {
               // 이미지 파일이 아닌경우
               //console.log("board_file_type(안2): "  + attach.board_file_type);
                  file_str += "<div class='file_list' data-uuid='" + attach.board_uuid + "' data-filename='" + attach.board_file_name + "' data-type='" + attach.board_file_type + "'> ";
                  file_str += "<div><img src='/resources/img/attach.png'></div>";
                 file_str += "<span>" + attach.board_file_name + "</span></div>";
                $(".file").html(file_str);
               } // if end
           }); // arr each end

         }); // getJSON end

         // 이미지 파일이 아닌경우 클릭시 다운로드
         $(".file").on("click", ".file_list", function(e){
           console.log("click");

           let file = $(this);
           let path =  "/resources/freeBoardUpload/" + file.data("uuid") + "_" + file.data("filename");
           //console.log("path : " + path);

           self.location = "download?fileName=" + file.data("uuid") + "_" + file.data("filename");
         }); // file click end
       })();  //function end


     // 원댓글 수정버튼 누르면 수정할 수 있는 textarea 보여지기
     $(".parentUpdate").click(function(){
          // closest: 선택요소를 포함한 상위 요소 중 지정한 선택자에 해당하는 첫번째 요소
          let selectParent = $(this).closest(".c_parent").find(".c_update");
          selectParent.css("display", "flex");
     }); // parentUpdate onclick end

    // 대댓글 수정버튼 누르면 수정할 수 있는 textarea 보여지기
     $(".childUpdate").click(function(){
          // closest: 선택요소를 포함한 상위 요소 중 지정한 선택자에 해당하는 첫번째 요소
          let selectChild = $(this).closest(".c_child").find(".c_update");
          selectChild.css("display", "flex");
     }); // chlidUpdate onclick end

    // 댓글 수정 취소누르면 textarea 보이지 않게하기
    $(".updateRevoke").click(function(){
          // textarea에 입력되어있던 원본 값 가져오기
          let originalContent =$(this).siblings("textarea").data("content");
          // textarea에 입력했던 값 대신 원본 값 넣기
          $(this).siblings("textarea").val(originalContent);
          $(this).closest(".c_update").css("display", "none");
    });

    // 댓글 수정 - 수정완료버튼 클릭
    $(".contentUpdate").click(function(){
        // 수정내용
        let cm_content = $(this).closest(".c_btn").siblings("textarea").val();
        // 댓글 id
        let bocm_id = $(this).data('bocm_id');

        $.ajax({
              url: "/freeboard/comment_update",
              type: "PUT",
              contentType: "application/json",
              data: JSON.stringify({
                    bocm_id: bocm_id,
                    cm_content: cm_content
              }),
              success: function(response) {
                  location.reload(); // 새로고침
              },
              error: function(xhr, status, error) {
                  // 오류 처리
                  console.error('댓글 수정에 실패했습니다.');
              }
         }); // ajax end
    }); //contentUpdate click end

    // 댓글 삭제
    $(".deleteBtn").click(function(){
        // 댓글 id
        let delete_bocm_id = $(this).data('bocm_id');
        console.log("delete_bocm_id + " + delete_bocm_id);

         $.ajax({
              url: "/freeboard/comment_delete",
              type: "POST",
              data: {bocm_id: delete_bocm_id},
             success: function(response) {
                    location.reload(); // 새로고침
             },
             error: function(xhr, status, error) {
                   // 오류 처리
                   console.error('댓글 삭제 실패했습니다.');
             }
         }); // ajax end

    }); //deleteBtn click end


    // 댓글 버튼 누르면 대댓글 입력할 수 있는 textarea 보여지기
     $(".replyBtn").click(function(){
          // closest: 선택요소를 포함한 상위 요소 중 지정한 선택자에 해당하는 첫번째 요소
          let selectChild = $(this).closest(".c_parent").find(".reply");
          selectChild.css("display", "flex");
     }); // replyBtn click end

    // 대댓글  취소누르면 textarea 보이지 않게하기
    $(".replyRevoke").click(function(){
        // 입력 했던 값 초기화
        $(this).siblings("textarea").val("");
        $(this).closest(".reply").css("display", "none");
    });

    // 대댓글 입력
    $(".replyInsert").click(function(){
        console.log("click");
            // 대댓글내용
            let cm_content = $(this).closest(".c_btn").siblings("textarea").val();
            // 댓글 id
            let board_id = $(this).data('board_id');
            // 댓글 그룹
            let cm_group = $(this).data('cm_group');
            // 대댓글 member_id
            let rpMemberId = $("#rpMemberId").val();
            //console.log("cm_content " + cm_content);
           // console.log("board_id " + board_id);
           // console.log("cm_group " + cm_group);

            $.ajax({
                  url: "/freeboard/comment_reply",
                  type: "POST",
                  contentType: "application/json",
                  data: JSON.stringify({
                        board_id: board_id,
                        cm_content: cm_content,
                        cm_group: cm_group,
                        member_id: rpMemberId
                  }),
                  success: function(response) {
                      location.reload(); // 새로고침
                  },
                  error: function(xhr, status, error) {
                      // 오류 처리
                      console.error('대댓글 입력에 실패했습니다.');
                  }
            }); // ajax end
    }); //replyInsert click end



 }); // document

 function boardDelete(board_id ) {
     let boardId = board_id;
     // let boardId = ${result.board_id};
     // console.log("삭제버튼클릭");
      if(confirm("정말로 삭제하시겠습니까?")) {

         // fileList 변수를 정의
         let fileList = [];

         // fileList 파일 정보 추가
        $(".file_content, .img_content").each(function (i, fileContent) {

        var uuid = $(fileContent).data("uuid");
        var fileName = $(fileContent).data("filename");
        var fileType = $(fileContent).data("type");

         if (uuid && fileName && fileType) {
                let attach = {
                    board_id: boardId,
                    board_uuid: uuid,
                    board_file_name: fileName,
                    board_file_type: fileType
              };
              fileList.push(attach);
         } // if end
         }); // each end
        //console.log("fileList : ", fileList);
        //console.log(JSON.stringify(fileList, null, 2));

        // 첨부파일이 있을때 파일+게시글 삭제
        if (fileList.length > 0) {
            $.ajax({
                    type: "POST",
                    url: "/freeboard/fileDelete",
                    contentType: "application/json",
                    data: JSON.stringify(fileList),
                    success: function(response) {
                      console.log("서버 응답:", response);
                      // 성공적으로 데이터를 전송한  후 목록페이지로 이동
                      window.location.href = "/freeboard/board_list";
                    },
                    error: function(xhr, status, error) {
                      console.error("에러 발생:", error);
                      // 에러 처리 로직
                    }
          }); // ajax end
        } else {
              // 첨부파일 없을때 게시글만 삭제
             deleteBoard(board_id);
        }
      }; //confirm end
    }; //boardDelete end
// 첨부파일 없을때 게시글만 삭제
function deleteBoard(board_id) {
  $.ajax({
    type: "POST",
    url: "/freeboard/board_delete?board_id=" + board_id,
    success: function(response) {
      console.log("게시글 삭제 성공:", response);
      window.location.href = "/freeboard/board_list";
    },
    error: function(xhr, status, error) {
      console.error("게시글 삭제 에러 발생:", error);
    }
  });
}


// 댓글 작성
function commentInsert(){
    let content = $("#cmContent").val();
    let boardId = ${result.board_id};
    let memberId = $("#cmMemberId").val();
    //console.log("content : " + content);
    //console.log("boardId : " + boardId);

    $.ajax({
        type: "post",
        url: "/freeboard/comment_insert",
        contentType: "application/json",
        dataType: "json",
        data: JSON.stringify({
                cm_content: content,
                board_id: boardId,
                member_id: memberId
        }),
        success: function(groupedComments){
            location.reload(); // 새로고침
        },
        error: function(xhr, status, error) {
          console.error("댓글 등록 에러 발생:", error);
        }
    }); // ajax end

}

   </script>
<body>
    <!-- ======= Top Bar ======= -->
    <jsp:include page="/WEB-INF/views/topbar.jsp"/>
    <!-- End Top Bar -->
    <%-- header --%>
    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <main id="main">
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
                 <p>자유게시판 </p>
                 <div>독서 후기를 제외한 의견을 자유롭게 남기는 공간입니다.</div>
            </div>
            <div class="board_one">
                <div class="bo_btn_box">
                  <a href="board_list?page=${page}&searchType=${searchType}&keyword=${keyword}" class="list_btn">목록</a>
                  <sec:authentication property="principal" var="pinfo"/>
                      <c:if test="${pinfo.member.member_id eq result.member_id}"> <%-- 로그인한 유저인 경우에만 버튼 보임 --%>
                          <a href="/freeboard/board_update?board_id=${result.board_id}" class="update_btn">수정</a>
                          <button type="button" onclick="boardDelete(${result.board_id})" id="deleteBtn">삭제</button>
                      </c:if>
                </div>
                <div class="bo_title">
                   <p>${result.board_title}</p>
                </div>
                <div class="bo_title2">
                     <div class="t2_left">
                          <span>
                               <span>작성자</span>
                               <span>${result.nickname}</span>
                          </span>
                          <span>
                               <span>조회수</span>
                               <span>${result.board_views}</span>
                          </span>
                     </div>
                     <div class="t2_right">
                          <span>
                               <span>등록일</span>
                               <span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${result.board_createdAt}"/></span>
                          </span>
                          <span>
                               <span>수정일</span>
                              <span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${result.board_updatedAt}"/></span>
                          </span>
                   </div>
               </div>
               <div class="bo_content">
                   <p>${result.board_content}</p>
                </div>
               <div class="file_content">
                    <div class="img_file"></div>
                    <div class="file"></div>
               </div>
               <div class="comment">
                    <p>댓글</p>
                    <c:forEach items="${groupedComments}" var="entry">
                    <div class="c_group">
                         <c:forEach items="${entry.value}" var="comment">
                            <c:if test="${comment.cm_class == 0}">
                                <div class="c_parent">
                                    <div class="c_title">
                                        <div class="title_info">
                                           <p>${comment.nickname}</p>
                                          <p>(<fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${comment.cm_createdAt}"/>)</p>
                                          <p>(<fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${comment.cm_modifiedAt}"/>)</p>
                                        </div>
                                        <div class="title_btn">
                                             <button type="button" class="replyBtn">댓글</button>
                                              <sec:authorize access="isAuthenticated()">
                                                      <%-- 댓글 작성자와 로그인한 사용자가 같을 경우에만 수정 및 삭제 버튼을 표시 --%>
                                                      <sec:authentication property="principal.member.member_id" var="loggedInMemberId" />
                                                      <c:if test="${comment.member_id eq loggedInMemberId}">
                                                          <button type="button" class="parentUpdate">수정</button>
                                                          <button type="button" class="deleteBtn" data-bocm_id="${comment.bocm_id}">삭제</button>
                                                      </c:if>
                                             </sec:authorize>
                                        </div>
                                    </div>
                                    <div class="c_content">
                                        <p>${comment.cm_content}</p>
                                        <div class="c_update"> <%-- 댓글수정 --%>
                                              <textarea data-content="${comment.cm_content}">${comment.cm_content}</textarea>
                                               <sec:authorize access="isAuthenticated()">
                                                    <%-- 댓글 작성자와 로그인한 사용자가 같을 경우에만 수정 및 삭제 버튼을 표시 --%>
                                                    <sec:authentication property="principal.member.member_id" var="loggedInMemberId" />
                                                        <c:if test="${comment.member_id eq loggedInMemberId}">
                                                            <div class="c_btn">
                                                                <button type="button" class="contentUpdate" data-bocm_id="${comment.bocm_id}">수정완료</button>
                                                                 <button type="button" class="updateRevoke">취소</button>
                                                            </div>
                                                        </c:if>
                                               </sec:authorize>
                                        </div>
                                        <div class="reply"> <%-- 대댓글 입력 --%>
                                              <textarea placeholder="댓글을 입력해주세요."></textarea>
                                              <div class="c_btn">
                                                <button type="button" class="replyInsert" data-board_id="${comment.board_id}" data-cm_group="${comment.cm_group}">완료</button>
                                                <button type="button" class="replyRevoke">취소</button>
                                                <input type="hidden" id="rpMemberId" value="<sec:authentication property='principal.member.member_id'/>" />
                                              </div>
                                        </div>
                                    </div>
                                </div><%-- c_parent end--%>
                            </c:if>
                             <c:if test="${comment.cm_class == 1}">
                                <div class="c_child">
                                    <div><i class="fas fa-level-up-alt"></i></i></div>
                                    <div>
                                        <div class="c_title">
                                            <div class="title_info">
                                               <p>${comment.nickname}</p>
                                              <p>(<fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${comment.cm_createdAt}"/>)</p>
                                              <p>(<fmt:formatDate  pattern="yyyy-MM-dd HH:mm:ss" value="${comment.cm_modifiedAt}"/>)</p>
                                            </div>
                                            <sec:authorize access="isAuthenticated()">
                                                <%-- 댓글 작성자와 로그인한 사용자가 같을 경우에만 수정 및 삭제 버튼을 표시 --%>
                                                <sec:authentication property="principal.member.member_id" var="loggedInMemberId" />
                                                    <c:if test="${comment.member_id eq loggedInMemberId}">
                                                        <div class="title_btn">
                                                            <button type="button" class="childUpdate">수정</button>
                                                             <button type="button" class="deleteBtn" data-bocm_id="${comment.bocm_id}">삭제</button>
                                                        </div>
                                                    </c:if>
                                            </sec:authorize>
                                        </div>
                                        <div class="c_content">
                                            <p>${comment.cm_content}</p>
                                            <div class="c_update">
                                                  <textarea data-content="${comment.cm_content}">${comment.cm_content}</textarea>
                                                  <div class="c_btn">
                                                      <button type="button"  class="contentUpdate" data-bocm_id="${comment.bocm_id}">수정완료</button>
                                                      <button type="button" class="updateRevoke">취소</button>
                                                  </div>
                                            </div>
                                        </div>
                                     </div>
                                 </div><%-- c_child end --%>
                             </c:if>
                            </c:forEach>
                        </div> <%-- c_group end --%>
                     </c:forEach>
                    <div class="c_input">
                          <p>댓글작성</p>
                          <div>
                              <textarea id="cmContent" placeholder="내용을 입력하세요"></textarea>
                              <button type="button" id="cmInsertBtn" onclick="commentInsert()">등록</button>
                          </div>
                          <input type="hidden" id="cmMemberId" value="<sec:authentication property='principal.member.member_id'/>" />
                    </div>
              </div><%-- comment end --%>
         </div><%-- board_one end --%>
       <div class="bo_page">
          <div>
           <%-- 이전글 --%>
               <c:if test="${not empty previousPost}">
                   <span>이전글</span>
                   <div class="pre_link">
                        <a href="${pageContext.request.contextPath}/freeboard/board_one?board_id=${previousPost.board_id}&page=${page}&searchType=${searchType}&keyword=${keyword}">${previousPost.board_title}</a>
                   </div>
               </c:if>
           </div>
           <div>
               <%-- 다음글  --%>
               <c:if test="${not empty nextPost}">
                   <span>다음글</span>
                   <div class="next_link">
                        <a href="${pageContext.request.contextPath}/freeboard/board_one?board_id=${nextPost.board_id}&page=${page}&searchType=${searchType}&keyword=${keyword}">${nextPost.board_title}</a>
                   </div>
               </c:if>
           </div>

       </div>
    </section>

</main> <%-- main end --%>
<!-- ======= Footer ======= -->
<jsp:include page="/WEB-INF/views/footer.jsp"/>
<!-- End Footer -->

</body>
</html>
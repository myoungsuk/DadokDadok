<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .pages {
            background: lime;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <h2>공지게시판 - 수정</h2>
    <form action="/noticeboard/noticeboard_update/${existingNotice.notc_id}" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="notc_title">제목</label>
            <input type="text" class="form-control" id="notc_title" name="notc_title" value="${existingNotice.notc_title}" required>
        </div>
        <div class="form-group">
            <label for="notc_content">내용</label>
            <textarea class="form-control" id="notc_content" name="notc_content" rows="10" required>${existingNotice.notc_content}</textarea>
        </div>
        <c:if test="${not empty existingNotice.notice_uuid}">
            <div>
                <img src="${existingNotice.getImageUrl()}" alt="${existingNotice.notice_file_name}" class="img-fluid">
            </div>
        </c:if>
        <div class="form-group">
            <label for="attachment">첨부 파일</label>
            <input type="file" class="form-control-file" id="attachment" name="file">
        </div>
        <button type="submit" class="btn btn-info">수정</button>
        <!-- Delete button for deleting the notice -->
        <a href="#" onclick="deleteNotice(${existingNotice.notc_id})" class="btn btn-danger">삭제</a>
        <a href="/noticeboard/noticeboard" class="btn btn-secondary">목록으로</a>
    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function deleteNotice(notc_id) {
            $.ajax({
                url: '/noticeboard/noticeboard_delete/' + notc_id,
                type: 'DELETE',
                success: function(result) {
                    // Handle success response
                    // For example, you can redirect to another page
                    window.location.href = '/noticeboard/noticeboard';
                },
                             error: function(xhr, status, error) {
                                 // Handle error response
                                 window.location.href = '/noticeboard/noticeboard';
                             }
            });
        }
    </script>
</body>
</html>

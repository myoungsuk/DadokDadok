<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
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
        .card-title {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        .card-text {
            font-size: 1rem;
            color: #666;
        }
        .card-subtitle {
            font-size: 0.8rem;
            color: #999;
        }
        .attachment-img {
            max-width: 100%;
            height: auto;
            display: block; /* Added to ensure proper image display */
            margin-bottom: 10px; /* Added for spacing between images */
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <h2>공지게시판</h2>
        <c:choose>
            <c:when test="${not empty noticeBoardVO}">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${noticeBoardVO.notc_title}</h5>
                        <p class="card-subtitle">Created Date: <fmt:formatDate value="${noticeBoardVO.notc_createdAt}" pattern="yyyy-MM-dd HH:mm"/></p>
                        <p class="card-subtitle">Updated Date: <fmt:formatDate value="${noticeBoardVO.notc_updatedAt}" pattern="yyyy-MM-dd HH:mm"/></p>
                        <p class="card-subtitle">Views: ${noticeBoardVO.notc_views}</p>
                        <c:if test="${not empty noticeBoardVO.notice_uuid}">
                            <img src="<c:url value='/upload-dir/${noticeBoardVO.notice_uuid}_${noticeBoardVO.notice_file_name}'/>" alt="${noticeBoardVO.notice_file_name}" class="img-fluid">
                        </c:if>
                        <p class="card-text">${noticeBoardVO.notc_content}</p>
                        <a href="/noticeboard/noticeboard_update/${noticeBoardVO.notc_id}" role="button" class="btn btn-primary">Edit</a>
                        <!-- Delete button triggering AJAX request -->
                        <button type="button" onclick="deleteNotice(${noticeBoardVO.notc_id})" class="btn btn-danger">삭제</button>
                        <a href="noticeboard" class="btn btn-secondary">Back to List</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <p>Notice not found.</p>
            </c:otherwise>
        </c:choose>
        <c:if test="${not empty exception}">
            <p>An error occurred: ${exception.message}</p>
        </c:if>
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

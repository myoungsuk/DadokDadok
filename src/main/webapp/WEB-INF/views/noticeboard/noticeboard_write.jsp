<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 등록</title>
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
    <h2>공지게시판 - 게시</h2>
    <form action="noticeboard_insert" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="notc_title">제목</label>
            <input type="text" class="form-control" id="notc_title" name="notc_title" placeholder="제목을 입력해주세요.">
        </div>
        <div class="form-group">
            <label for="notc_content">내용</label>
            <textarea class="form-control" id="notc_content" name="notc_content" rows="10"></textarea>
        </div>
        <div class="form-group">
                <label for="file">Choose File</label>
                <input type="file" id="file" name="file">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        <a href="noticeboard" class="btn btn-secondary">목록으로</a>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

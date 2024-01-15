<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.multi.mini6.noticeboard.vo.NoticeBoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                list-style: none;
                padding: 0;
            }
            .pagination li {
                margin: 0 2px;
                border: 1px solid #ced4da;
                border-radius: 3px;
                width: 30px; /* Adjust the width as needed */
                height: 30px; /* Adjust the height as needed */
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .pagination li.active {
                background-color: lime;
            }
            .pagination a {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                height: 100%;
                text-align: center;
                text-decoration: none;
            }
    </style>
</head>
<body>
    <div class="container">
        <h2>공지게시판</h2>
        <p>총 게시물 수: ${count}</p>
        <a href="noticeboard_write" class="btn btn-primary">새 글 쓰기</a>
        <br><br>
        <div class="row">
            <div class="col">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">글번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">작성일</th>
                            <th scope="col">수정일</th>
                            <th scope="col">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${noticeboard}" var="noticeboardVO">
                            <tr>
                                <td>${noticeboardVO.notc_id}</td>
                                <td><a href="noticeboard_one?notc_id=${noticeboardVO.notc_id}">${noticeboardVO.notc_title}</a></td>
                                <td><fmt:formatDate value="${noticeboardVO.notc_createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td><fmt:formatDate value="${noticeboardVO.notc_updatedAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td>${noticeboardVO.notc_views}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <ul class="pagination">
                            <c:forEach begin="1" end="${noticeBoardPageVO.totalPages}" var="i">
                                <li class="page-item ${noticeBoardPageVO.page == i ? 'active' : ''}">
                                    <a class="page-link" href="noticeboard?page=${i}&pageSize=5">${i}</a>
                                </li>
                            </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

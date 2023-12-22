<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .input-group {
            margin-bottom: 15px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error, .logout {
            color: red;
            text-align: center;
        }
    </style>

    <script>
        // 로그아웃 메시지 표시를 위한 JavaScript
        // 이 페이지로 이동할 때 logout 파라미터가 있으면 alert 메시지를 표시한다.
        window.onload = function() {
            <c:if test="${not empty logout}">
            alert("로그아웃되었습니다.");
            </c:if>
        };
    </script>

</head>
<body>
<form method="post" action="/login">
    <h1>Custom Login Page</h1>
    <c:if test="${not empty error}">
        <div class="error">
            <c:out value="${error}" />
        </div>
    </c:if>

    <!-- 네이버 로그인 버튼 추가 -->
    <c:if test="${url ne null}">
        <div id="naver_id_login" style="text-align: center; margin-bottom: 20px;">
            <a href="${url}">
                <img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/>
            </a>
        </div>
    </c:if>

    <div class="input-group">
        <input type="text" name="username" placeholder="Username">
    </div>
    <div class="input-group">
        <input type="password" name="password" placeholder="Password">
    </div>
    <div class="input-group">
        <input type="submit" value="Login">
    </div>
    <div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </div>
</form>

</body>
</html>

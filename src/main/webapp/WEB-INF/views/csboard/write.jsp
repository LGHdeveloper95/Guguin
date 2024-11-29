
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 게시글작성</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico" />
    <link rel="stylesheet" href="/css/common.css" />
    <style>
        main {
            display: flex;
            justify-content: center; 
            gap: 10px; 
        }
       
      
        .writebox{
            width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        input[readonly] {
            background-color: #f5f5f5;
            color: #999;
        }

        .btn-primary {
            background-color: #333;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            margin-right: 10px;
            display: inline-block;
        }

        .btn-primary:hover {
            background-color: #000;
            transition: background-color 0.3s ease;
        }

        .btn-secondary {
            background-color: #555;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-secondary:hover {
            background-color: #000;
            transition: background-color 0.3s ease;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<main>
   <div class="writebox">
    <h2>게시글 작성</h2>
    <form action="/Cs/Write" method="post">
       

        <!-- 작성자 정보 표시 (기업 또는 개인 사용자) -->
        <label for="userid">작성자</label>
        <input type="text" id="userid" name="userid" value="${sessionScope.userid != null ? sessionScope.userid : sessionScope.comid}" readonly>
         
        <!-- 제목 입력 -->
        <label for="qtitle">제목</label>
        <input type="text" id="qtitle" name="qtitle" required>

        <!-- 내용 입력 -->
        <label for="qcontent">내용</label>
        <textarea id="qcontent" name="qcontent" rows="8" required></textarea>

        <!-- 버튼 -->
        <button type="submit" class="btn-primary">작성 완료</button>
        <a href="/Cs/Board" class="btn-secondary">취소</a>
    </form>
   </div>
</main>
<%@include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 게시글수정</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico" />
    <link rel="stylesheet"  href="/css/common.css" />
    <style>
        form {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        input[readonly] {
            background-color: #e9ecef;
        }
        .btn-group {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .btn-primary, .btn-secondary {
            background-color: #333;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-primary:hover, .btn-secondary:hover {
            background-color: #000;
            transition: background-color 0.3s ease;
        }
        /* 수정과 취소 버튼 간격 추가 */
        .btn-secondary {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <h2>게시글 수정</h2>
    <form action="/Cs/Update" method="post">
       
        <label for="userid">아이디</label>
        <input type="text" id="userid" name="userid" value="${board.userid}" readonly>

        <label for="qdate">작성일</label>
        <input type="text" id="qdate" name="qdate" value="${board.qdate}" readonly>

        <label for="qtitle">제목</label>
        <input type="text" id="qtitle" name="qtitle" value="${board.qtitle}" required>

        <label for="qcontent">내용</label>
        <textarea id="qcontent" name="qcontent" rows="10" required>${board.qcontent}</textarea>

        <button type="submit" class="btn-primary">수정 완료</button>
    <!-- 취소 버튼 추가 -->
        <button type="button" class="btn-secondary" onclick="cancelUpdate('${board.qnum}')">취소</button>
    </form>

    <script>
        // 취소 버튼을 눌렀을 때 상세보기 페이지로 이동하는 함수
        function cancelUpdate(qnum) {
            window.location.href = '/Cs/View?qnum=' + qnum;
        }
    </script>
    <%@include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
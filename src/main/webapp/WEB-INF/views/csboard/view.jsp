

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico" />
    <link rel="stylesheet" href="/css/common.css" />
    <style>
        main {
            min-width: 800px;
            
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

        .form {
            padding: 15px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }

        input[readonly], textarea[readonly] {
            background-color: #e9ecef;
        }

        /* 버튼 그룹 */
        .btn-group {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            border: none;
            background-color: #f8f8f8;
        }

        .btn-primary, .btn-secondary {
            background-color: #333;
            color: white;
            padding: 10px 20px; /* 크기 통일 */
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            display: inline-block;
            margin-right: 10px;
        }

        .btn-primary:hover, .btn-secondary:hover {
            background-color: #000;
            transition: background-color 0.3s ease;
        }

        .btn-primary:active, .btn-secondary:active {
            transform: scale(0.98);
        }

        /* 수정과 뒤로가기 버튼 간격 추가 */
        .btn-secondary {
            margin-left: 10px;
        }
        .answerBox>div{
          border: solid 1px #ccc;
          background-color: #e9ecef;
          min-height: 100px;
          width: 100%; height: 200px; resize: none;
        }
        #answerBtn{
            background-color: #333;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            display: inline-block;
            margin-right: 10px;
        }
        #answerBtn:hover{
          background-color: #000;
            transition: background-color 0.3s ease;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<main>
    <h2>게시글 상세 보기</h2>
    <form>
        <label for="qtitle">제목</label>
        <input type="text" id="qtitle" name="qtitle" value="${board.qtitle}" readonly>

        <label for="qcontent">내용</label>
        <textarea id="qcontent" name="qcontent" rows="10" readonly>${board.qcontent}</textarea>

        <label for="qdate">작성일</label>
        <input type="text" id="qdate" name="qdate" value="${board.qdate}" readonly>
    </form>
    <c:if test="${ sessionScope.userid eq 'admin' }">
          <div class="answerBox">
            <c:if test="${ empty board.answer }">
              <form action="/Cs/Answer?qnum=${ board.qnum }" >
                <input type="hidden" name="qnum" value="${ board.qnum }"/>
                답변
                <textarea name="answer" id="answer">${ not empty board.answer ? board.answer.trim() : '' }</textarea>
                <button id="answerBtn">답변달기</button>
              </form>
            </c:if>
          </div>
        </c:if>
        <c:if test="${ not empty board.answer }">
              <div class="answerBox">
                답변
                <div>${ board.answer }</div>
              </div>
            </c:if>
    <!-- 수정 및 뒤로가기 버튼 -->
    <div class="btn-group">
        <!-- 수정 버튼 -->
        <c:if test="${ sessionScope.userid ne 'admin' }">
        <form action="/Cs/Updateform" method="get" style="display:inline;">
            <input type="hidden" name="qnum" value="${board.qnum}">
            <button type="submit" class="btn-primary">수정</button>
        </form>
        </c:if>
        <!-- 뒤로가기 버튼 (목록으로 돌아가기) -->
        <form action="/Cs/Board" method="get" style="display:inline;">
            <button type="submit" class="btn-secondary">목록으로</button>
        </form>
    </div>
</main>
<script>
  const answerBtn = document.querySelector('#answerBtn');
  answerBtn.addEventListener('click',function(event){
	  event.preventDefault();
	  //alert('ok');
	  const form = event.target.closest('form'); // 버튼이 속한 폼 찾기
	  form.submit();
  });
</script>
<%@include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>

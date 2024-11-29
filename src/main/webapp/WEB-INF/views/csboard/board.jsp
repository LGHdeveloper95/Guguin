<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 고객센터게시판</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico" />
    <link rel="stylesheet" href="/css/common.css" />
    <style>
     <style>
        body {
            text-align: center;
        }

        main {
            display: flex;
            justify-content: center; /* main의 중앙 정렬 */
            gap: 10px; /* Fdiv와 프로필 사이 간격 */
        }

        .Fdiv {
            width: 90%;
            /* width: 700px; */
            background-color: #f9f9f9; /* 연한 회색 배경 */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
            padding: 20px 10px 10px;
        }

         .container {
            width: 250px;
            height:45%;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
         }

        h2 {
            margin-bottom: 20px;
            color: #333; /* 짙은 회색 */
        }

        /* 버튼 스타일 */
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

        .btn-secondary {
            background-color: #555;
        }

        .btn-primary:hover, .btn-secondary:hover {
            background-color: #000;
            transition: background-color 0.3s ease;
        }

        /* 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            /* background-color: #333; */
            color: white;
            font-weight: bold;
        }
        
        /* 아이디별  테마 변경 */
          <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		  table th { background-color: #FAD673; }  </c:if>/* 비로그인 상태 */
		  <c:if test="${not empty sessionScope.userid}">
		  table th { background-color: #FAD673; }  </c:if>/* 개인회원 */
		  <c:if test="${not empty sessionScope.comid}">
		  table th { background-color: #66DD7E; } </c:if> /* 기업회원 */

        table td a {
            color: #333;
            text-decoration: none;
        }

        table td a:hover {
            color: #000;
            text-decoration: underline;
        }

        /* 테이블 행 스타일 */
        table tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        table tbody tr:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<main>
    <div class="Fdiv">
        <h2>고객센터 게시판</h2>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="board" items="${boardList}" varStatus="i">
                    <tr>
                        <td>${ (pagingHelper.nowPage-1)*10 + i.index + 1 }</td>
                        <td>
                           <c:choose>
                               <c:when test="${not empty board.userid}">
                                   ${board.userid}
                               </c:when>
                               <c:otherwise>
                                   ${board.comid}
                               </c:otherwise>
                           </c:choose>
                       </td>
                        <td>
                           <a href="/Cs/View?qnum=${board.qnum}">
                                ${board.qtitle}
                            </a>
                        </td>
                         <td>${board.qdate}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
       <!-- 세션에 userid 또는 comid 있는지 확인 -->
        <c:if test="${(not empty sessionScope.userid || not empty sessionScope.comid) && sessionScope.userid ne 'admin'}">
            <a href="/Cs/Writeform" class="btn btn-primary">문의하기</a>
            <!-- 내가 쓴 글 보기 버튼 -->
            <form action="/Cs/myPosts" method="get" style="display:inline;">
                <button type="submit" class="btn btn-secondary">나의 문의 모아보기</button>
            </form>
        </c:if>
        <%@include file="/WEB-INF/include/Paging.jsp" %>
    </div>
    
</main>
<%@include file="/WEB-INF/include/footer.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>사람과 기업을 연결하는 구구인</title>
  <link rel="icon" type="image/png" href="/img/favicon.ico" />

</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<main>
  <div id="List">
    <c:if test="${ not empty sessionScope.comid }">
      <div id="PostCount">작성하신 공고 ${count}개 입니다.</div>
    </c:if>
    <c:forEach items="${postList}" var="post" varStatus="status">
      <div class="Post">
        <span>${status.index}</span> <a href="/post/view/${post.recnum}">${post.rectitle}</a>
      </div>
    </c:forEach>
    <c:if test="${ not empty sessionScope.comid }">
      <a href="/post/write">새글쓰기</a>
    </c:if>
  </div>
</main>
</body>
</html>


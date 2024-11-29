<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사람과 기업을 연결하는 구구인</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
 main {
  display: flex;
  flex-direction: column;  /* 세로 방향으로 배치 */
  min-height: 85vh;
  flex-grow: 1;
  align-content: center;
}
.bigDiv {
  display:flex;
  flex-direction: column;
  width: 90%;
  background-color: #f9f9f9; /* 연한 회색 배경 */
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
  padding: 80px 50px 0;
  margin: 30px auto;
  flex-grow: 1;
}
.pagination {
  display: flex;
  justify-content: center; /* 수평 중앙 정렬 */
  bottom: 0;
}
.customTable {
  width: 100%;
  margin: 0 auto;
}
a { color: black; text-decoration: none; }
table{ text-align: center; }
 /* 아이디별  테마 변경 */
          <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		  table thead { background-color: #FAD673; }  </c:if>/* 비로그인 상태 */
		  <c:if test="${not empty sessionScope.userid}">
		  table thead { background-color: #FAD673; }  </c:if>/* 개인회원 */
		  <c:if test="${not empty sessionScope.comid}">
		  table thead { background-color: #66DD7E; } </c:if> /* 기업회원 */
</style>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <main>
  <div class="bigDiv">
  <h3>커뮤니티</h3>
  <c:if test="${ not empty sessionScope.userid || not empty sessionScope.comid }">
    <a href="/community/insert" class="btn customBtn" style="margin-left: auto">작성</a>
  </c:if>
  <hr>
  <table class="table table-hover customTable" >
    <thead>
      <tr>
        <th>순번</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
      </tr>
    </thead>
    <c:if test="${ not empty list }">
      <c:forEach items="${ list }" var="comm" varStatus="i">
        <tr>
        <td>${ (pagingHelper.nowPage-1)*10 + i.index + 1 }</td>
        <td><a href="/community/view/${ comm.conum }">${ comm.not_title }</a></td>
        <c:if test="${ not empty comm.userid }">
          <td>${ comm.userid }</td>
        </c:if>
        <c:if test="${ not empty comm.comid }">
          <td>${ comm.comid }</td>
        </c:if>
        <td>${ comm.hiredate }</td>
        <td>${ comm.views }</td>
      </tr>
      </c:forEach>
    </c:if>
    <c:if test="${ empty list }">
      <tr><td colspan="5">작성된 글이 없어요🥲</td></tr>
    </c:if>
  </table>
  <%@include file="/WEB-INF/include/Paging.jsp" %>
  </div>
  </main>
  <%@include file="/WEB-INF/include/footer.jsp" %>
  <script>
  const comid = "${ sessionScope.comid }";
  const changeEl = document.querySelector('.customBtn');
  if(comid!=null && comid!=""){changeEl.classList.add('btn-outline-success');}
  else{changeEl.classList.add('btn-outline-warning');}
</script>
</body>
</html>
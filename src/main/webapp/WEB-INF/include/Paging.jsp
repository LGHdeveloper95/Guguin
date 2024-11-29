
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination">
    <c:if test="${pagingHelper.hasPreviousPageGroup()}">
        <a href="?page=1" class="page-arrow arrow-first">⇤</a>
        <a href="?page=${pagingHelper.previousPageGroupStart}" class="page-arrow arrow-prev">←</a>
    </c:if>

    <c:forEach var="i" begin="${pagingHelper.startPage}" end="${pagingHelper.endPage}">
        <c:choose>
            <c:when test="${i == pagingHelper.nowPage}">
                <span class="now">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="?page=${i}" class="page-link">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${pagingHelper.hasNextPageGroup()}">
        <a href="?page=${pagingHelper.nextPageGroupStart}" class="page-arrow arrow-next">→</a>
        <a href="?page=${pagingHelper.totalPages}" class="page-arrow arrow-last">⇥</a>
    </c:if>
</div>

<style>
/* 페이지네이션 스타일 설정 */
.pagination {
    text-align: center;
    margin-top: 20px;
}

/* 각 페이지 링크 스타일 */
.page-link, .page-arrow, .now {
    display: inline-block;
    width: 40px; /* 버튼의 고정 너비 */
    height: 40px; /* 버튼의 고정 높이 */
    padding: 0;
    line-height: 40px;
/*     background-color: #555; */
    color: white;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    text-align: center;
    font-weight: bold;
}
/* 아이디별  테마 변경 */
          <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		 .page-link { background-color: #FAD673; }  </c:if>/* 비로그인 상태 */
		  <c:if test="${not empty sessionScope.userid}">
		  .page-link { background-color: #FAD673; }  </c:if>/* 개인회원 */
		  <c:if test="${not empty sessionScope.comid}">
		  .page-link { background-color: #66DD7E; } </c:if> /* 기업회원 */

/* 링크에 마우스 오버 시 배경색 변경 */
/* .page-link:hover, .page-arrow:hover {
    background-color: #000;
} */

/* 아이디별  테마 변경 */
          <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		 .page-link:hover { background-color: #EFC03E; }  </c:if>/* 비로그인 상태 */
		  <c:if test="${not empty sessionScope.userid}">
		  .page-link:hover { background-color: #EFC03E; }  </c:if>/* 개인회원 */
		  <c:if test="${not empty sessionScope.comid}">
		  .page-link:hover { background-color: #5CCA72; } </c:if> /* 기업회원 */
		  
          <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		 .page-arrow:hover { background-color: #EFC03E; }  </c:if>/* 비로그인 상태 */
		  <c:if test="${not empty sessionScope.userid}">
		  .page-arrow:hover { background-color: #EFC03E; }  </c:if>/* 개인회원 */
		  <c:if test="${not empty sessionScope.comid}">
		  .page-arrow:hover { background-color: #5CCA72; } </c:if> /* 기업회원 */

/* 현재 페이지 표시 스타일 */
.now {
/*     background-color: #333; */
    color: white;
}
 
 /* 아이디별  테마 변경 */
          <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		 .now { background-color: #EFC03E; }  </c:if>/* 비로그인 상태 */
		  <c:if test="${not empty sessionScope.userid}">
		  .now { background-color: #EFC03E; }  </c:if>/* 개인회원 */
		  <c:if test="${not empty sessionScope.comid}">
		  .now { background-color: #5CCA72; } </c:if> /* 기업회원 */



/* 화살표 스타일 */

<c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		 .page-arrow { background-color: #9B7714; }  </c:if>/* 비로그인 상태 */
		  <c:if test="${not empty sessionScope.userid}">
		  .page-arrow { background-color: #9B7714; }  </c:if>/* 개인회원 */
		  <c:if test="${not empty sessionScope.comid}">
		  .page-arrow { background-color: #2EA546; } </c:if> /* 기업회원 */



/* 좌우 화살표에 여백 추가 */
.arrow-prev {
    margin-right: 10px;
}

.arrow-next {
    margin-left: 10px;
}
</style>

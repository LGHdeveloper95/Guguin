<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>사람과 기업을 연결하는 구구인</title>
  <link rel="icon" type="image/png" href="/img/favicon.ico" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <style>
   main { display: flex; justify-content: center; margin-top: 30px; }
  .main { width: 70%; margin-top: 30px; }
  .table{
	  border: 1px solid #dee2e6; 
	  border-collapse: collapse; /* 테이블 셀 간 간격을 없앰 */
	  width: 100%; 
	}
	.table th, .table td {
	  padding: 10px;             /* 셀 안쪽 패딩을 설정하여 내용이 겹치지 않도록 */
	  text-align: center;        /* 텍스트 중앙 정렬 */
	  border: 1px solid rgb(255, 194, 62); /* 셀 테두리 색상 설정 */
	}
	.table td:first-of-type{ max-width: 30px; }
	.table thead { background-color: #FAD673; /* 헤더의 배경색 설정 */ }
	#listView .table thead { background-color: rgb(255, 194, 62); /* 헤더의 배경색 설정 */ }
	 .table-custom{
	   border-top-left-radius: 0px;
	   border-color: rgb(255, 194, 62);
	}
	a{ color: black; text-decoration: none; }
  </style>
</head>
<body>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <main>
    <%@include file="/WEB-INF/include/mypageSide.jsp" %>
	  <div class="main">
	  <h5>내가 쓴 커뮤니티 글</h5>
		<table id="coverLetter" class="table shadow">
		<thead>
		<tr>
		  <td>순번</td>
	  	  <td>글 제목</td>
		  <td>작성일자</td>
		  <td>조회수</td>
		</tr>
		</thead>
		<c:if test="${ not empty commList }">
		  <c:forEach items="${ commList }" var="comm" varStatus="i">
		    <tr>
		      <td>${ i.index + 1 }</td>
		      <td><a href="/community/view/${ comm.conum }">${ comm.not_title }</a></td>
		      <td>${ comm.hiredate }</td>
		      <td>${ comm.views }</td>
		    </tr>
		  </c:forEach>
		</c:if>
		<c:if test="${ empty commList }">
		  <tr><td colspan="3">작성된 글이 없어요</td></tr>
		</c:if>
		</table>
	  </div>
  </main>
    <%@include file="/WEB-INF/include/footer.jsp" %>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
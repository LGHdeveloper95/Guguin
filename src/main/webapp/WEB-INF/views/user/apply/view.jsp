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
  </style>
</head>
<body>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <main>
    <%@include file="/WEB-INF/include/mypageSide.jsp" %>
	  <div class="main">
	  <table  class="table shadow" id="info">
	    <thead>
	      <tr><td colspan="4">이력서 제목 : ${ resume.restitle }</td></tr>
		</thead>
		  <tr>
		    <td rowspan="4"><img id="profile" alt="pic" style="max-width: 200px;"/></td>
		  </tr>
		  <tr class="subtitle">
		    <td>이름</td>
		    <td colspan="2">${ resume.username }</td>
		  </tr>
		  <tr class="subtitle">
		    <td>학력</td>
		    <td>${ resume.edu_name }</td>
		    <td>
		    <c:if test="${ resume.edu_content == null }">-</c:if>
		    <c:if test="${ resume.edu_content != null }">${ resume.edu_content }</c:if>
		    </td>
		  </tr>
		  <tr class="subtitle">
		    <td>경력</td>
		    <td>${ resume.career_name }</td>
		    <td>
		      <c:if test="${ resume.career_content == null }">-</c:if>
		      <c:if test="${ resume.career_content != null }">${ resume.career_content }</c:if>
		    </td>
		  </tr>
		  <tr class="subtitle">
		    <td colspan="2">자격증</td>
		    <td colspan="2">
		      <c:if test="${ resume.license != '' && resume.license != null }">
		        ${ resume.license }
		      </c:if>
		      <c:if test="${ resume.license == '' || resume.license == null }">
		        -
		      </c:if>
		    </td>
		  </tr>
		  <tr class="subtitle">
		    <td colspan="2">기술분야</td>
		    <td colspan="2">
		      <c:if test="${ resume.skillnames[0] != null && resume.skillnames[0]!=''}">
		        <c:forEach items="${ resume.skillnames }" var="skill" varStatus="num">
		          ${ skill }
		        </c:forEach>
		      </c:if>
		    </td>
		  </tr>
		</table>
		<table id="coverLetter" class="table shadow">
		<thead>
		<tr>
		<td colspan="3">자기소개서</td>
		</tr>
		</thead>
		<tr class="subtitle"><td colspan="3">성장배경</td></tr>
		<tr class="content"><td colspan="3">${ resume.background }</td></tr>
		<tr class="subtitle"><td colspan="3">성격의 장단점</td></tr>
		<tr class="content"><td colspan="3">${ resume.personality }</td></tr>
		<tr class="subtitle"><td colspan="3">지원동기</td></tr>
		<tr class="content"><td colspan="3">${ resume.motivation }</td></tr>
		</table>
	  </div>
  </main>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    window.onload = function(){
    	const imgEl = document.querySelector('#profile');
    	const resnum = "${ resume.sendnum }";
	    const fileUrl = "http://192.168.0.214:9090/download/";
	    $.ajax({
	  	  url: fileUrl+resnum,
	  	  method: "GET"
	    }).done(files => {
	  	  imgEl.setAttribute("src",files[0]);
	    }).fail(error => {
	     console.log(error);
	    })
    }
  </script>
</body>
</html>
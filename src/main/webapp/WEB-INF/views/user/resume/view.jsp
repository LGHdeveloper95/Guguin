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
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    /* 기존 스타일에 Bootstrap을 적용하기 위한 최소한의 수정 */
    main { display: flex; justify-content: center; margin-top: 30px; }
    .main { display:inline-block;  width: 70%; margin-top: 30px; }
    #listNavi {
      display: flex;
      justify-content: flex-start;
    }
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
	.table thead { background-color: #FAD673; /* 헤더의 배경색 설정 */ }
	#listView .table thead { background-color: rgb(255, 194, 62); /* 헤더의 배경색 설정 */ }
  .table-custom{
    border-top-left-radius: 0px;
    border-color: rgb(255, 194, 62);	
  }
  .btn-custom {
    border-top-left-radius: 15px;  /* 왼쪽 상단 모서리 둥글게 */
    border-top-right-radius: 15px; /* 오른쪽 상단 모서리 둥글게 */
    border-bottom-left-radius: 0px;
    border-bottom-right-radius: 0px;
  }
  #resumeList {
  border: 1px solid #dee2e6;
  height: 80px; /* div의 높이 */
  overflow: auto; /* 내용이 넘치면 스크롤 표시 */
  padding: 12px;
  border-radius: 15px;
  margin-bottom: 10px;
  }
  .shadow{ box-shadow:  5px 5px 15px 5px rgba(0, 0, 0, 0.3); }
  .navi-radio{ display: none; }
  .navi-label {
  position: relative;  /* label을 기준으로 절대 위치를 지정하기 위해 relative로 설정 */
  display: inline-block;
  width: 120px;
  height: 40px;
  }
  .navi-radio:checked + span {
  background-color: #ffc107;  /* 선택된 라벨의 배경색을 변경 */
  color: black;                /* 텍스트 색상 흰색으로 변경 */
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
  border-bottom-left-radius: 0px;
  border-bottom-right-radius: 0px;
  }
  .navi-label span {
  display: flex;          /* flexbox로 설정 */
  justify-content: center; /* 가로 중앙 정렬 */
  align-items: center;     /* 세로 중앙 정렬 */
  width: 100%;             /* label의 크기를 꽉 채움 */
  height: 100%;            /* label의 크기를 꽉 채움 */
  position: absolute;      /* 절대 위치로 label 안에서 꽉 차게 설정 */
  top: 0;
  left: 0;
  text-align: center;      /* 텍스트를 가운데 정렬 */
  }
  .subtitle td:first-of-type{ background-color: rgb(253, 241, 211); }
  #info tr:nth-child(2) td:first-of-type{ width: 100px; }
  .content>td{ text-align: left; }
  
  /* 체크 표시를 위한 네모 스타일 */
.custom-radio {
  display: inline-block;
  position: relative;
  padding-left: 30px; /* 라벨 왼쪽에 공간 확보 */
  cursor: pointer;
  font-size: 16px;
}
.custom-radio .checkmark {
  position: absolute;
  left: 0;
  top: 0;
  height: 20px;
  width: 20px;
  background-color: #fff;
  border: 2px solid rgb(253, 241, 211); /* 네모 테두리 색상 */
  border-radius: 0; /* 둥근 모서리 제거 (네모 형태) */
  transition: background-color 0.3s, border-color 0.3s;
}
/* 체크된 상태 */
.navi-radio:checked + .checkmark {
  background-color: rgb(253, 241, 211); /* 체크 시 배경 색상 */
  border-color: rgb(253, 241, 211); /* 체크 시 테두리 색상 */
  border-radius: 0;
}
/* 체크 표시의 내용(체크 표시) */
.navi-radio:checked + .checkmark::after {
  content: "✔️️";
  position: absolute;
  top: -5px;
  left: 0;
  width: 8px;
  height: 8px;
  border-radius: 0; /* 네모로 표시 */
}
ul a{
  text-decoration: none;
  color: black;
  width: 100%;
  padding: 0 10%;
}
ul a:hover {
	text-decoration: underline;
}
.btn { background-color: white; color: rgb(83, 83, 83); }
.table-container {
  max-height: 250px; /* 원하는 높이로 설정 */
  overflow-y: auto;  /* 수직 스크롤 */
  border-top: 1px solid #ffc107;
}
  </style>
</head>
<body>
  <!-- jQuery (Bootstrap 5는 jQuery 의존성이 없지만, AJAX 등 사용을 위해 추가) -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <main>
    <c:if test="${ not empty sessionScope.userid }">
      <%@include file="/WEB-INF/include/mypageSide.jsp" %>
    </c:if>
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
		    <td>성별</td>
		    <td colspan="2">${ resume.gender }</td>
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
		    <td colspan="2">경력</td>
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
    	const resnum = "${ resume.resnum }";
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
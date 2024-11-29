<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사람과 기업을 연결하는 구구인</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
  main { display: flex; justify-content: center; margin-top: 30px; width: 100wv; }
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
  .table tr>td:first-child { background-color: #FAD673; /* 헤더의 배경색 설정 */ }
  .table input{ width: 100%; }
</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
  <%@include file="/WEB-INF/include/mypageSide.jsp" %>
  <section class="main">
    <!-- UserVo(userid=BO112, userpw=null, username=천보경, gender=여, birth=1990-01-01
    , uphone=010-1234-5678, uaddr=서울시 강남구, email=hong@example.com) -->
    <h5>비밀번호 수정</h5>
    <form action="/User/Info/PwUpdate" method="POST">
    <input type="hidden" name="userid" value="${ userid }"/>
    <table class="table">
      <tr>
        <td>기존 비밀번호</td>
        <td><input type="password" id="oldPw"></td>
      </tr>
      <tr>
        <td>변경할 비밀번호</td>
        <td><input type="password" name="userpw" id="newPw"></td>
      </tr>
      <tr>
        <td>변경할 비밀번호 확인</td>
        <td><input type="password" id="pwCheck"></td>
      </tr>
    </table>
    <input type="button" value="수정" class="btn btn-warning" id="updateBtn">
    </form>
  </section>
</main>
<script>
  const updateBtn = document.querySelector('#updateBtn');
  updateBtn.addEventListener('click', function(e){
	  e.preventDefault();
	  if(document.querySelector('#oldPw').value==""){
		  alert("비밀번호를 입력해주세요.");
		  document.querySelector('#oldPw').focus();
	  }
	  else if(document.querySelector('#oldPw').value!="${userpw}"){
		  alert("비밀번호가 맞지 않습니다.");
		  document.querySelector('#oldPw').focus();
	  }
	  else if(document.querySelector('#newPw').value==""){
		  alert("변경할 비밀번호를 입력해주세요.");
		  document.querySelector('#newPw').focus();
	  }
	  else if(document.querySelector('#newPw').value!=document.querySelector('#pwCheck').value){
		  alert("비밀번호를 잘못입력하였습니다.");
		  document.querySelector('#pwCheck').focus();
	  }
	  else{
	    alert("비밀번호 수정이 완료되었습니다.");
	    const form = document.querySelector('form');
	    form.submit();
	  }
  })
</script>
</body>
</html>
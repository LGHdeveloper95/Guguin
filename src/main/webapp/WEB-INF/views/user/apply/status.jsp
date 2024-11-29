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
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
  <%@include file="/WEB-INF/include/mypageSide.jsp" %>
  <section class="main">
    <div id="passRadio">
      <label class="custom-radio passCheck">
        <input type="radio" name="selResume" value="3" class="navi-radio">
        <span class="checkmark"></span>
        전체
      </label>
      <label class="custom-radio passCheck">
        <input type="radio" name="selResume" value="1" class="navi-radio">
        <span class="checkmark"></span>
        합격
      </label>
      <label class="custom-radio passCheck">
        <input type="radio" name="selResume" value="2" class="navi-radio">
        <span class="checkmark"></span>
        불합격
      </label>
      <label class="custom-radio passCheck">
        <input type="radio" name="selResume" value="0" class="navi-radio">
        <span class="checkmark"></span>
        심사중
      </label>
    </div>
    <table class="table table-custom" id="applyList">
      <thead>
        <tr>
          <th>순번</th>
          <th>이력서 제목</th>
          <th>지원한 공고</th>
          <th>회사명</th>
          <th>제출날짜</th>
          <th>합격여부</th>
        </tr>
      </thead>
      <tbody id="applyListView">
        <c:if test="${ not empty list }">
          <c:forEach items="${ list }" var="apply" varStatus="status">
            <tr>
              <td>${ status.index +1 }</td>
              <td><a href="/user/apply/view/${ apply.sendnum }">${ apply.restitle }</a></td>
              <td><a href="/post/view/${ apply.recnum }">${ apply.rectitle }</a></td>
              <td><a href="#">${ apply.comname }</a></td>
              <td>${ apply.reg_date }</td>
              <c:choose>
                <c:when test="${ apply.pass_code != null && apply.pass_code == 1 }">
                  <td class="green" id="pass1">합격</td>
                </c:when>
                <c:when test="${ apply.pass_code != null && apply.pass_code == 2 }">
                  <td class="red" id="pass0">불합격</td>
                </c:when>
                <c:when test="${ apply.pass_code == null || apply.pass_code == 0}">
                  <td class="gray" id="hold">심사중</td>
                </c:when>
              </c:choose>
            </tr>
          </c:forEach>
        </c:if>
        <c:if test="${ empty list }">
          <tr><td colspan="6">제출된 이력서가 없어요!🥲</td></tr>
        </c:if>
      </tbody>
    </table>
  </section>
</main>
<script>
  function filter(pass_code, callback){
	  $.ajax({
		  url: "/user/apply/filter/"+pass_code,
		  type: "GET",
		  success: (filterList) =>{
			  let html = "";
			  if (filterList && filterList.length > 0) {
	                filterList.forEach((apply, index) => {
	                	console.log(apply);
	                    html += '<tr>'+
	                        '<td>'+(index+1)+'</td>'+
	                        '<td><a href="/user/apply/'+apply.sendnum+'">'+apply.restitle+'</a></td>'+
	                        '<td><a href="/post/view/'+apply.recnum+'">'+apply.rectitle+'</a></td>'+
	                        '<td><a href="#">'+apply.comname+'</a></td>'+
	                        '<td>'+apply.reg_date+'</td>';

	                    if (apply.pass_code !== null) {
	                        if (apply.pass_code == 1) { html += '<td class="green" id="pass1">합격</td>'; }
	                        else if (apply.pass_code == 0) { html += '<td class="red" id="pass0">불합격</td>'; }
	                    } else { html += '<td class="gray" id="hold">심사중</td>'; }
	                    html += '</tr>';
	                });
	            }
			  else if(pass_code == '3'){ html = "<tr><td colspan='6'>제출된 이력서가 없어요!🥲</td></tr>"; }
			  else if(pass_code == '1'){ html = "<tr><td colspan='6'>합격된 이력서가 없어요!🥲</td></tr>"; }
			  else if(pass_code == '2'){ html = "<tr><td colspan='6'>불합격된 이력서가 없어요!😄</td></tr>"; }
			  else{ html = "<tr><td colspan='6'>심사중인 이력서가 없어요!🥲</td></tr>"; }
			  callback(html);
		  },
		  error: (error) =>{
			  console.log(error);
		  }
	  })
  }
  
  const passRadio = document.querySelector('#passRadio');
  passRadio.addEventListener('click', function(event){
	  let pass_code = event.target.value;
	  console.log(pass_code);
	  if (!pass_code) return;
	  const applyListView = document.querySelector('#applyListView');
	  let html = filter(pass_code, (html)=>{
		  applyListView.innerHTML = html;
	  });
  })
  
  
</script>
<%@include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
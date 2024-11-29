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
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<main>
   <div id="listtable">
      <form action="/user/apply" id="resumeForm" method="post">
       		<input type="hidden" name="recnum" value="${recnum}"/>
        <table>
          <thead>
            <tr>
              <td>제목</td>
              <td>날짜</td>
            </tr>
          </thead>
          <tbody>
          <c:forEach items="${resumeList}" var="resume">
            <tr>
              <td>
                <label>
                  <input type="radio" name="resume" value="${resume.resnum}">&nbsp;${resume.restitle}
                </label>
              </td>
              <td>${resume.reg_date}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
        <input type="submit"  value="제출하기">
      </form>
    </div>
</main>
<script>
  const resumeFormEl = document.querySelector('#resumeForm');
  resumeFormEl.addEventListener('submit', function(e){
	  e.preventDefault();
	  const recnum = '${recnum}';
	  const comid = '${comid}';
	  let resumeCheck = document.querySelector('input[name="resume"]:checked')
	  console.log(resumeCheck);
	  fetch('/user/apply', {
		  method: 'POST',
		  headers: {
              'Content-type': 'application/json; charset=UTF-8',
          },
		  body: JSON.stringify({
			  resnum: resumeCheck.value,
			  recnum: recnum,
			  comid: comid
		  })
	  })
	  .then(response => response.json())
	  .then(data => {
		  console.log(data)
		  alert('이력서 제출이 완료되었습니다.')
		  self.close();
		})
	  .catch(error => console.error('Error:', error));
  })
</script>
</body>
</html>
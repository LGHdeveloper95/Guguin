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
  width: 80%;
  margin: 0 auto;
}
.bigDiv {
  width: 90%;
  background-color: #f9f9f9; /* 연한 회색 배경 */
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
  padding: 50px 50px 15px;
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
  margin: 20px auto;
}
a { color: black; text-decoration: none; }
table{ text-align: center; }
 /* 아이디별  테마 변경 */
 <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
.subTitle td:first-of-type, .subTitle td:nth-of-type(3){ background-color: #FAD673; }
.title td{ background-color: #FAD673; }
</c:if>/* 비로그인 상태 */
<c:if test="${not empty sessionScope.userid}">
.subTitle td:first-of-type, .subTitle td:nth-of-type(3){ background-color: #FAD673; }
.title td{ background-color: #FAD673; }
</c:if>/* 개인회원 */
<c:if test="${not empty sessionScope.comid}">
.subTitle td:first-of-type, .subTitle td:nth-of-type(3){ background-color: #66DD7E; }
.title td{ background-color: #66DD7E; }
</c:if> /* 기업회원 */
input[type="text"]{
  width: 100%;
  border: 2px solid gray;
  border-radius: 5px;
}
textarea {
  width: 100%;
  resize: none;   /* 크기 조정 불가능 */
}
.table-hover.customTable{
  text-align: left;
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <main>
  <div class="bigDiv">
  <span class="backBtn btn customBtn">이전</span>
  <form action="http://192.168.0.214:9090/Community/Update" method="POST" enctype="multipart/form-data">
  <input type="hidden" name="conum" value="${ comm.conum }"/>
  <table class="table customTable">
    <tr class="subTitle">
      <td>제목</td>
      <td><input type="text" name="not_title" value="${ comm.not_title }"></td>
      <td>조회수</td>
      <td>${ comm.views }</td>
    </tr>
    <tr class="subTitle">
      <td>작성자</td>
      <c:if test="${ not empty comm.userid }"><td>${ comm.userid }</td></c:if>
      <c:if test="${ not empty comm.comid }"><td>${ comm.comid }</td></c:if>
      <td>작성일</td>
      <td style="max-width: 70px;">${ comm.hiredate }</td>
    </tr>
    <tr class="subTitle">
      <td colspan="4">내용</td>
    </tr>
    <tr><td colspan="4"><textarea name="not_content" rows="10" cols="100">${ comm.not_content }</textarea></td></tr>
  </table>
  <table class="fileList">
    <c:forEach items="${ files }" var="file" varStatus="i">
      <tr>
        <td>${ i.index+1 }
           <a class="fileDown" href="http://192.168.0.214:9090/fileDownload/${ file.finum }">${ file.fileName }</a>
           <span class="fileDel" id="${ file.finum }">X</span>
        </td>
      </tr>
    </c:forEach>
  </table>
  <table class="table table-hover customTable">
    <tr><td colspan="2"><input type="file" class="fileInput" name="uploadFile"></td></tr>
    <tr id="fileTr"><td><button class="fileAdd btn customBtn">파일추가</button></td></tr>
  </table>
  <button class="btn customBtn" id="submit">수정</button>
  </form>
  </div>
  </main>
  <%@include file="/WEB-INF/include/footer.jsp" %>
  <script>
  //파일 삭제--------------------------------------
  const fileList = document.querySelector('.fileList');
  fileList.addEventListener('click', function(e){
	  console.log(e.target);
	  let delFinum = e.target;
	  $.ajax({
		    url: "/community/fileDel/" + delFinum.id,  // URL에 delFinum 값을 추가
		    method: "GET",                        // HTTP 요청 방식 (GET)
		    success: function(response) {         // 성공 시 호출되는 함수
		        alert(response);                  // 서버 응답을 alert로 표시
		        console.log(delFinum.parentNode)
		        delFinum.parentNode.remove();
		    },
		    error: function(xhr, status, error) {  // 실패 시 호출되는 함수
		        console.log('오류 발생: ' + error);      // 오류 메시지를 alert로 표시
		    }
		})
  })
  
  //파일 추가--------------------------------------
  const fileAdd = document.querySelector('.fileAdd');
  fileAdd.addEventListener('click', function(e){
  	e.preventDefault();
  	const fileTr = document.querySelector('#fileTr');
  	let addInput = document.createElement('tr');
  	const html = '<td colspan="2"><input type="file" class="fileInput" name="uploadFile"></td>';
  	addInput.innerHTML = html;
  	console.log(fileTr.parentNode);
  	fileTr.parentNode.insertBefore(addInput, fileTr);
  	})
  	
  	//뒤로가기----------------------------------
    const backBtn = document.querySelector('.backBtn');
    backBtn.addEventListener('click', function(){
    	window.history.back();
    })
    
    //수정버튼---------------------------------
    document.querySelector('#submit').addEventListener('click',function(e){
    	e.preventDefault();
    	
    	const title = document.getElementsByName("not_title")[0];
    	const content = document.getElementsByName("not_content")[0];
    	if(title.value == "" || title.value==null){
    		alert("제목을 입력해주세요");
    		title.focus();
    		return false;
    	}
    	if(content.value == "" || content.value==null){
    		alert("내용을 입력해주세요");
    		content.focus();
    		return false;
    	}
    	
    var formData = new FormData();
    document.querySelectorAll(".fileInput").forEach(fileInput => {
        if (fileInput.files.length > 0) {
            formData.append("uploadFile", fileInput.files[0]);
        }
    })
    formData.append("conum", "${comm.conum}");
    formData.append("not_title", title.value);
    formData.append("not_content", content.value);
    
    fetch("http://192.168.0.214:9090/Community/Update", {
              method: "POST",
              body: formData
          }).then(res=>res.text())
        .then(write=>{
            if(write.error == "Bad Request"){
            	alert("오류 발생")
            	console.log(wirte)
            }
            else{
              alert("수정완료");
              window.location.replace(write);
            }
        }).catch(err=>alert(err));
        return false;
    });
  //색변경-----------------------------------------
    const comid = "${ sessionScope.comid }";
    const changeEl = document.querySelectorAll('.customBtn');
    changeEl.forEach(function(btn){
      if(comid!=null && comid!=""){btn.classList.add('btn-success');}
      else{btn.classList.add('btn-warning');}
    })
  </script>
</body>
</html>
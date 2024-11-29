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
  resize: none;   /* 크기 조정 불가능 */
}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<body>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <main>
  <div class="bigDiv">
  <span class="backBtn btn customBtn">이전</span>
  <c:if test="${ sessionScope.userid == comm.userid || sessionScope.comid == comm.comid}">
    <a href="/community/update/${ comm.conum }" class="btn customBtn">수정</a>
    <span class="delBtn btn customBtn">삭제</span>
  </c:if>
  <table id="commList" class="table customTable">
    <tr class="subTitle">
      <td>제목</td>
      <td class="content">${ comm.not_title }</td>
      <td>조회수</td>
      <td>${ comm.views }</td>
    </tr>
    <tr class="subTitle">
      <td>작성자</td>
      <c:if test="${ not empty comm.userid }"><td class="content">${ comm.userid }</td></c:if>
      <c:if test="${ not empty comm.comid }"><td class="content">${ comm.comid }</td></c:if>
      <td>작성일</td>
      <td style="max-width: 70px;">${ comm.hiredate }</td>
    </tr>
    <tr class="subTitle">
      <td colspan="4">내용</td>
    </tr>
    <tr>
      <td colspan="4" style="height: 300px;" class="content">${ comm.not_content }</td>
    </tr>
  </table>
  <table class="table table-hover customTable">
    <tr class="title">
      <td>순번</td>
      <td>파일명</td>
    </tr>
    <c:if test="${ not empty files }">
    <c:forEach items="${ files }" var="file" varStatus="i">
      <tr>
        <td>${ i.index+1 }</td>
        <td>
         <a class="fileDown" href="http://192.168.0.214:9090/fileDownload/${ file.finum }">${ file.fileName }</a>
        </td>
      </tr>
    </c:forEach>
    </c:if>
    <c:if test="${ empty files }">
      <td>-</td>
      <td>-</td>
    </c:if>
  </table>
  </div>
  <hr>
  <div class="bigDiv">
  <h5>댓글</h5>
  <c:if test="${ not empty sessionScope.userid || not empty sessionScope.comid }">
  <textarea rows="3" cols="50" id="comment" style="margin-left: 20px; width: 100%"></textarea>
  <div style="display: flex;"><span id="commentBtn" class="btn customBtn" style="margin: 0 0 20px auto;">댓글작성</span></div>
  </c:if>
  <table class="table table-hover customTable">
    <c:if test="${ not empty coment }">
      <c:forEach items="${ coment }" var="co" varStatus="i">
      <tr>
        <td>
          ${ i.index+1 }
        </td>
        <td class="commentContent">${ co.c_comment }</td>
        <c:if test="${ not empty co.userid }">
           <td class="who" id="${ co.userid }">
             <div class="btn-group dropend">
              <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                ${ co.userid }
              </button>
              <ul class="dropdown-menu">
                <li><a href="/note/write?receiveUser=${ co.userid }">쪽지보내기</a></li>
              </ul>
             </div>
           </td>
        </c:if>
        <c:if test="${ not empty co.comid }">
         <td class="who" id="${ co.comid }">
          <div class="btn-group dropend">
              <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                ${ co.comid }
              </button>
              <ul class="dropdown-menu">
                <li><a href="/note/write?receiveCom=${ co.comid }">쪽지보내기</a></li>
              </ul>
             </div>
          </td>
        </c:if>
        <td>
          ${ co.reg_date }
        </td>
        <c:if test="${ sessionScope.userid == co.userid || sessionScope.comid == co.comid }">
          <td class="commentUpdateBtn btn customBtn" id="${ co.renum }">수정</td>
          <td class="commentDelBtn btn customBtn"  id="${ co.renum }">삭제</td>
        </c:if>
      </tr>
    </c:forEach>
    </c:if>
    <c:if test="${ empty coment }">
      <tr><td>댓글이 없어요🥲</td></tr>
    </c:if>
  </table>
  </div>
  </main>
  <%@include file="/WEB-INF/include/footer.jsp" %>
  <script>
    //뒤로가기-----------------------------------------------------
    const backBtn = document.querySelector('.backBtn');
    backBtn.addEventListener('click', function(){
    	window.history.back();
    })
    
    //file 다운로드-------------------------------------------------
    const fileDown = document.querySelector('.fileDown');
    if(fileDown){
    fileDown.addEventListener('click', function(e){
    	e.preventDefault();
    	let fileName = "guguin_"+e.target.innerHTML;
    	let url = e.target.href;
    	fetch(url)
    	.then(response =>{
    		if(!response.ok){
    			alert('파일 다운로드 실패');
    		}
    		return response.blob(); //bolob: 파일 데이터를 다룰수있게 해줌
    	})
    	.then(blob=>{
    		console.log(blob);
    		//파일다운로드 태그 생성(실제 html에 입력x)
    		const downLink = document.createElement('a');
    		downLink.href=URL.createObjectURL(blob);
    		downLink.download = fileName;
    		downLink.click();
    	})
    })
    }
    
    //글 삭제---------------------------------------------
    const delBtn = document.querySelector('.delBtn');
    if(delBtn){
    delBtn.addEventListener('click', function(){
    	let result = confirm("정말 삭제하시겠습니까?");
    	if(!result){
    		return false;	
    	}
    	else{
    		const conum = "${comm.conum}";
    		window.location.href='/community/del/'+conum;
    	}
    })
    }
    
    //댓글 작성-------------------------------------------
    const commentBtn = document.querySelector('#commentBtn');
    if(commentBtn){
    commentBtn.addEventListener('click',function(){
    	let comment = document.querySelector('#comment');
    	if(comment.value == ""){
    		alert('댓글 입력 후 작성해주세요');
    		comment.focus();
    	}
    	else{
    		let userid = null;
    		let comid = null;
    		if(${sessionScope.userid != null && sessionScope.userid !=""}){
				userid = "${sessionScope.userid}";
			}
			if(${sessionScope.comid != null && sessionScope.comid !=""}){
				comid = "${sessionScope.comid}";
			}
    		fetch('/community/comment/insert',{
    			method: "POST",
    			headers: {
    				'Content-type': 'application/json; charset=UTF-8'
    			},
    			body: JSON.stringify({
    				conum: "${comm.conum}",
    				userid: userid !== "null" ? userid : undefined,
    				comid: comid !== "null" ? comid : undefined, 
    				c_coment: comment.value
    			})
    		}).then(result => {
    			if(result.ok){
    				window.location.reload();
    			}
    		})
    		.catch(err => console.log(err))
    		return false;
    	}
    })
    }
    
    //댓글 수정------------------------------------------------------------
    const commentUpdateBtn = document.querySelectorAll('.commentUpdateBtn')
    console.log(commentUpdateBtn);
    if(commentUpdateBtn != null){
    	commentUpdateBtn.forEach(function(btn) {
    		btn.addEventListener('click', function(e){
    			console.log(e.target.parentNode);
    			let pNodeEl = e.target.parentNode;
    			let ppNodeEl = e.target.parentNode.parentNode;
    			pNodeEl.innerHTML += '<tr><td class="newContentBtn btn customBtn">수정</td></tr>'
    			
    			let comInput = pNodeEl.querySelector('.commentContent');
    			let oldContent = comInput.innerHTML.replaceAll("<br>","\n");
    			let conum = "${ comm.conum }"
    			let renum = e.target.id;
    			console.log(comInput.nextElementSibling);
    			console.log(comInput.nextElementSibling.nextElementSibling);
    			comInput.nextElementSibling.nextElementSibling.remove();
    			comInput.nextElementSibling.remove();
    			comInput.innerHTML = '<td colspan="2" class="commentContent"><form id="commentSubmit" action="/community/comment/update" method="POST"><input type="hidden" name="conum" value="'+conum+'"><input type="hidden" name="renum" value="'+renum+'"><textarea style="width: 100%;" name="c_comment">'+oldContent+'</textarea></td>';
    			
    			ppNodeEl.querySelectorAll('.commentDelBtn').forEach(function(delBtn){
    				delBtn.remove();
    			})
    			ppNodeEl.querySelectorAll('.commentUpdateBtn').forEach(function(upBtn){
    				upBtn.remove();
    			})
    			
    			pNodeEl.querySelector('.newContentBtn').addEventListener('click', function(){
    				document.querySelector('#commentSubmit').submit();
    				})
    			})
    		})
    }
    
    //댓글 삭제=------------------------------------------------------------
    const commentDelBtn = document.querySelectorAll('.commentDelBtn')
    if(commentDelBtn != null){
    	commentDelBtn.forEach(function(btn){
    		btn.addEventListener('click', function(e){
    	    	let renum = e.target.id;
    	    	fetch('/community/comment/del/'+renum)
    	    	.then(result => {
    	    		console.log(result);
    	    		window.location.reload();
    	    	}).catch(err => console.log(err))
    	    })
    	})
    }
    
    //색변경-----------------------------------------
    const comid = "${ sessionScope.comid }";
    const changeEl = document.querySelectorAll('.customBtn');
    changeEl.forEach(function(btn){
      if(comid!=null && comid!=""){btn.classList.add('btn-outline-success');}
      else{btn.classList.add('btn-outline-warning');}
    })
  </script>
</body>
</html>
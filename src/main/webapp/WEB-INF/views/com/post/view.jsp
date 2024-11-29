<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사람과 기업을 연결하는 구구인</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico"/>
    
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    #listtable {
        margin: 20px auto;
        border: 1px solid #ccc;
        border-radius: 8px;
        max-width: 100%; /* 최대 너비 설정 */
        flex: 1; /* Flex-grow로 크기 조정 */
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px auto;
        border: 1px solid #ccc;
        border-radius: 8px;
    }

    thead {
        background-color: #f2f2f2;
    }

    thead td {
        font-weight: bold;
        padding: 12px;
        text-align: left;
        border-bottom: 2px solid #ccc;
    }

    tbody tr {
        transition: background-color 0.3s;
    }

    tbody td {
        padding: 12px;
        border-bottom: 1px solid #ccc;
    }

    a {
        text-decoration: none;
        color: #333;
    }

    a:hover {
        text-decoration: underline;
    }

    main {
        width: 70%;
        display: flex; /* Flexbox 사용 */
        align-items: flex-start; /* 위쪽 정렬 */
        margin: 20px auto; /* 메인 마진 추가 */
    }

    main > div {
        width: 100%;
    }

    button {
        padding: 3px 10px;
    }


    .content {
        height: 500px;
        vertical-align: top;
    }

    .btn {
        margin-left: 10px;
    }

    .radio {
        opacity: 0;
    }

    .radio + label {
        padding: 5px 10px;
        border: 1px solid #ccc;
        border-radius: 3px;
    }

    .radio + label:hover {
        background: #cccccc;
    }

    input[type=radio]:checked + label {
        background: #AAAAAA;
        color: white;
    }

    input[name=rectitle],
    input[name=subtitle] {
        width: 400px;
    }

    .clicked {
        background: #AAAAAA;
        color: white;
    }
    .clicked_skill:hover {
        background: #cccccc;
        opacity: 0.75;
    }

    .red {
        color: red;
    }
    .table{
        border: 1px solid #dee2e6;
        width: 100%;
    }
    /* 제목 셀의 첫 번째 항목에 스타일 적용 */
    .subtitle td:first-of-type {
        background-color: rgb(253, 241, 211);
        padding: 5px;  /* 패딩 줄이기 */
    }
    .table th, .table td {
        padding: 10px;             /* 셀 안쪽 패딩을 설정하여 내용이 겹치지 않도록 */
        text-align: center;        /* 텍스트 중앙 정렬 */
        border: 1px solid rgb(255, 194, 62); /* 셀 테두리 색상 설정 */
    }

    .shadow{ box-shadow:  5px 5px 15px 5px rgba(0, 0, 0, 0.3); }
    .red { color: red; }
    .btn { background-color: white; color: rgb(83, 83, 83); }
    /* 아이디별  테마 변경 */
    <c:if test="${(empty sessionScope.userid && empty sessionScope.comid)||not empty sessionScope.userid}">
        thead{ background-color: #FAD673; }
        .subtitle td:first-of-type {
        background-color: rgb(253, 241, 211);
        padding: 5px;  /* 패딩 줄이기 */
        }
    </c:if>/* 비로그인 상태 ,개인 로그인 상태 */
    <c:if test="${not empty sessionScope.comid}">
        thead { background-color: #66DD7E; /* 헤더의 배경색 설정 */ }
        .subtitle td:first-of-type{ background-color: #afe8bb; padding: 5px;   }
    </c:if>
        </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
    <div>
        <table>
            <thead>
            <tr>
                <td colspan="2">공고 제목 : ${ post.rectitle }</td>
                <td>
                    <a class="btn" href="/com-info">목록</a>
                    <c:if test="${sessionScope.comid eq post.comid}">
                        <a class="btn" href="/post/update/${post.recnum}">수정 </a>
                        <a class="btn" id ="delete" href="/post/delete/${post.recnum}" onclick="return false">삭제 </a>
                    </c:if>
                    <c:if test="${ not empty sessionScope.userid }">
                      <a class="btn" href="/user/apply/${post.recnum}" id="apply" value="${ sessionScope.userid }">지원하기</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.comid }">
                        <script>
                            document.querySelectorAll('.btn').forEach(function (btn){
                                btn.classList.add('btn-success')
                            })
                        </script>
                    </c:if>
                    <c:if test="${empty sessionScope.comid }">
                        <script>
                            document.querySelectorAll('.btn').forEach(function (btn){
                                btn.classList.add('btn-outline-warning')
                            })
                        </script>
                    </c:if>

                </td>
            </tr>
            </thead>
            <tr class="subtitle">
                <td>부제</td>
                <td colspan="2">${post.subtitle}</td>
            </tr>
            <tr  class="subtitle">
                <td> 날짜</td>
                <td> 채용 시작일 ${post.start_date}</td>
                <td> 마감일 ${post.deadline}</td>
            </tr>
            <tr class="subtitle">
                <td>기업 이름</td>
                <td>${ com.comname } </td>
            </tr>
            <tr class="subtitle">
                <td>대표자</td>
                <td>${com.boss}</td>
            </tr>
            <tr class="subtitle">
                <td>회사 연락처</td>
                <td>${ com.cphone }</td>
            </tr>
            <tr class="subtitle">
                <td>주소</td>
                <td colspan="2">${ com.caddr }</td>
            </tr>
            <tr>
                <td colspan="3"> </td>
            </tr>
            <tr class="subtitle">
                <td>우대 학력</td>
                <td colspan="2">${ edu.edu_name }</td>
            </tr>
            <tr class="subtitle">
                <td>우대 경력</td>
                <td colspan="2">${ career.career_name }</td>
            </tr>
            <tr class="subtitle">
                <td>우대 자격증</td>
                <c:if test="${ post.license!= null }">
                    <td colspan="2">
                        ${post.license}
                    </td>
                </c:if>
                <c:if test="${post.license eq null}">
                    <td colspan="2"> 없음</td>
                </c:if>
            </tr>
            <tr class="subtitle">
                <td>우대 기술</td>
                <td colspan="2">
                    <c:forEach items="${ skillList }" var="skill">
                        ${ skill } <c:if test="!${status.last}"> ,</c:if>
                    </c:forEach>
                </td>
            </tr>
            <tr class="subtitle">
                <td>근무 지역</td>
                <td colspan="2">
                    <div>${region.sido} ${region.gugun}</div>
                </td>
            </tr>
        </table>
        <!-- 자기소개서--------------------------------------------------- -->
        <table>
            <thead>
            <tr>
                <td colspan="3">회사 소개</td>
            </tr>
            </thead>
            <tr class="content">
                <td colspan="3">${ post.gcontent }</td>
            </tr>
        </table>
    </div>
</main>
<script>
  if(${sessionScope.comid eq post.comid}){
    document.getElementById("delete").onclick=()=>{
        if(confirm("정말 삭제하시겠습니까?")){
            fetch(document.getElementById("delete").href,{
                method:"DELETE"
                ,headers:{
                    'Content-type': 'application/json; charset=UTF-8'
                }
            }).then(response=> {
                    alert("삭제 되었습니다.");
                    window.location.replace("/post");
                }
            ).catch(err=>alert("삭제 실패")+err)
        }
        return false;
    }
  }
  const userid = "${ sessionScope.userid }";
  const recnum = "${ post.recnum }";
  const comid = "${ post.comid }";
  if(userid){
	  const applyBtn = document.querySelector('#apply');
	  applyBtn.addEventListener('click', function(e){
		  e.preventDefault();
		  fetch("/user/apply/check/"+recnum,{
			  method: "GET"
		  })
		  .then(applyCheck => applyCheck.text())
		  .then(cnt => {
			  if(cnt > 0){
				  alert('이미 지원한 공고입니다.');
			  }
			  else{
				  window.open('/user/resumeList/'+recnum+'/'+comid, 'ResumeList Popup', 'width=550,height=300');
			  }
		  })
	  })
  }
</script>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>사람과 기업을 연결하는 구구인</title>
<link rel="icon" type="image/png" href="/img/favicon.ico">
<style>
/* 전체 레이아웃 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	height: 100vh;
}

#box {
	display: flex;
	margin-top: 25px;
}

#left_menubar {
	flex: 0 0 20%;
	background-color: #f4f4f4;
	border-right: 1px solid #ddd;
	padding: 20px;
	box-sizing: border-box;
}

#left_menubar ul {
	list-style: none;
	padding-top: 20;
	margin: 0;
}

#left_menubar .menu_nav button {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	border: none;
	background-color: #66DD7E;
	border: 1px solid #ddd;
	cursor: pointer;
	text-align: left;
	font-size: 16px;
	border-radius: 5px;
}

#left_menubar .menu_nav button.active {
	background-color: #69C97C;
	color: #fff;
	font-weight: bold;
}

#my_content {
	flex: 1;
	padding: 20px;
	box-sizing: border-box;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
}

#my_content>div {
	display: none;
}

#my_content>div.active {
	display: block;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
}

table th, table td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

table thead, tfoot {
	background-color: #66DD7E;
}

/* 맨 위로 가기 버튼 */
#my_remote {
	position: fixed;
	right: 20px;
	bottom: 300px;
}

#my_remote #top_button {
	width: 50px;
	height: 50px;
	background-color: #69C97C;
	color: white;
	text-decoration: none;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 14px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

#my_remote #top_button:hover {
	background-color: #0056b3;
}

.red {
	color: rgb(200, 0, 0);
}
/* 테이블과 버튼 스타일링 */
.filter-button {
	padding: 10px 15px;
	margin: 5px;
	background-color: #f4f4f4;
	border: 1px solid #ddd;
	cursor: pointer;
	border-radius: 5px;
}

.filter-button.active {
	background-color: #69C97C;
	color: white;
}

.pass-table {
	display: none;
	margin-top: 20px;
}

.pass-table.active {
	display: table;
}

#deleteBtn {
	padding: 7px 10px;
	margin: 5px;
	background-color: #69C97C;
	border: 1px solid #ddd;
	cursor: pointer;
	border-radius: 5px;
}
</style>
</head>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div id="box">
		<div id="left_menubar">
			<ul>
				<li class="menu_nav"><button class="active"
						data-target="swap_recruit_board">공고관리</button></li>
				<li class="menu_nav"><button data-target="swap_pass_board">입사지원현황</button></li>
				<li class="menu_nav"><button data-target="swap_scrap_board">스크랩
						이력서</button></li>
				<li class="menu_nav"><button data-target="swap_company_info">기업정보
						수정</button></li>
			</ul>
		</div>

		<div id="my_content">
			<div id="swap_recruit_board" class="active">
				<h2>공고관리</h2>
				<p>총 ${count1}건</p>
				<table>
					<colgroup>
						<col width="80%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>공고제목</th>
							<th>등록날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty recList }">
							<c:forEach items="${ recList }" var="rec">
								<tr>
									<td><a href="/post/view/${rec.recnum}">${ rec.rectitle }</a></td>
									<td>${ rec.reg_date }</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${ empty recList }">
				     작성된 이력서가 없습니다.
				     </c:if>
					</tbody>
				</table>
			</div>
			<div id="swap_pass_board">
				<h2>입사지원현황</h2>
				<h3>총 ${count}건</h3>
				<div>
					<!-- 1차와 2차 버튼 -->
					<button class="filter-button active" data-target="pass_table_1">1차</button>
					<button class="filter-button" data-target="pass_table_2">2차</button>
				</div>
				<table id="pass_table_1" class="pass-table active">
					<colgroup>
						<col width="20%">
						<col width="55%">
						<col width="10%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th>지원날짜</th>
							<th>이력서 제목</th>
							<th>이름</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty appList }">
							<c:forEach items="${ appList }" var="app">
								<tr>
									<td>${ app.reg_date }</td>
									<td><a href="/user/apply/view/${ app.sendnum }">${ app.restitle}</a></td>
									<td>${ app.username }</td>									
												 <c:choose>
                    <c:when test="${app.pass_code == 0}">
                      <td>
                      <span class="status-review">심사중</span>
                      </td>                    
                    </c:when>
                    <c:when test="${app.pass_code == 1}">
                      <td>
                      <span class="status-pass">1차 합격</span>
                      </td>
                    
					</c:when>
					<c:when test="${app.pass_code == 2}">
					  <td>
					  <span class="status-fail">불합격</span>
					  </td>
                    </c:when>
                    <c:otherwise>
                      <span>상태없음</span>
                    </c:otherwise>
                  </c:choose>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${ empty appList }">
					지원자가 없습니다.
					</c:if>
					</tbody>
				</table>
				<table id="pass_table_2" class="pass-table">
					<colgroup>
						<col width="20%">
						<col width="55%">
						<col width="10%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th>지원날짜</th>
							<th>이력서 제목</th>
							<th>이름</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${ not empty passList }">
					<c:forEach items="${ passList }" var="pass">
						<tr>
							<td>${ pass.reg_date }</td>
							<td><a href="/user/apply/view/${ pass.sendnum }">${ pass.restitle }</a></td>
							<td>${ pass.username }</td>
							 <c:choose>
                    <c:when test="${pass.pass_code == 0}">
                      <td>
                      <span class="status-review">심사중</span>
                      </td>                    
                    </c:when>
                    <c:when test="${pass.pass_code == 1}">
                      <td>
                      <span class="status-pass">1차 합격</span>
                      </td>
                    
					</c:when>
					<c:when test="${pass.pass_code == 2}">
					  <td>
					  <span class="status-fail">불합격</span>
					  </td>
                    </c:when>
                    <c:otherwise>
                      <span>상태없음</span>
                    </c:otherwise>
                  </c:choose>
                
						</tr>
						</c:forEach>
						</c:if>
						<c:if test="${ empty passList }">
						<tr>
						  <th>
						    공고가 읍어요
					  	  </th>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<div id="swap_scrap_board">
				<h2>스크랩 이력서</h2>
				<p>총 ${count2}건</p>
				<div>
					<button id="deleteBtn">삭제</button>
				</div>
				<table>
					<colgroup>
						<col width="5%">
						<col width="65%">
						<col width="15%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th>삭제</th>
							<th>스크랩 제목</th>
							<th>이름</th>
							<th>스크랩 날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty scrList}">
							<c:forEach items="${ scrList }" var="scr">
								<tr>
									<td><input type="checkbox" value="${scr.resnum}" /></td>
									<td><a href="/user/resume/one/view/${ scr.resnum }">${ scr.restitle }</a></td>
									<td>${ scr.username }</td>
									<td>${ scr.scrap_at }</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${ empty scrList }">
							<tr>

								<td colspan="4">등록된 스크랩이 없습니다</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<div id="swap_company_info">
			<div id="passCheck">
				
				<input type="password" id="pass" name="passwd" placeholder="비밀번호 확인"/> 
				<button id="passBtn">확인	</button>
				
			</div>
			<div id="comUpdate" style="display:none;">
			      <form class="updateForm" action="/ComMyPage/Update" method="POST">
            <input type="hidden" name="comid" value="${com.comid}"/>
            <input type="hidden" name="boss" value="${com.boss}"/>
        <table>
            <thead>
            <tr>
                <td colspan="2">내 정보 </td>
                <td>
                    <c:if test="${sessionScope.comid eq com.comid}">
                        <input type="submit" class="btn btn-success" value="수정">
                    </c:if>
                </td>
            </tr>
            </thead>
            <tr>
                <td>기업 이름</td>
                <td>${ com.comname } </td>
            </tr>
            <tr>
                <td>대표자</td>
                <td>${com.boss}</td>
            </tr>
            <tr>
                <td><c class="red">*</c> 회사 연락처 </td>
                <td><input type="text" name="cphone" value="${ com.cphone }"/></td>
            </tr>
            <tr>
                <td><c class="red">*</c> 주소 </td>
                <td><input type="text" name="caddr" value="${ com.caddr }"/></td>
            </tr>
            <tr>
                <td><c class="red">*</c> 이메일 </td>
                <td><input type="email" name="bossemail" value="${ com.bossemail }"/></td>
            </tr>
        </table>
        </form>
			</div>
    
			</div>
		</div>
	</div>
	<div id="my_remote">
		<a href="#" id="top_button">Top</a>
	</div>

	<script>
    // 메뉴 클릭 시 컨텐츠 표시
    document.querySelectorAll('#left_menubar .menu_nav button').forEach(button => {
        button.addEventListener('click', () => {
            // 모든 버튼 비활성화
            document.querySelectorAll('#left_menubar .menu_nav button').forEach(btn => btn.classList.remove('active'));

            // 선택된 버튼 활성화
            button.classList.add('active');

            // 모든 컨텐츠 숨기기
            document.querySelectorAll('#my_content > div').forEach(content => content.classList.remove('active'));

            // 선택된 컨텐츠 보이기
            const target = button.getAttribute('data-target');
            document.getElementById(target).classList.add('active');
            
            
        });
    });
    
    // 버튼 클릭 시 테이블 표시/숨김
    document.querySelectorAll('.filter-button').forEach(button => {
        button.addEventListener('click', () => {
            // 버튼 활성화 상태 변경
            document.querySelectorAll('.filter-button').forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            // 테이블 표시/숨김
            const target = button.getAttribute('data-target');
            document.querySelectorAll('.pass-table').forEach(table => table.classList.remove('active'));
            document.getElementById(target).classList.add('active');
        });
    });

    // 맨 위로 가기 버튼
    document.getElementById('top_button').addEventListener('click', (e) => {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
    
   
    
    document.querySelector('#deleteBtn').addEventListener('click', function () {
        const selectedScraps = [];
        
        // 체크된 체크박스에서 SCNUM 값을 가져옵니다.
        document.querySelectorAll('input[type="checkbox"]:checked').forEach(checkbox => {
            selectedScraps.push(checkbox.value); // SCNUM 값을 배열에 추가
        });

        if (selectedScraps.length > 0) {
            // AJAX 요청으로 삭제 처리
            fetch('/MyPage/Delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(selectedScraps), // 선택된 SCNUM 리스트 전송
            })
            .then(response => {
                if (response.ok) {
                    alert('삭제되었습니다.');
                    // 페이지 새로고침
                    location.reload();
                } else {
                    alert('삭제 중 문제가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('삭제 요청 중 에러가 발생했습니다.');
            });
        } else {
            alert('삭제할 스크랩을 선택하세요.');
        }
    });
    
   document.getElementById('passBtn').addEventListener('click',function(){
	   if(document.getElementById('pass').value=='<c:out value="${com.compw}"/>'){
		   document.getElementById('passCheck') .style.display="none";
		   document.getElementById('comUpdate') .style.display="block";
		   
	   }
	   else{
		   alert("비밀번호 확인해주세요 ")
	   }
	   
   })
       document.querySelector('.updateForm').onsubmit=()=>{
        if($('input[name=cphone]').val()==null||$('input[name=cphone]').val()==""){
            alert("연락처를 입력해주세요.");
            $('input[name=cphone]').focus();
            return false;
        }
        if($('input[name=caddr]').val()==null||$('input[name=caddr]').val()==""){
            alert("주소를 입력해주세요.");
            $('input[name=caddr]').focus();
            return false;
        }
        if($('input[name=bossemail]').val()==null||$('input[name=bossemail]').val()==""){
            alert("이메일을 입력해주세요.");
            $('input[name=bossemail]').focus();
            return false;
        }
        alert("수정 완료.");
      
        	return false;
        
    }
    
</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>

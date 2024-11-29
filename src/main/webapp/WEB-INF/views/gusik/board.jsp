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
	margin-top: 30px;
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
a {
    text-decoration: none;
    color: hotpink;
    
}

.pass_btn {
    display: none;
}
.pass_btn.active {
    display: block;
}
table thead, tfoot {
	background-color: #66DD7E;
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

.gugun-group {
    display: none; /* 기본적으로 숨김 처리 */
}

#gugun_group_all {
    display: block; /* "전국" 그룹만 기본적으로 표시 */
}

li {
  list-style: none;
}

.filter-button.active {
	background-color: #69C97C;
	color: white;
}

.swap-button {
	padding: 10px 15px;
	margin: 5px;
	background-color: #f4f4f4;
	border: 1px solid #ddd;
	cursor: pointer;
	border-radius: 5px;
}

.swap-button.active {
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
.status-review {
    color: orange;
  }
  .status-pass {
    color: green;
    font-weight: bold;
    
  }
  .status-fail {
    color: red;
  }

</style>

</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div id="box">
		<div id="left_menubar">
			<ul>
				<li class="menu_nav"><button class="active" data-target="swap_recruit_board">지역별</button></li>
				<li class="menu_nav"><button data-target="swap_pass_board">직종별</button></li>
			</ul>
		</div>
		<div id="my_content">
		<div id="swap_recruit_board" class="active">
    <h2>지역별</h2>
    
    <div>
        <ul style="display: flex; flex-wrap: wrap; gap: 10px;">
            <!-- Sido 버튼 생성 -->
            <li><button class="swap-button" data-target="pass_table">전국(${count1})건</button></li>
            <c:forEach items="${sidoList}" var="sido" varStatus="status">
                <li>
                    <button class="swap-button" data-target="gugun_group_${sido.sido_code}">${sido.sido}</button>
                </li>
            </c:forEach>
        </ul>
    </div>
    <hr />
    <!-- Gugun 버튼 그룹 생성 -->
    <c:forEach items="${sidoList}" var="sido">
        <div id="gugun_group_${sido.sido_code}" class="gugun-group">
            <ul style="display: flex; gap: 10px; flex-wrap: wrap;">
                <li><button class="filter-button active" data-target="pass_table_${sido.sido_code}_all">전체</button></li>
                <c:forEach items="${gugunList}" var="gugun">
                    <c:if test="${gugun.sido_code == sido.sido_code}">
                        <li>
                            <button class="filter-button" data-target="pass_table_${sido.sido_code}_${gugun.gugun_code}">${gugun.gugun}</button>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
</div>

				<!-- 지역별 버튼 클릭 시 각 구군별 테이블 동적 생성 -->
<c:forEach items="${sidoList}" var="sido">
    <div id="gugun_group_${sido.sido_code}" class="gugun-group">
        <ul style="display: flex; gap: 10px; flex-wrap: wrap;">
            <li><button class="filter-button active" data-target="pass_table_${sido.sido_code}_all">전체</button></li>
            <c:forEach items="${gugunList}" var="gugun">
                <c:if test="${gugun.sido_code == sido.sido_code}">
                    <li>
                        <button class="filter-button" data-target="pass_table_${sido.sido_code}_${gugun.gugun_code}">${gugun.gugun}</button>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
</c:forEach>

<!-- 각 구군별로 테이블 출력 -->
<c:forEach items="${sidoList}" var="sido">
    <c:forEach items="${gugunList}" var="gugun">
        <c:if test="${gugun.sido_code == sido.sido_code}">
            <table id="pass_table_${sido.sido_code}_${gugun.gugun_code}" class="pass-table">
                <thead>
                    <tr>
                        <th>이력서 제목</th>
                        <th>이름</th>
                        <th>날짜</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${gugunMap[gugun.gugun_code]}" var="res">
                <c:if test="${not empty gugunMap[gugun.gugun_code] }">
                        <tr>
                            <td><a href="/user/resume/one/view/${res.resnum}">${res.restitle}</a></td>
                            <td>${res.username}</td>
                            <td>${res.reg_date}</td>
                        </tr>
                    </c:if>
                    </c:forEach>
                    <c:if test="${ empty gugunMap[gugun.gugun_code] }">
                    <tr>
                      <td colspan="3">조회된 이력서가 없습니다.</td>
                    </tr>
                    </c:if>
                </tbody>
            </table>
        </c:if>
    </c:forEach>
</c:forEach>

<!-- 전체 테이블 -->
<c:forEach items="${sidoList}" var="sido">
    <table id="pass_table_${sido.sido_code}_all" class="pass-table">
        <thead>
            <tr>
                <th>이력서 제목</th>
                <th>이름</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody>
            <!-- 해당 시도의 모든 구군의 이력서를 출력 -->
            <c:forEach items="${gugunList}" var="gugun">
                <c:if test="${gugun.sido_code == sido.sido_code}">
                    <c:forEach items="${gugunMap[gugun.gugun_code]}" var="res">
                        <tr>
                            <td><a href="/user/resume/one/view/${res.resnum}">${res.restitle}</a></td>
                            <td>${res.username}</td>
                            <td>${res.reg_date}</td>
                        </tr>
                    </c:forEach>
                </c:if>
            </c:forEach>
            <!-- 구군이 없는 경우 메시지 출력 -->
            <c:if test="${empty gugunMap}">
                <tr>
                    <td colspan="3">조회된 이력서가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</c:forEach>


<!-- 전국 테이블 -->
<table id="pass_table" class="pass-table active">
    <thead>
        <tr>
            <th>이력서 제목</th>
            <th>이름</th>
            <th>날짜</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${resList}" var="res">
        <c:if test="${not empty resList }">
            <tr>
                <td><a href="/user/resume/one/view/${res.resnum}">${res.restitle}</a></td>
                <td>${res.username}</td>
                <td>${res.reg_date}</td>
            </tr>
            </c:if>
        </c:forEach>
        <c:if test="${ empty resList }">
        <tr>
        <td>조회된 이력서가 없습니다.</td>
        </tr>
        </c:if>
    </tbody>
</table>
			</div>
			<div id="swap_pass_board">
			</div>
			<div id="swap_scrap_board">
		    </div>
			<div id="swap_company_info">							
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
    
    document.addEventListener("DOMContentLoaded", () => {
        // 전국 버튼 클릭 시
        document.querySelector('.swap-button[data-target="pass_table"]').addEventListener('click', () => {
            // 모든 테이블 숨기기
            document.querySelectorAll('.pass-table').forEach(table => {
                table.classList.remove('active');
            });

            // '전국' 테이블만 활성화
            const allTable = document.getElementById('pass_table');
            if (allTable) {
                allTable.classList.add('active');
            }

            // 구군 그룹 숨기기
            document.querySelectorAll('.gugun-group').forEach(group => {
                group.style.display = 'none';
            });

            // 전국 버튼 활성화
            document.querySelectorAll('.swap-button').forEach(btn => btn.classList.remove('active'));
            const allButton = document.querySelector('.swap-button[data-target="pass_table"]');
            if (allButton) {
                allButton.classList.add('active');
            }

            // 시도 버튼 비활성화
            document.querySelectorAll('.swap-button[data-target^="gugun_group_"]').forEach(btn => {
                btn.classList.remove('active');
            });
        });

        // Sido 버튼 클릭 시 Gugun 버튼 그룹 표시/숨기기
        document.querySelectorAll('.swap-button[data-target^="gugun_group_"]').forEach(button => {
            button.addEventListener('click', () => {
                // Sido 버튼 활성화
                document.querySelectorAll('.swap-button[data-target^="gugun_group_"]').forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');

                // Gugun 버튼 그룹 표시/숨김
                const target = button.getAttribute('data-target');
                document.querySelectorAll('.gugun-group').forEach(group => group.style.display = 'none');
                if (document.getElementById(target)) {
                    document.getElementById(target).style.display = 'block';
                }

                // 전국 테이블을 숨기기
                document.querySelectorAll('.pass-table').forEach(table => table.classList.remove('active'));
                // 해당 시도 테이블을 활성화
                const gugunTable = document.getElementById(`pass_table_${target.split('_')[2]}`);
                if (gugunTable) {
                    gugunTable.classList.add('active');
                }

                // 전국 버튼 비활성화
                document.querySelectorAll('.swap-button[data-target="pass_table"]').forEach(btn => {
                    btn.classList.remove('active');
                });
            });
        });

        // Gugun 버튼 클릭 시 테이블 표시/숨기기
        document.querySelectorAll('.filter-button').forEach(button => {
            button.addEventListener('click', () => {
                // Gugun 버튼 활성화
                document.querySelectorAll('.filter-button').forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');

                // 해당 구군 테이블 표시
                const target = button.getAttribute('data-target');
                document.querySelectorAll('.pass-table').forEach(table => table.classList.remove('active'));
                document.getElementById(target).classList.add('active');
            });
        });
    });
    
    // 맨 위로 가기 버튼
    document.getElementById('top_button').addEventListener('click', (e) => {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
    
   
    
   
    
</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>

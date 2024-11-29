<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        /* 전체 여백 제거 */
        html, body {
            margin: 0;s
            padding: 0;
            margin-top:  65px;
            box-sizing: border-box; /* 모든 요소의 크기 계산 방식을 보더와 패딩 포함 */
         }
/* 헤더 스타일 */
         #header {
        
            background-color: #FAD673; /* 헤더 배경색 */
            height: 39px; /* 헤더 높이 */
            width:100%;
            display: flex; /* 요소들을 가로로 정렬 */
            align-items: center; /* 요소를 세로 가운데 정렬 */
            padding: 0 20px; /* 좌우 패딩 */
            box-sizing: border-box; /* 패딩 포함한 크기 계산 */
            position: fixed; /* 화면에 고정 */
            top: 0; /* 화면의 맨 위에 위치 */
            z-index: 9999; /* 모든 요소들보다 가장 앞에 위치하게 */ 
         }
         
		          /* 조건별 헤더 배경색 */
		    <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
		    #header {
		        background-color: #FAD673; /* 비로그인 상태 */
		    }
		    </c:if>
		    <c:if test="${not empty sessionScope.userid}">
		    #header {
		        background-color: #FAD673; /* 개인회원 */
		    }
		    </c:if>
		    <c:if test="${not empty sessionScope.comid}">
		    #header {
		        background-color: #66DD7E; /* 기업회원 */
		    }
		    </c:if>

        /* 로고 컨테이너 스타일 */
        #header .logo {
            display: flex; /* 로고 정렬 */
            align-items: center; /* 로고를 세로 가운데 정렬 */
            justify-content: flex-start; /* 로고를 왼쪽 정렬 */
            margin-right: 20px; /* 로고와 네비게이션 사이 간격 */
            flex-shrink: 0; /* 로고 크기 고정 */
        }

        /* 로고 이미지 스타일 */
        #header .logo img {
           
            height: 33px; /* 로고 높이 */
        }

        /* 네비게이션 컨테이너 스타일 */
        .nav-container {
            display: flex; /* 네비게이션을 가로로 정렬 */
            align-items: center; /* 요소를 세로 가운데 정렬 */
            flex-grow: 1; /* 남은 공간을 차지 */
        }

        /* 네비게이션 메뉴 스타일 */
        .nav {
            display: flex; /* 메뉴를 가로로 정렬 */
            align-items: center; /* 세로 가운데 정렬 */
        }

        .nav a {
            text-decoration: none; /* 링크의 밑줄 제거 */
            color: #666; /* 기본 글자 색상 */
            font-size: 16px; /* 글자 크기 */
            font-weight: bold; /* 글자 두께 */
            margin: 0 25px; /* 각 메뉴 간 간격 */
        }

        .nav a:hover {
            color: black; /* 마우스 오버 시 글자 색상 */
        }

        /* 햄버거 버튼 스타일 */
        .dropdown {
            position: relative; /* 드롭다운 메뉴 위치 설정 */
        }

        .dropdown .hamburger {
            display: flex; /* 햄버거 버튼 정렬 */
            flex-direction: column; /* 버튼을 세로로 배치 */
            justify-content: space-between; /* 각 막대 간격 균등 */
            width: 18px; /* 버튼 너비 */
            height: 14px; /* 버튼 높이 */
            cursor: pointer; /* 커서 모양 변경 */
        }

        /* 햄버거 버튼 막대 스타일 */
        .dropdown .hamburger span {
            display: block; /* 블록 요소 */
            height: 2px; /* 막대 두께 */
            width: 18px; /* 막대 너비 */
            background-color: black; /* 막대 색상 */
            border-radius: 1px; /* 모서리 둥글게 */
        }

        /* 드롭다운 메뉴 스타일 */
        .dropdown-menu {
            display: none; /* 기본적으로 숨김 */
            position: absolute; /* 부모 기준 위치 */
            top: 25px; /* 헤더 바로 아래 위치 */
            left: 0; /* 왼쪽 정렬 */
            background-color: #FAD673; /* 드롭다운 배경색 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15); /* 그림자 */
            border: 2px solid #EFC03E; /* 테두리 색상 및 두께 */
            padding: 10px 15px; /* 내부 패딩 */
            list-style: none; /* 리스트 스타일 제거 */
            margin: 0; /* 기본 여백 제거 */
            border-radius: 4px; /* 모서리 둥글게 */
            z-index: 1000; /* 상단 표시 */
            min-width: 630px; /* 최소 너비 */
        }

        /* 드롭다운 활성화 클래스 */
        .dropdown-menu.active {
            display: block; /* 활성화 시 드롭다운 표시 */
        }

        .dropdown-menu li {
            padding: 8px 10px; /* 리스트 항목 간격 */
            white-space: nowrap; /* 텍스트 줄바꿈 방지 */
            cursor: pointer; /* 커서 모양 변경 */
        }

        .dropdown-menu li:hover {
            background-color: #EFC03E; /* 항목 호버 시 배경색 변경 */
        }

        /* 로그인/회원가입 컨테이너 스타일 */
        .auth {
            display: flex; /* 요소를 가로로 정렬 */
            align-items: center; /* 세로 가운데 정렬 */
            font-weight: bold; /* 글자 두께 */
            margin-left: auto; /* 부모 컨테이너의 남은 공간을 밀어서 오른쪽 정렬 */
        }

        .auth a {
            text-decoration: none; /* 링크 밑줄 제거 */
            color: #666; /* 기본 글자 색상 */
            font-size: 14px; /* 글자 크기 */
            font-weight: bold; /* 글자 두께 */
        }

        .auth a:hover {
            color: black; /* 마우스 오버 시 글자 색상 */
        }

        .auth .divider {
            border-left: 2px solid #ccc; /* 구분선 */
            height: 20px; /* 구분선 높이 */
            margin: 0 5px; /* 구분선 좌우 여백 */
        }

        .auth .signup {
            margin-right: 15px; /* 회원가입과 다음 요소 간 간격 */
        }

        /* 기업 서비스 드롭다운 메뉴 스타일 */
        .auth .service .dropdown-menu {
            display: none; /* 기본적으로 숨김 */
            position: absolute; /* 부모 기준 위치 */
            top: 36px; /* 헤더 바로 아래 위치 */
            right: 0; /* 오른쪽 정렬 */
            background-color: white; /* 드롭다운 배경색 */
            border: 2px solid #EFC03E; /* 테두리 색상 및 두께 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15); /* 그림자 */
            list-style: none; /* 리스트 스타일 제거 */
            margin: 0; /* 기본 여백 제거 */
            border-radius: 4px; /* 모서리 둥글게 */
            z-index: 1000; /* 상단 표시 */
            min-width: 100px; /* 최소 너비 */
        }

        .auth .service.active .dropdown-menu {
            display: block; /* 활성화 시 드롭다운 표시 */
        }

        .auth .service .dropdown-menu li {
            padding: 8px 10px; /* 리스트 항목 간격 */
            white-space: nowrap; /* 텍스트 줄바꿈 방지 */
            cursor: pointer; /* 커서 모양 변경 */
        }

        .auth .service .dropdown-menu li:hover {
            background-color: #EFC03E; /* 항목 호버 시 배경색 변경 */
        }
        
  
        
    </style>
</head>
<body>
    <header id="header">
        <!-- 로고 -->
        <div class="logo">
            <a href="/" ><img src="<c:url value='/img/banner.png' />" alt="Logo"></a>
        </div>

       

        <!-- 로그인/회원가입 -->
       
        <div class="auth">
            <a class="login" href="/">홈으로</a>
            <div class="divider"></div>
            <a class="signup" href="#">회원가입</a>
            <div class="service">
                기업서비스
                <ul class="dropdown-menu">
                    <li><a href="#">서비스1</a></li>
                    <li><a href="#">서비스2</a></li>
                    <li><a href="#">서비스3</a></li>
                </ul>
            </div>
        </div>

        
        
    </header>
 


    <script>
      
        // 기업서비스 드롭다운 제어
        const serviceElement = document.querySelector('.auth .service');
        const serviceDropdownMenu = serviceElement.querySelector('.dropdown-menu');

        serviceElement.addEventListener('click', function (event) {
            serviceDropdownMenu.style.left = 'auto';
            serviceDropdownMenu.style.right = 0;

            this.classList.toggle('active');
            event.stopPropagation();
        });

        // 페이지 다른 곳 클릭 시 기업서비스 드롭다운 닫기
        document.addEventListener('click', function () {
            serviceElement.classList.remove('active');
        });
        

    </script>
</body>
</html>
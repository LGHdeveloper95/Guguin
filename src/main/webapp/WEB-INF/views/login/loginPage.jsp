<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 로그인</title>
    <link rel="icon" type="image/png" href="/img/favicon.png" />
    <!-- Bootstrap CSS 로드 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 로그인 페이지의 스타일 -->
    <style>
        /* 기본 설정 */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            /* 배경 이미지 설정 (필요에 따라 추가) */
            /* background: url('/img/loginbackimg.png') no-repeat center center fixed;
            background-size: cover; */
        }

        /* 전체 컨테이너 스타일 */
        .bigbox {
            padding-top: 70px;
            display: flex; /* 요소를 가로로 배치 */
            flex-direction: row; /* 가로 배치 */
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: stretch; /* 높이를 동일하게 맞춤 */
            width: 100%;
        }

        /* 회원가입 박스 스타일 */
        .signup-box {
            display: flex;
            flex-direction: row; /* 내부 요소를 가로로 배치 */
            align-items: center; /* 수직 중앙 정렬 */
            background-color: #fef7a1; /* 노란 배경 */
            /* padding-top: 60px; */
            box-sizing: border-box; /* 패딩을 너비에 포함 */
            /* 테두리 설정 */
            border-top: 2px solid #f4c430;
            border-right: 1px solid #f4c430; /* 오른쪽 테두리 1px */
            border-bottom: 2px solid #f4c430;
            border-left: 2px solid #f4c430;
            /* 오른쪽 마진 제거하여 빈틈 제거 */
            margin-right: 0;
            width: 430px; /* login-container와 동일한 너비 */
            /* 모서리 반지름 설정 */
            border-radius: 10px 0 0 10px; /* 좌상, 우상, 우하, 좌하 */
        }

        /* 회원가입 텍스트 컨테이너 */
        .signup-text {
            flex: 1; /* 남은 공간을 차지하도록 설정 */
            text-align: left; /* 텍스트 왼쪽 정렬 */
            padding-top: 150px; /* 상단 패딩 추가 */
            padding-left: 20px; /* 좌측 여백 추가 */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* 상하 공간을 균등하게 분배 */
            height: 100%;
        }

        /* 회원가입 텍스트 스타일 */
        .signup-text p {
            font-size: 19px; /* 글자 크기 */
            font-weight: bold; /* 볼드체 */
            margin: 0; /* 여백 제거 */
            color: #333333; /* 글자 색상 */
        }

        /* 이미지 스타일 */
        .signup-image {
            max-width: 100%; /* 이미지가 컨테이너를 넘지 않도록 설정 */
            height: auto;
            display: block;
            /* 이미지가 박스의 아래쪽에 위치하도록 설정 */
        }

        /* 구분선 스타일 */
        .signup-divider {
            width: 1px; /* 구분선 너비 */
            background-color: #FEF7A2; /* 구분선 색상 */
            height: 100%; /* 구분선 높이 */
            margin: 0 20px; /* 좌우 마진 */
        }

        /* 회원가입 버튼 컨테이너 */
        .signup-buttons {
            display: flex;
            flex-direction: column; /* 버튼을 세로로 배치 */
            align-items: flex-start; /* 왼쪽 정렬 */
        }

        /* 회원가입 버튼 기본 스타일 */
        .btn-signup,
        .btn-company-signup {
            width: 150px; /* 버튼 너비 */
            padding: 10px; /* 버튼 패딩 */
            border: none;
            border-radius: 5px; /* 버튼 모서리 반지름 */
            font-size: 14px; /* 글자 크기 */
            font-weight: bold; /* 볼드체 */
            cursor: pointer; /* 마우스 커서 모양 */
            margin-bottom: 25px; /* 버튼 간 간격 조정 */
            margin-right: 13px; /* 오른쪽 벽에서 떨어지도록 설정 */
            display: flex; /* 플렉스박스 사용 */
            justify-content: space-between; /* 텍스트와 '>' 기호를 양 끝에 배치 */
            align-items: center; /* 수직 중앙 정렬 */
            height: 50px; /* 버튼 높이 */
        }

        /* 개인 회원가입 버튼 스타일 */
        .btn-signup {
            background-color: #ffffff; /* 흰색 배경 */
            color: #000000; /* 검은 텍스트 */
            border: 1px solid #cccccc; /* 외곽선 */
        }

        .btn-signup:hover {
            background-color: #f0f0f0; /* 호버 효과 */
        }

        /* 기업 회원가입 버튼 스타일 */
        .btn-company-signup {
            background-color: #9ae6b4; /* 연한 초록 배경 */
            color: #ffffff; /* 흰 텍스트 */
            border: 1px solid #86d29a; /* 외곽선 */
        }

        .btn-company-signup:hover {
            background-color: #8cd8a8; /* 호버 효과 */
        }

        /* '>' 기호 스타일 */
        .btn-signup .arrow,
        .btn-company-signup .arrow {
            /* '>' 기호를 오른쪽 끝에 배치 */
            margin-left: auto;
        }

        /* 로그인 컨테이너 스타일 */
        .login-container {
            background-color: #ffffff;
            width: 430px; /* signup-box와 동일한 너비 */
            padding: 40px 30px; /* 컨테이너 패딩 */
            box-sizing: border-box; /* 패딩을 너비에 포함 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
            /* 테두리 설정 */
            border-top: 2px solid #f4c430;
            border-right: 2px solid #f4c430;
            border-bottom: 2px solid #f4c430;
            border-left: 1px solid #f4c430; /* 왼쪽 테두리 1px */
            position: relative;
            z-index: 1; /* 모달보다 뒤에 있도록 설정 */
            /* 모서리 반지름 설정 */
            border-radius: 0 10px 10px 0; /* 좌상, 우상, 우하, 좌하 */
        }

        /* 로고 이미지 스타일 */
        .login-image {
            display: block;
            margin: 0 auto 20px; /* 상하 좌우 마진 */
            width: 150px; /* 이미지 너비 */
        }

        /* 로그인 탭 스타일 */
        .login-tabs {
            display: flex;
            justify-content: center; /* 탭을 중앙에 배치 */
            margin-bottom: 20px; /* 아래 여백 */
        }

        .login-tabs a {
            text-decoration: none; /* 밑줄 제거 */
            font-size: 16px; /* 글자 크기 */
            font-weight: bold; /* 볼드체 */
            padding: 10px 20px; /* 패딩 */
            color: #555; /* 글자 색상 */
            border-bottom: 2px solid transparent; /* 하단 테두리 */
        }

        .login-tabs a.active {
            color: #f4c430; /* 활성화된 탭 색상 */
            border-bottom: 2px solid #f4c430; /* 하단 테두리 강조 */
        }

        /* 커스텀 입력 필드 컨테이너 */
        .form-floating-custom {
            position: relative;
            margin-bottom: 20px; /* 아래 여백 */
        }

        /* 입력 필드 스타일 */
        .form-floating-custom input {
            width: 100%; /* 부모 요소에 맞게 너비 조정 */
            padding: 10px; /* 패딩 */
            font-size: 16px; /* 글자 크기 */
            border: 1px solid #ccc; /* 테두리 */
            border-radius: 5px; /* 모서리 반지름 */
            box-sizing: border-box; /* 패딩을 너비에 포함 */
        }

        /* 입력 필드 레이블 스타일 */
        .form-floating-custom label {
            position: absolute;
            top: -10px; /* 위쪽 위치 */
            left: 10px; /* 왼쪽 위치 */
            background: #fff; /* 배경색 */
            padding: 0 5px; /* 패딩 */
            font-size: 12px; /* 글자 크기 */
            color: #999; /* 글자 색상 */
        }

        /* 로그인 버튼 스타일 */
        .btn-login {
            background-color: #f4c430; /* 배경색 */
            color: #fff; /* 글자색 */
            width: 100%;  /* 부모 요소에 맞게 너비 조정 */
            font-size: 16px; /* 글자 크기 */
            font-weight: bold; /* 볼드체 */
            padding: 10px 0; /* 패딩 */
            margin-bottom: 15px; /* 버튼 아래 간격 조정 */
            margin-right: 10px; /* 오른쪽 벽에서 떨어지도록 설정 */
            border: none;
            border-radius: 5px; /* 모서리 반지름 */
            cursor: pointer; /* 마우스 커서 모양 */
            text-align: center; /* 텍스트 중앙 정렬 */
            /* 버튼의 세로 너비(height)를 조정하려면 아래 속성을 수정하세요 */
            /* height: 50px; */
        }

        .btn-login:hover {
            background-color: #e5b020; /* 호버 효과 */
        }

        /* 로그인 링크 스타일 */
        .login-links {
            text-align: center; /* 중앙 정렬 */
            margin-top: 20px; /* 위쪽 여백 */
        }

        .login-links a {
            text-decoration: none; /* 밑줄 제거 */
            color: #555; /* 글자 색상 */
            font-size: 14px; /* 글자 크기 */
            margin: 0 5px; /* 좌우 마진 */
        }

        .login-links a:hover {
            color: #f4c430; /* 호버 시 글자 색상 */
        }
    </style>
</head>
<%@include file="/WEB-INF/include/loginHeader.jsp" %>
<body>
<div class="bigbox">
    <div class="signup-box">
        <div class="signup-text">
            <p><strong>아직 Guguin의<br>회원이 아니신가요?</strong></p>
            <!-- 이미지 삽입 -->
            <img src="/img/gugugu.png" alt="구구맨 이미지" class="signup-image">
        </div>
        <!-- 구분선 추가 -->
        <div class="signup-divider"></div>
        <div class="signup-buttons">
            <button class="btn-signup" onclick="location.href='/Join/UserJoinForm'">회원가입<span class="arrow">></span></button>
            <button class="btn-company-signup" onclick="location.href='/Join/ComJoin'">기업가입<span class="arrow">></span></button>
        </div>
    </div>
    <div class="login-container">
        <img src="/img/banner.png" alt="Logo" class="login-image">
        <div class="login-tabs">
            <a href="#" id="personal" class="active">개인회원</a>
            <a href="#" id="business">기업회원</a>
        </div>
        <div id="login">
            <form action="/Login/User" method="POST">
                <div class="form-floating-custom">
                    <input type="text" id="floatingId" name="userid" placeholder="아이디">
                    <label for="floatingId">아이디</label>
                </div>
                <div class="form-floating-custom">
                    <input type="password" id="floatingPw" name="userpw" placeholder="비밀번호">
                    <label for="floatingPw">비밀번호</label>
                </div>
                <button type="submit" class="btn-login">로그인</button>
            </form>
        </div>
        <div class="login-links">
            <a href="#" data-modal-url="/Login/UserId" data-modal-title="아이디 찾기" class="modal-trigger">아이디 찾기</a> |
            <a href="#" data-modal-url="/Login/UserPw" data-modal-title="비밀번호 찾기" class="modal-trigger">비밀번호 찾기</a>
        </div>
    </div>
</div>

<!-- 모달 구조 -->
<div class="modal fade" id="modalCenter" tabindex="-1" aria-labelledby="modalCenterLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalCenterLabel">모달 제목</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModal"></button>
            </div>
            <div class="modal-body">
                <!-- AJAX로 로드될 내용 -->
            </div>
        </div>
    </div>
</div>

<!-- jQuery 로드 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- Bootstrap JS 로드 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 탭 클릭 이벤트
    document.getElementById("personal").onclick = function (e) {
        e.preventDefault();
        document.getElementById("personal").classList.add("active");
        document.getElementById("business").classList.remove("active");
        document.getElementById("login").innerHTML = `
            <form action="/Login/User" method="POST">
                <div class="form-floating-custom">
                    <input type="text" id="floatingId" name="userid" placeholder="아이디">
                    <label for="floatingId">아이디</label>
                </div>
                <div class="form-floating-custom">
                    <input type="password" id="floatingPw" name="userpw" placeholder="비밀번호">
                    <label for="floatingPw">비밀번호</label>
                </div>
                <button type="submit" class="btn-login">로그인</button>
            </form>
        `;
        document.querySelector(".login-links").innerHTML = `
            <a href="#" data-modal-url="/Login/UserId" data-modal-title="아이디 찾기" class="modal-trigger">아이디 찾기</a> |
            <a href="#" data-modal-url="/Login/UserPw" data-modal-title="비밀번호 찾기" class="modal-trigger">비밀번호 찾기</a>
        `;
    };

    document.getElementById("business").onclick = function (e) {
        e.preventDefault();
        document.getElementById("business").classList.add("active");
        document.getElementById("personal").classList.remove("active");
        document.getElementById("login").innerHTML = `
            <form action="/Login/Com" method="POST">
                <div class="form-floating-custom">
                    <input type="text" id="floatingId" name="comid" placeholder="아이디">
                    <label for="floatingId">아이디</label>
                </div>
                <div class="form-floating-custom">
                    <input type="password" id="floatingPw" name="compw" placeholder="비밀번호">
                    <label for="floatingPw">비밀번호</label>
                </div>
                <button type="submit" class="btn-login">로그인</button>
            </form>
        `;
        document.querySelector(".login-links").innerHTML = `
            <a href="#" data-modal-url="/Login/ComId" data-modal-title="기업 아이디 찾기" class="modal-trigger">기업 아이디 찾기</a> |
            <a href="#" data-modal-url="/Login/ComPw" data-modal-title="기업 비밀번호 찾기" class="modal-trigger">기업 비밀번호 찾기</a>
        `;
    };

    // 모달 트리거
    $(document).on("click", ".modal-trigger", function (e) {
        e.preventDefault();
        const modalUrl = $(this).data("modal-url");
        const modalTitle = $(this).data("modal-title");
        const modal = new bootstrap.Modal(document.getElementById('modalCenter'));
        $.get(modalUrl, function (data) {
            $("#modalCenter .modal-body").html(data);
            $("#modalCenterLabel").text(modalTitle);
            modal.show();
        });
    });

    // 모달 닫기
    $(document).on("click", "#closeModal", function (e) {
        const modal = bootstrap.Modal.getInstance(document.getElementById('modalCenter'));
        modal.hide();
    });
</script>
<%@include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
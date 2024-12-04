<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 로그인</title>
    <link rel="icon" type="image/png" href="/img/favicon.png" />
    <link rel="stylesheet" href="/css/common.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        /* 전체 페이지 배경 스타일 */
        body {
        position: relative;
        background-color: #fff; /* 기본 배경색 */
        height: 100vh; /* 뷰포트 높이 100% 사용 */
        display: flex;
        justify-content: center; /* 가로 방향 중앙 정렬 */
        align-items: center; /* 세로 방향 중앙 정렬 */
        font-family: Arial, sans-serif; /* Arial 폰트 사용 */
        overflow: hidden; /* 스크롤 방지 */
    }

    /* 흐린 배경 이미지를 추가하는 ::before 가상 요소 */
    body::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('/img/bgimg.png') no-repeat center center fixed;
    background-size: cover;
    filter: blur(10px); /* 블러 효과 적용 */
    opacity: 0.7; /* 약간의 투명도 추가 */
    z-index: -1; /* 콘텐츠 위로 겹치지 않도록 뒤로 배치 */
}

    /* 큰 박스 컨테이너 스타일 */
    .big-div {
        position: relative;
        background-color: #f9f9f9; /* 박스 배경을 연한 회색으로 설정 */
        padding: 120px; /* 박스 내부 여백 */
        border-radius: 10px; /* 박스 모서리를 둥글게 */
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 추가 */
        text-align: center; /* 내부 텍스트를 중앙 정렬 */
        width: 600px; /* 박스 너비를 600px로 설정 */
        z-index: 1; /* 배경 이미지보다 위에 표시 */
    }
        /* 로그인 버튼의 셀 스타일 */
        #login_button td {
            text-align: center; /* 텍스트를 중앙 정렬 */
            background: #333; /* 배경색을 어두운 회색으로 설정 */
            color: white; /* 텍스트 색을 흰색으로 설정 */
            font-weight: bold; /* 텍스트를 굵게 설정 */
            border: 1px solid silver; /* 테두리를 은색으로 설정 */
            padding: 0; /* 셀 내부 여백을 없앰 */
        }

        /* 로그인 버튼의 셀 호버 스타일 */
        #login_button td:hover {
            background: #c0c0c0; /* 호버 시 배경색을 밝은 회색으로 변경 */
            color: white; /* 텍스트 색을 흰색으로 유지 */
        }

        /* 로그인 버튼의 링크 스타일 */
        #login_button a {
            text-decoration: none; /* 밑줄 제거 */
            color: white; /* 텍스트 색을 흰색으로 설정 */
            display: block; /* 블록 요소로 설정하여 셀 전체를 클릭 영역으로 */
            padding: 15px 65px; /* 내부 여백 설정 */
            width: 100%; /* 너비를 100%로 설정하여 셀에 맞춤 */
            text-align: center; /* 텍스트 중앙 정렬 */
            
        }

        /* 폼 상자 및 내부 요소 중앙 정렬 */
        .form-box h2,
        .form-box form {
            text-align: center; /* 제목과 폼 내부 요소를 중앙 정렬 */
        }

        /* 메인 컨테이너 스타일 */
        main {
            display: grid; /* grid 레이아웃 사용 */
            place-items: center; /* 중앙 정렬을 위해 grid 아이템을 중앙에 배치 */
            margin: 50px 0; /* 상하 마진 추가 */
        }

        /* 클릭된 버튼 스타일 */
        .clicked {
            background: #999999; /* 클릭된 버튼의 배경색을 중간 회색으로 설정 */
        }

        /* 폼 스타일 */
        form {
            width: 380px; /* 폼 너비를 380px로 설정 */
            text-align: center; /* 폼 내부 요소를 중앙 정렬 */
        }

        /* 일반 버튼 스타일 */
        .btn {
            width: 110px; /* 버튼 너비를 110px로 설정 */
            font-size: 13px; /* 글자 크기 설정 */
            display: inline-block; /* 버튼을 인라인 블록으로 설정하여 중앙 정렬 가능 */
        }

        /* 주요 버튼 (로그인) 스타일 */
        .btn-light {
            width: 380px; /* 너비를 폼에 맞추어 380px로 설정 */
            height: 60px; /* 버튼 높이 설정 */
            font-size: large; /* 글자 크기를 크게 설정 */
            text-align: center; /* 텍스트 중앙 정렬 */
            vertical-align: center; /* 텍스트 수직 중앙 정렬 */
        }
        .ddiv{
        justify-content: center;
        margin-left: 30px;
        }
        .back{
      height: 40px; /* 버튼 높이 */
        padding: 0 15px;
        border: none;
        background-color: black;
        color: white;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
        transition: background-color 0.3s ease, transform 0.2s ease;
        margin-left: 20px;
    }
    .back:hover {
       background-color: #999999;
        transform: scale(1.02);
    }
        
    </style>
</head>
<body>
<main>
    <div class="big-div">
        <div class="form-box">
            
            <img src="/img/banner.png" alt="Logo" style="width: 200px; margin-bottom: 40px; margin-top: -30%;">
            <h2>Login</h2>
            <div class="ddiv" >
            <table id="login_button">
                <tr>
                    <td><a href="#" onclick="return false" id="personal">개인</a></td>
                    <td><a href="#" onclick="return false" id="business">기업</a></td>
                </tr>
            </table>
            </div>
            <div id="login"></div>
             <button type="button" class="back" onclick="location.href='${pageContext.request.contextPath}/'">홈으로</button>
        </div>
    </div>
</main>
<script>
    document.getElementById("personal").onclick=()=>{
        let html ="<br><form action='/Login/User' method='POST'>";
        html+="<h2>개인 로그인</h2>";
        html+="<div class='form-floating'><input type='text' name='userid' id='floatingId' class='form-control' placeholder='아이디' value='BO112'/>";
        html+="<label for='floatingId'>아이디</label></div>"
        html+="<div class='form-floating'><input type='password' name='userpw'  id='floatingPw'  class='form-control' placeholder='패스워드' value='12345678D@'/>";
        html+="<label for='floatingPw'>패스워드</label></div>"
        html+="<br><input type = 'submit' value='로그인' class='btn btn-light'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        html+="<a href='/Login/UserId' class='btn' onclick='click_find(this.href); return false'>아이디 찾기</a>";
        html+="<a href='/Login/UserPw' class='btn' onclick='click_find(this.href); return false'>비밀번호 찾기</a>";
        html+="<a href='/Join/UserJoinForm' class='btn'>회원가입</a>";
        html+="</form>";
        document.getElementById("login").innerHTML=html;
        document.getElementById("business").classList.remove("clicked");
        document.getElementById("personal").classList.add("clicked");
    }
    document.getElementById("business").onclick=()=>{
        let html ="<br><form action='/Login/Com' method='POST'>";
        html+="<h2>기업 로그인</h2>";
        html+="<div class='form-floating'><input type='text' name='comid' id='floatingId' class='form-control' placeholder='아이디'/>";
        html+="<label for='floatingId'>아이디</label></div>"
        html+="<div class='form-floating'><input type='password' name='compw'  id='floatingPw'  class='form-control' placeholder='패스워드'/>";
        html+="<label for='floatingPw'>패스워드</label></div>"
        html+="<br><input type = 'submit' value='로그인' class='btn btn-light'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        html+="<a href='/Login/ComId' class='btn' onclick='click_find(this.href); return false'>아이디 찾기</a>";
        html+="<a href='/Login/ComPw' class='btn' onclick='click_find(this.href); return false'>비밀번호 찾기</a>";
        html+="<a href='/Join/ComJoin' class='btn'>회원가입</a>";
        html+="</form>";

        document.getElementById("login").innerHTML=html;
        document.getElementById("personal").classList.remove("clicked");
        document.getElementById("business").classList.add("clicked");

    }
    document.getElementById("personal").click();

    function click_find(link){
    	const left = (window.screen.width-500) / 2;
    	const top = (window.screen.height-400) / 2;
    	console.log(left);
        window.open(link, '_blank', 'width=500, height=400, left='+left+',top='+top);
        return false;
    }
</script>
</body>
</html>







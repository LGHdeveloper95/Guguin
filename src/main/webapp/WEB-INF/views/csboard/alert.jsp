<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 알림</title>
    <style>
        body {
            background-color: #fff; /* 하얀 배경 */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .alert-box {
            background-color: #f9f9f9; /* 박스 배경 */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
            text-align: center;
            width: 400px; /* 박스 크기 적당히 */
        }

        .alert-box img {
            width: 100px; /* 이미지 크기 조절 */
            margin-bottom: 20px; /* 이미지와 텍스트 간격 */
        }

        .alert-box p {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }

        .alert-box button {
            background-color: #333; /* 검정 버튼 */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .alert-box button:hover {
            background-color: #000; /* 마우스 호버 시 */
        }

        .alert-box button:active {
            transform: scale(0.98); /* 클릭 시 약간 작아지는 효과 */
        }
    </style>
</head>
<body>

<div class="alert-box">
    <!-- 로고 이미지 출력 -->
    <img src="/img/banner.png" alt="Logo">
    
    <!-- 알림 텍스트 출력 -->
    <p>${loginError != null ? '로그인이 필요합니다.' : '직접 작성한 글만 볼 수 있습니다.'}</p>
    
    <!-- 확인 버튼 -->
    <button onclick="window.location.href='${loginError != null ? '/Login/' : '/Cs/Board'}';">
        확인
    </button>
</div>

</body>

</html>
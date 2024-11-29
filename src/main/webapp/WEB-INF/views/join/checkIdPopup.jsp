<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 아이디중복확인</title>
    <style>
        /* 메인 컨테이너 스타일 */
        .bigbox {
            display: flex; /* 플렉스 박스로 설정 */
            flex-direction: column; /* 세로 방향 정렬 */
            justify-content: center; /* 수직 중앙 정렬 */
            align-items: center; /* 수평 중앙 정렬 */
            height: 100vh; /* 뷰포트 높이에 맞춤 */
            margin: 0; /* 기본 마진 제거 */
            gap: 20px; /* 내부 요소 간의 간격 설정 */
        }
        /* 결과 박스 스타일 */
        .box {
            border: 6px solid #3f3f3f; /* 테두리 설정 */
            border-radius: 7%; /* 모서리 반지름 */
            padding: 20px; /* 내부 여백 */
            text-align: center; /* 텍스트 중앙 정렬 */
        }
        /* 중복일 때 텍스트 스타일 */
        .duplicate {
            color: red; /* 글자 색상 */
            font-weight: bold; /* 글자 두께 */
        }
        /* 사용 가능할 때 텍스트 스타일 */
        .available {
            color: green; /* 글자 색상 */
            font-weight: bold; /* 글자 두께 */
        }
    </style>
</head>
<body class="bigbox">
    <img src="/img/banner.png" alt="Logo" style="width: 40%; margin-top: -70px;">

    <div class="box">
        <h3>아이디 중복 확인 결과</h3>
        <%
            boolean isDuplicate = (Boolean) request.getAttribute("isDuplicate");
            if (isDuplicate) {
                out.println("<p class='duplicate'>이미 사용 중인 아이디입니다.</p>");
            } else {
                out.println("<p class='available'>사용 가능한 아이디입니다.</p>");
            }
        %>
        <!-- 닫기 버튼 클릭 시 부모 창의 closeModal 함수 호출 -->
        <button onclick="parent.closeModal()">닫기</button>
    </div>
</body>
</html>
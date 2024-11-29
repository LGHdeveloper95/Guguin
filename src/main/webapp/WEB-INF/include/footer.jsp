<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>페이지 제목</title>
    <style>
	  html, body {
    margin: 0;
    margin-bottom: 50px;
    padding: 0;
    /* height: 100%; */ /* 전체 화면 높이 사용 */
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    
   }


/* 전체 footer 스타일 */
.footer {
    background-color: #FFF7E1;
    height: 62px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    bottom: 0;
    position: fixed; /* 화면에 고정 */
   
    
}
     
        /* 조건별 푸터 배경색 */
        <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
            .footer {
                background-color: #FFF7E1; /* 비로그인 상태 */
            }
        </c:if>
        <c:if test="${not empty sessionScope.userid}">
            .footer {
                background-color: #FFF7E1; /* 개인회원 */
            }
        </c:if>
        <c:if test="${not empty sessionScope.comid}">
            .footer {
                background-color: #EAFFEF; /* 기업회원 */
            }
        </c:if>

        /* 메뉴 스타일 */
        .footer-menu {
            display: flex;
            gap: 60px;
            font-size: 14px;
            font-weight: bold;
            color: #6c757d;
        }
        .footer-menu a {
            text-decoration: none;
            color: inherit;
        }
        .footer-menu a:hover {
            color: black;
        }

        /* 관리자 접속 버튼 스타일 */
        .admin-button {
            position: absolute;
            right: 20px;
            bottom: 15px;
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 8px 12px;
            font-size: 13px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .admin-button:hover {
            background-color: black;
        }
    </style>
</head>
<body>
    

    <!-- 푸터 -->
    <div class="footer">
       <div class="infooter">
        <div class="footer-menu">
            <a href="#">회사소개</a>
            <a href="#">인재채용</a>
            <a href="#">Q&A</a>
            <a href="#">공지사항</a>
            <a href="#">고객 문의</a>
        </div>
       </div>
    
        <!-- 관리자 접속 버튼 -->
        <a href="/admin/login" class="admin-button">관리자 UI</a>
    </div>
</body>
</html>
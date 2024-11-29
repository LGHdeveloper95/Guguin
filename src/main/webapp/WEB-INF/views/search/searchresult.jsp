<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>검색 결과</title>
    <style>
        /* 컨테이너 스타일 */
        .container {
            width: 80%;
            margin: 0 auto;
            margin-top: 70px;
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        /* 섹션 스타일 */
        .section {
            margin-bottom: 50px;
        }
        .section h2 {
            font-size: 24px;
            margin-bottom: 20px;
            border-bottom: 2px solid #FAD673;
            padding-bottom: 10px;
            color: #FAD673;
        }
        /* 더보기 버튼 스타일 */
        .more-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #FAD673;
            color: #000;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.2s, transform 0.2s;
        }
        .more-button:hover {
            background-color: #EFC03E;
            transform: scale(1.05);
        }
        /* 커뮤니티 게시글 리스트 스타일 */
        .community-list {
            list-style: none;
            padding: 0;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .community-list li {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .community-list li:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
        .community-list a {
            text-decoration: none;
            color: #333;
            font-size: 18px;
            font-weight: bold;
            display: block;
            margin-bottom: 8px;
            transition: color 0.2s;
        }
        .community-list a:hover {
            color: #FAD673;
        }
        .content-preview {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
        }
        /* 공고 카드 스타일 */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4열 그리드 */
            gap: 20px;
        }
        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }
        .card-body {
            padding: 10px;
            text-align: center;
        }
        .card-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .card-text {
            font-size: 14px;
            color: #555;
        }
        /* 페이지네이션 스타일 */
    
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .container {
                width: 95%;
            }
            .grid-container {
                grid-template-columns: repeat(2, 1fr);
            }
            .community-list a {
                font-size: 16px;
            }
            .content-preview {
                font-size: 13px;
            }
            .more-button {
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 검색 결과 제목 -->
    <h1>"${keyword}"에 대한 검색 결과</h1>

    <!-- 커뮤니티 게시글 섹션 -->
    <div class="section">
        <h2>커뮤니티 게시글</h2>
        <ul class="community-list">
            <c:forEach var="post" items="${communityPosts}">
                <li>
                    <!-- 게시글 제목 -->
                    <a href="/community/view/${ post.conum }">
                        <c:out value="${post.notTitle}"/>
                        <span style="float: right;">&#8594;</span>
                    </a>
                    <!-- 게시글 내용 미리보기 (최대 100자) -->
                    <div class="content-preview">
                        <c:out value="${fn:length(post.notContent) > 100 ? fn:substring(post.notContent, 0, 100) + '...' : post.notContent}"/>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <!-- 페이지네이션 -->
        <%@ include file="/WEB-INF/include/searchPaging2.jsp" %>
        <!-- 더보기 버튼 -->
        <a href="#" class="more-button">더보기</a>
    </div>

    <!-- 채용 공고 섹션 -->
    <div class="section">
        <h2>채용 공고</h2>
        <div class="grid-container">
            <c:forEach var="recruit" items="${recruitPosts}">
                <div class="card">
                    <img src="${recruit.picture}" alt="공고 이미지">
                    <div class="card-body">
                        <h5 class="card-title"><c:out value="${recruit.rectitle}"/></h5>
                        <a href="/post/view/${recruit.recnum}">
                            <p class="card-text"><c:out value="${recruit.comname}"/></p>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!-- 페이지네이션 -->
        <%@ include file="/WEB-INF/include/searchPaging1.jsp" %>
        <!-- 더보기 버튼 -->
        <a href="/Rec/recruit" class="more-button">더보기</a>
    </div>
</div>
</body>
</html>
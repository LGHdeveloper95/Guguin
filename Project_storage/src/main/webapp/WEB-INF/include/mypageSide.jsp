<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
  aside {
  border: 1px solid #dee2e6;
  border-radius: 10px;
  margin: 50px;
  padding: 25px 10px;
  width: 15%;
  min-width: 210px;
  max-height: 550px;
  }
  aside ul { padding: 0 20px; }
  aside li { list-style-type: none; }
  aside .category { font-weight: bold; margin-top: 20px; }
  aside h5 { text-align: center; }
  ul a{
	  text-decoration: none;
	  color: black;
	  width: 100%;
	  padding: 0 10%;
  }
  ul a:hover {
	text-decoration: underline;
  }
  .navi-selec{ background-color: rgb(253, 241, 211)}
</style>
<aside class="shadow">
  <h5 class="center">개인회원 홈</h5>
  <hr>
  <ul>
    <li class="category">이력서 관리</li>
    <li><a href="/User/Mypage/Resume">이력서 현황</a></li>
    <li><a href="/User/Mypage/Resume/Insert">이력서 등록</a></li>
    <li class="category">입사지원 관리</li>
    <li><a href="/User/Mypage/Apply">입사지원 현황</a></li>
    <li class="category">스크랩/관심기업</li>
    <li><a href="#">스크랩 공고</a></li>
    <li><a href="#">관심기업</a></li>
    <li class="category">콘텐츠 관리</li>
    <li><a href="#">My 기업리뷰</a></li>
    <li><a href="#">내가쓴 커뮤니티글</a></li>
    <li class="category">회원정보관리</li>
    <li><a href="#">회원정보 수정</a></li>
    <li><a href="#">비밀번호 변경</a></li>
    <li><a href="#">쪽지함</a></li>
  </ul>
</aside>
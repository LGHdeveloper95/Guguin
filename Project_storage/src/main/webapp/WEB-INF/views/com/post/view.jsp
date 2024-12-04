<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사람과 기업을 연결하는 구구인</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico"/>

</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
    <div>
        <table>
            <thead>
            <tr>
                <td colspan="2">공고 제목 : ${ post.rectitle }</td>
                <td>
                    <a class="btn btn-primary" href="/post">목록</a>
                    <c:if test="${sessionScope.comid eq post.comid}">
                        <a class="btn btn-primary" href="/post/update/${post.recnum}">수정 </a>
                        <a class="btn btn-primary" id ="delete" href="/post/delete/${post.recnum}" onclick="return false">삭제 </a>
                    </c:if>
                </td>
            </tr>
            </thead>
            <tr>
                <td>부제</td>
                <td colspan="2">${post.subtitle}</td>
            </tr>
            <tr>
                <td> 작성일 ${post.reg_date}</td>
                <td> 채용 시작일 ${post.start_date}</td>
                <td> 마감일 ${post.deadline}</td>
            </tr>
            <tr>
                <td>기업 이름</td>
                <td>${ com.comname } </td>
            </tr>
            <tr>
                <td>대표자</td>
                <td>${com.boss}</td>
            </tr>
            <tr>
                <td>회사 연락처</td>
                <td>${ com.cphone }</td>
            </tr>
            <tr>
                <td>주소</td>
                <td colspan="2">${ com.caddr }</td>
            </tr>
            <tr>
                <td>우대 학력</td>
                <td colspan="2">${ edu.edu_name }</td>
            </tr>
            <tr>
                <td>우대 경력</td>
                <td colspan="2">${ career.career_name }</td>
            </tr>
            <tr>
                <td>우대 자격증</td>
                <c:if test="${ post.license!= null }">
                    <td colspan="2">
                        ${post.license}
                    </td>
                </c:if>
                <c:if test="${post.license eq null}">
                    <td colspan="2"> 없음</td>
                </c:if>
            </tr>
            <tr>
                <td>우대 기술</td>
                <td colspan="2">
                    <c:forEach items="${ skillList }" var="skill">
                        ${ skill } <c:if test="!${status.last}"> ,</c:if>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <td>근무 지역</td>
                <td colspan="2">
                    <div>${region.sido} ${region.gugun}</div>
                </td>
            </tr>
        </table>
        <!-- 자기소개서--------------------------------------------------- -->
        <table>
            <thead>
            <tr>
                <td colspan="3">회사 소개</td>
            </tr>
            </thead>
            <tr class="content">
                <td colspan="3">${ post.gcontent }</td>
            </tr>
        </table>
    </div>
</main>

<script>
    document.getElementById("delete").onclick=()=>{
        if(confirm("정말 삭제하시겠습니까?")){
            fetch(document.getElementById("delete").href,{
                method:"DELETE"
                ,headers:{
                    'Content-type': 'application/json; charset=UTF-8'
                }
            }).then(response=> {
                    alert("삭제 되었습니다.");
                    window.location.replace("/post");
                }
            ).catch(err=>alert("삭제 실패")+err)
        }
        return false;
    }
</script>
</body>
</html>


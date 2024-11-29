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
<style>
    main {
        margin: 0 auto 0;
        width: 80%;
        display: grid;
        grid-template-columns: 1fr 3fr;
    }
    #side_content li{
        list-style-type: none;
        text-decoration: none;
        margin: 10px 10px;
    }
    #note table th:nth-child(1){
        width: 20%;
    }
    #note table th:nth-child(2){
        width: 60%;
    }
    #note table th:nth-child(3){
        width: 20%;
    }
    #note{
        border: 1px solid #cccccc;
        border-radius: 5px;
        margin: 10px 0;
        width: 60%;
        min-height: 50vh;
    }
    #note div{
        margin: 10px 0;
    }
    #note div span{
        margin: 0 15px;
    }

    button{
        border: none;
        background: #DDDDDD;
        border-radius: 5px;
        font-size: 16px;
        font-weight: 550;
        padding: 5px 5px;
        margin: 5px;
    }
    button:hover{
        transform: scale(1.05);
    }

    <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
    button { background-color: #FAD673; }  </c:if>/* 비로그인 상태 */
    <c:if test="${not empty sessionScope.userid}">
    button { background-color: #FAD673; }  </c:if>/* 개인회원 */
    <c:if test="${not empty sessionScope.comid}">
    button { background-color: #66DD7E; } </c:if> /* 기업회원 */

</style>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<main>

    <div id="side">
        <div id="side_button"></div>
        <div id="side_content">
            <ul>
                <li id="getNote">받은 쪽지함</li>
                <li id="sendNote">보낸 쪽지함</li>
                <li>휴지통</li>
            </ul>
        </div>
    </div>
    <div id="content">
        <div>
            <button id="back">뒤로가기</button>
            <button id="delete">삭제</button>
            <button id="send">답장</button>
        </div>
        <div id="note">
            <div><b>제목</b><span>${note.note_title}</span></div>
            <div><b>보낸사람</b><span>${note.receive_id}</span></div>
            <div><b>받은시간</b><span>${note.reg_date}</span></div>
            <hr>
            <div>${note.note_content}</div>
        </div>
    </div>
</main>
<script>
    //받은 쪽지함 쪽지 list 불러오기.
    document.getElementById("getNote").addEventListener('click', function () {
        window.location.href="/note/";
    })
    document.getElementById("sendNote").addEventListener('click', function () {
        window.location.href="/note/";
    })
    document.getElementById("delete").addEventListener('click',function (){
        if(confirm("삭제 하시겠습니까?")){
            fetch("/note/delete", {
                method: "DELETE",
                headers: {
                    'Content-type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({
                    note_num:'<c:out value="${note.note_num}"/>'
                })
            }).then(response => response.text())
                .then(text => {
                    if(text=="OK"){
                        alert("삭제 완료")
                        window.location.href="/note/"
                    }
                    else if(text=="ERROR"){
                        alert("관리자에게 문의하세요")
                    }
                }).catch(err => console.log(err));
        }
    })
    document.getElementById('send').addEventListener('click',function (){
        window.location.href="/note/write/${note.send_id}";
    })
    document.getElementById('back').addEventListener('click',function (){
        window.location.href="/note/";
    })
</script>
</body>
</html>



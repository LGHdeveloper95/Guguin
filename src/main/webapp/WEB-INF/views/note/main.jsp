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

    #side_content li {
        list-style-type: none;
        text-decoration: none;
        margin: 10px 10px;
    }

    #note table th:nth-child(1) {
        width: 20%;
    }

    #note table th:nth-child(2) {
        width: 60%;
    }

    #note table th:nth-child(3) {
        width: 20%;
    }

    #note table,#note tr,#note td{
        border: 1px solid #CCCCCC;
    }
    .view0{
        text-decoration: 0;
        color: black;
    }
    .viewnull{
        text-decoration: none;
        color: #666666;
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
    input[type=radio]{
        opacity: 0;
    }
    input[type=radio]:checked{
        background: #f9f9f9;
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
            <button id="write">쪽지 쓰기</button>
        </div>
        <div id="note">
        </div>
    </div>
</main>
<script>
    //받은 쪽지함 쪽지 list 불러오기.
    const getList = function () {

        fetch("/note/getList/${type}", {
            method: "GET"
        }).then(response => response.json())
            .then(noteList => {
                console.log(noteList)
                let output = "<table>";
                output += '<tr>'
                output += '<th>보낸사람</th>'
                output += '<th>제목</th>'
                output += '<th>날짜</th>'
                output += '</tr>'
                let viewed=0;
                noteList.forEach(function (note) {
                    if(note.viewed!=null) viewed++;
                    output += '<tr>'
                    output += '<td><span>' + note.send_id + '</span></td>';
                    output += '<td><a href="/note/view/' + note.note_num + '"class="view'+note.viewed+'">' + note.note_title + '</a></td>';
                    output += '<td>' + note.reg_date + '</td>'
                    output += '</tr>'
                })
                output += '</table>';
                document.getElementById('note').innerHTML='쪽지 '+viewed+' / '+noteList.length+'개'+output;
            })
    }

    const getSendList = function () {

        fetch("/note/getSendList/${type}", {
            method: "GET"
        }).then(response => response.json())
            .then(noteList => {
                let output = "<table>";
                output += '<tr>'
                output += '<th>받는사람</th>'
                output += '<th>제목</th>'
                output += '<th>날짜</th>'
                output += '</tr>'
                noteList.forEach(function (note) {
                    output += '<tr>'
                    output += '<td><span>' + note.receive_id + '</span></td>';
                    output += '<td><a href="/note/send-view/' + note.note_num + '">' + note.note_title + '</a></td>';
                    output += '<td>' + note.reg_date + '</td>'
                    output += '</tr>'
                })
                output += '</table>';
                document.getElementById('note').innerHTML='쪽지 '+noteList.length+'개'+output;
            }).catch(err=>console.log(err))
    }

    getList();
    document.getElementById("getNote").addEventListener('click', function () {
        getList();
    })
    document.getElementById("sendNote").addEventListener('click', function () {
        getSendList();
    })
    document.getElementById("write").addEventListener('click',function (){
        window.location.href = "/note/write";
    })
</script>
</body>
</html>



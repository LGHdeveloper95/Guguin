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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
    .radio {
        opacity: 0;
        padding: 5px 10px;
        border: 1px solid #ffffff;
        border-radius: 10px;
    }
    input[type=radio]:checked + label{
        padding: 5px 10px;
        border: 1px solid #ffffff;
        border-radius: 10px;
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

    <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
    button,input[type=radio]:checked + label { background-color: #FAD673; }  </c:if>/* 비로그인 상태 */

    <c:if test="${not empty sessionScope.userid}">
    button,input[type=radio]:checked + label { background-color: #FAD673; }  </c:if>/* 개인회원 */
    <c:if test="${not empty sessionScope.comid}">
    button,input[type=radio]:checked + label { background-color: #66DD7E; } </c:if> /* 기업회원 */
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
            <button id="submit">작성</button>
        </div>
        <div id="note">
            <input type="hidden" name="send_id" value="${id}"/>
            <div><b>보내는 이</b><span>${id}</span></div>
            <div>
                <b>받는 이</b>
                <span><input type="text" name="receive_id" value="${send_id}"></span>
                <input type="radio" class="radio" name="receive_type" id="user" value="USER" checked>
                <label for="user">개인</label>
                <input type="radio" class="radio" name="receive_type" id="com" value="COM">
                <label for="com">기업</label>
            </div>
            <div><b>제목</b><input type="text" name="note_title"/></div>
            <hr>
            <div><textarea name="note_content" cols="60" rows="20"></textarea></div>
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

    document.getElementById("submit").addEventListener('click',function (){
        if($('input[name=receive_id]').val()==null||$('input[name=receive_id]').val()==""){
            alert("받는 아이디를 입력해주세요.");
            $('input[name=receive_id]').focus();
            return false;
        }
        if($('input[name=note_title]').val()==null||$('input[name=note_title]').val()==""){
            alert("제목을 입력해주세요.");
            $('input[name=note_title]').focus();
            return false;
        }
        if($('textarea[name=note_content]').val()==null||$('textarea[name=note_content]').val()=="") {
            alert("내용을 입력해주세요.");
            $('textarea[name=note_content]').focus();
            return false;
        }


        fetch("/note/write",{
            method:"POST",
            headers:{
                'Content-type': 'application/json; charset=UTF-8'
            },
            body:JSON.stringify({
              note_title:document.getElementsByName('note_title')[0].value,
              note_content:document.getElementsByName('note_content')[0].value,
              send_id:document.getElementsByName('send_id')[0].value,
              receive_id:document.getElementsByName('receive_id')[0].value,
                send_type:'<c:out value="${type}"/>',
                receive_type:document.querySelector('input[name="receive_type"]:checked').value
            })
        }).then(response=>response.text())
        .then(text=>{
            if(text=="OK"){
                alert("전송 완료");
                window.location.href="/note/"
            }else if(text=="ERROR"){
                alert("일치하는 아이디가 없습니다.");
                $('input[name=receive_id]').focus();
            }
        }).catch(err=>{
            alert(err);
        })
    })
</script>
</body>
</html>



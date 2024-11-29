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
    input[type=text]{
        width: 98%;
    }
    td:first-child{
        text-align: center;
        width: 30%;
    }
    #writeForm{
        text-align: left;
        margin: 0 auto;
        width: 50%;
        border: 1px solid black;
    }
</style>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
    <div id="writeForm">
        <table>
        <input type="hidden" name="comname" value="${com.comname}"/>
        <input type="hidden" name="comid" value="${com.comid}"/>
        <tr><td><span>연혁</span></td><td> <input type="text" name="history"/></td></tr>
        <tr><td><span>사원수</span></td><td> <input type="text" name="people_num"/></td></tr>
        <tr><td><span>홈페이지</span></td><td> <input type="text" name="link"/></td></tr>
        <tr><td><span>내용</span></td><td><textarea name="content" cols="60" rows="20"></textarea></td></tr>
        <tr><td><button id="submit"> 작성 </button></td></tr>
        </table>
    </div>
</main>
<script>
    document.getElementById('submit').addEventListener('click',function (){

        if($('input[name=history]').val()==null||$('input[name=history]').val()==""){
            alert("연혁을 입력해주세요.");
            $('input[name=history]').focus();
            return false;
        }
        if($('input[name=people_num]').val()==null||$('input[name=people_num]').val()==""){
            alert("사원수를 입력해주세요.");
            $('input[name=people_num]').focus();
            return false;
        }
        if($('input[name=link]').val()==null||$('input[name=link]').val()==""){
            alert("홈페이지를 입력해주세요.");
            $('input[name=link]').focus();
            return false;
        }
        if($('textarea[name=content]').val()==null||$('textarea[name=content]').val()==""){
            alert("내용을 입력해주세요.");
            $('textarea[name=content]').focus();
            return false;
        }

        fetch("/com-info/write", {
            method: "POST",
            headers: {
                'Content-type': 'application/json; charset=UTF-8'
            }
            , body: JSON.stringify({
                history: document.getElementsByName('history')[0].value,
                people_num: document.getElementsByName('people_num')[0].value,
                link: document.getElementsByName('link')[0].value,
                content: document.getElementsByName('content')[0].value,
                comid: document.getElementsByName('comid')[0].value,
                comname: document.getElementsByName('comname')[0].value,
            })
        }).then(response=>response.text())
            .then(text=>{
            alert("작성 완료");
            window.location.replace(text);
        }).catch(err=>{
            console.log(err)
        })
    })
</script>
</body>
</html>



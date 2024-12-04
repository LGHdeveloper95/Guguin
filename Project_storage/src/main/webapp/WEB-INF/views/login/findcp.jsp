<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 기업비밀번호찾기</title>
    <link rel="icon" type="image/png" href="/img/favicon.png" />
    <link rel="stylesheet"  href="/css/common.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        main{
            display: grid;
            place-items: center;
            margin: 50px 0;
        }

        .clicked{
            background: #999999;
        }
        form table tr{
            height: 50px;
        }
/*        form table td{
            padding:0 10px;
        }*/

        form{
            width: 380px;
        }
        .btn{
            width: 110px;
            font-size: 13px;
        }
        .btn-light{
            width:380px;
            height: 60px;
            font-size: large;
            text-align: center;
            vertical-align: center;
        }
        span{
            font-size: 16px;
            font-weight: bold;
            color:#666666;
        }
        div{
            padding: 20px 0;
        }
    </style>
</head>
<body>
<main>
    <img src="/img/banner.png" alt="Logo" style="width: 70%; margin-top: -15%; ">

    <h2>비밀번호 찾기</h2>
<c:if test="${compw.compw eq null || empty compw.compw}">
    <div> 일치하는 아이디가 없습니다.</div>
</c:if>
    <c:if test="${compw.compw ne null && !empty compw.compw}">
        <div> 비밀번호는  <span>${compw.compw}</span>  입니다. </div>
    </c:if>
    <input type="submit" value="확인" onclick="window.close(); return false;" class="btn btn-light" >
</main>
<script>
</script>
</body>
</html>







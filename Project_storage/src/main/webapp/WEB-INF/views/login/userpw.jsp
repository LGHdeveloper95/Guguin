<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 개인비밀번호찾기</title>
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

    </style>
</head>
<body>
<main>
    <img src="/img/banner.png" alt="Logo" style="width: 70%; margin-top: -15%; ">

    <h2>비밀번호 찾기</h2>
<form action="/Login/UserPwFind" method="post">
    <div class='form-floating'>
        <input type="text" class='form-control' name="userid"  id='floatingId' placeholder="이름">
        <label for='floatingId'>아이디</label>
    </div>
    <div class='form-floating'>
        <input type="text" class='form-control' name="username"  id='floatingName' placeholder="이름">
        <label for='floatingName'>이름</label>
    </div>
    <div class='form-floating'>
        <input type="text" class='form-control' name="uphone"  id='floatingTel' placeholder="전화번호">
        <label for='floatingTel'>전화번호</label>
    </div>
    <input type="submit" class="btn btn-light" value="확인"/>
</form>
</main>
<script>
    document.getElementsByTagName('form')[0].onsubmit=()=>{
        if(document.getElementById('floatingId').value==null||document.getElementById('floatingId').value==''){
            alert("아이디를 입력해주세요.");
            return false;
        }
        if(document.getElementById('floatingName').value==null||document.getElementById('floatingName').value==''){
            alert("이름을 입력해주세요.");
            return false;
        }
        if(document.getElementById('floatingTel').value==null||document.getElementById('floatingTel').value==''){
            alert("전화번호를 입력해주세요.");
            return false;
        }
        return true;
    }

</script>
</body>
</html>







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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    main {
        margin-top: 40px;
    }

    #main {
        margin: 0 auto;
        width: 65%;
        background: #F9F9F9;
        border-radius: 10px;
        display: grid;
        grid-template-columns: 1fr 1fr;
    }

    #info_header {
        margin: 10px 10px;
        font-size: 20px;
        font-weight: 700;
    }

    #List {
        grid-column: 1 / 3;
        grid-row: 2 / 3;
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 1fr;
        margin: 0 auto;
        text-align: center;
        width: 95%;
    }
    .btn{
        background: #afe8bb;
        margin:10px;
    }
    .grid {
        margin: 50px 20px;
        padding: 10px 10px;
        border: 1px solid #AAAAAA;
        border-radius: 5px;
    }

    .grid:hover {
        transform: scale(1.1);
    }

    .grid div {
        margin: 10px 0;
    }

    .com_img {
        width: 100%;
        height: 100%;
    }

    /* 맨 위로 가기 버튼 */
    #my_remote {
        position: fixed;
        right: 20px;
        bottom: 300px;
    }

    #my_remote #top_button {
        width: 50px;
        height: 50px;
        background-color: #EFC03E;
        color: white;
        text-decoration: none;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    #my_remote #top_button:hover {
        background-color: #0056b3;
    }
</style>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<main>
    <div id="main">
        <div id="info_header">기업 정보</div>
        <c:if test="${not empty sessionScope.comid}">
            <div>
                <a href="/com-info/${sessionScope.comid}" class="btn">내 기업정보</a>
                <a href="/com-info/update/${sessionScope.comid}" class="btn" >수정</a>
            </div>
        </c:if>
        <div id="List">

        </div>
    </div>
    <div id="my_remote">
        <a href="#" id="top_button">Top</a>
    </div>
</main>
<script>

    //ajax로 값 불러오면 count 1씩 증가.
    //load_check = info를 12개씩 불러올건데 더이상 불러올 데이터가 없을 때 (infoList<12) fetch를 그만함.
    let idx = 0;
    let load_check = true
    const add_link = function () {
        document.querySelectorAll('.grid').forEach(function (card) {
            card.addEventListener('click', function () {
                window.location.href = card.getAttribute("value");
            })
        })
    }
    //info 불러오는 함수.
    const load_info = function () {
        fetch("/com-info/list/" + idx,
            {
                method: "GET",
            }
        ).then(response => response.json())
            .then(infoList => {
                if (infoList.length != 12) load_check = false;
                let output = "";
                infoList.forEach(function (info) {
                    console.log(info);
                    output += '<div class="grid" value="/com-info/' + info.comid + '"> '
                    output += '<img class="com_img" src="'+info.picture+'" alt="company_picture"/>'
                    output += '<div>' + info.comname + '</div>'
                    output += '</div>'
                })
                document.getElementById("List").innerHTML += output;
                add_link();
            }).catch(err => {
            console.log(err);
            console.dir(err);
        })


    }
    load_info();

    window.addEventListener('scroll', function () {
        var isScrollAtBottom = window.innerHeight + window.scrollY + 50 >= document.body.offsetHeight;
        if (isScrollAtBottom) {
            // 스크롤이 제일 밑으로 내려왔을 때 수행할 코드 작성
            // 예시: 새로운 데이터를 불러오는 AJAX 요청이나 추가적인 컨텐츠 보여주기 등
            if (load_check) {
                idx++;
                load_info()
            }
        }
    });

    // 맨 위로 가기 버튼
    document.getElementById('top_button').addEventListener('click', (e) => {
        e.preventDefault();
        window.scrollTo({top: 0, behavior: 'smooth'});
    });

</script>
</body>
</html>


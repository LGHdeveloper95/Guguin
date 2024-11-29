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
    .stars {
        display: flex;
        justify-content: center; /* 중앙 정렬 */
        margin: 15px 0; /* 위아래 여백 */
    }
    .explain{
        min-width: 150px;
        max-width: 150px;
        margin: 10px 10px;
    }
    .stars img {
        max-width: 30px; /* 별 크기 조정 */
        cursor: pointer; /* 커서 변경 */
        transition: transform 0.2s; /* 애니메이션 효과 */
    }

    .stars img:hover {
        transform: scale(1.2); /* 마우스 오버 시 크기 증가 */
    }

    input[type=text] {
        width: 98%;
    }

    td:first-child {
        text-align: center;
        width: 30%;
    }

    #writeForm {
        text-align: center;
        margin: 0 auto;
        width: 50%;
        border: 1px solid black;
    }
    textarea{
    }
</style>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
    <div id="writeForm">
        <button id="starSubmit">제출</button>
        <div class="stars">
            <span class="explain">복지 및 급여</span>
            <span><img alt="star" src="/img/blankStar.png" id="s0star1"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s0star2"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s0star3"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s0star4"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s0star5"></span>
        </div>
        <div class="stars">
            <span class="explain">업무와 삶의 균형</span>
            <span><img alt="star" src="/img/blankStar.png" id="s1star1"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s1star2"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s1star3"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s1star4"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s1star5"></span>
        </div>

        <div class="stars">
            <span class="explain">사내문화</span>
            <span><img alt="star" src="/img/blankStar.png" id="s2star1"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s2star2"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s2star3"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s2star4"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s2star5"></span>
        </div>

        <div class="stars">
            <span class="explain">승진 기회 및 가능성</span>
            <span><img alt="star" src="/img/blankStar.png" id="s3star1"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s3star2"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s3star3"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s3star4"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s3star5"></span>
        </div>

        <div class="stars">
            <span class="explain">경영진</span>
            <span><img alt="star" src="/img/blankStar.png" id="s4star1"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s4star2"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s4star3"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s4star4"></span>
            <span><img alt="star" src="/img/blankStar.png" id="s4star5"></span>
        </div>
        <div>
            <div>댓글</div> <textarea name="commented" cols="60" rows="13"></textarea>
        </div>
    </div>
</main>
<script>
    const starsEl = document.querySelectorAll('.stars');
    let star_val = 0;
    starsEl.forEach(function (stars, index) {
        stars.addEventListener('click', function (event) {
            let clickId = event.target.id;
            let num = clickId.split('star')[1];
            const max = 5;
            for (let i = 0; i < num; i++) {
                document.querySelector('#s' + index + 'star' + (i + 1)).src = "/img/star.png";
                star_val = i + 1;
                for (let j = 5; j > num; j--) {
                    document.querySelector('#s' + index + 'star' + j).src = "/img/blankStar.png";
                }
            }
            stars.setAttribute("value", num);
        })
    })

    document.getElementById('starSubmit').addEventListener('click', function () {
        let check = true;
        starsEl.forEach(function (stars) {
            if (stars.getAttribute("value") == null || stars.getAttribute("value") == undefined || stars.getAttribute("value") == "") {
                check = false;
            }
        })
        if (check) {
            let star_val = [];
            starsEl.forEach(function (stars) {
              star_val.push(stars.getAttribute("value"));
            })
            fetch('/com-info/review',{
                method:"POST",
                headers:{
                    'Content-type': 'application/json; charset=UTF-8'
                },
                body:JSON.stringify({
                    comid:'<c:out value="${comid}"/>',
                    welfare_val:star_val[0],
                    balance_val:star_val[1],
                    culture_val:star_val[2],
                    promotion_val:star_val[3],
                    manager_val:star_val[4],
                    commented:document.getElementsByName('commented')[0].innerHTML
                })
            }).then(response=>response.text())
            .then(res=>{
                alert("작성완료")
                window.close();
            }).catch(err=>console.log(err))
        } else {
            alert("별점을 체크해주세요");
        }
    })
</script>
</body>
</html>



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
        margin-top: 30px;
    }

    #info {
        margin: 0 auto;
        text-align: left;
        width: 60%;
        display: grid;
        grid-template-columns: 1fr 1fr;
    }

    #info_content {
        margin-top: 20px;
    }

    #info_comment {
        border: 1px solid #AAAAAA;
        grid-column: 1 / 3;
        grid-row: 2 / 3;
    }

    .comment {
        border: 1px solid #AAAAAA;
        margin: 10px 10px;
        background: #AAAAAA;
        border-radius: 6px;
    }

    .comment span {
        font-size: 12px;
        font-weight: bold;
    }

    .comment div {
        margin: 10px 10px;
        min-height: 50px;
        border-radius: 5px;
        border: 1px solid #666666;
        background: white;
    }

    .graph_box {
        width: 70%;
        margin: 10px 10px;
    }

    /*별점그래프*/
    .graph {

        width: 100%;
        background: #AAAAAA;
        margin: 10px 10px;
        height: 6px;
        border-radius: 10px;

    }

    /*별점 그래프*/
    .graph div {
        height: 6px;
        border-radius: 10px;
    }

    /*별점명 정보*/
    .star_info {
        font-size: 14px;
    }

    /*평균별점*/
    #starpoint_avg {
        font-size: 34px;
        font-weight: 750;
    }

    /*사이드바 메뉴*/
    #side {
        text-align: center;
        border-radius: 5px;
        background: #FAD673;
        position: fixed;
        top: 38px;
        min-width: 20%;
        max-width: 20%;
        min-height: 100%;
    }

    #side img {
        margin: 5px 0;
        width: 70%;
        height: 70%;
    }

    #com_info {
        text-align: left;
        margin: 10px 10px;
        font-size: 14px;
    }

    #com_info div {
        margin: 5px 0;
    }

    #com_info span {
        color: black;
        opacity: 0.5;
    }


    #side a {
        color: black;
        text-decoration: none;
        padding: 5px 5px;
    }

    .com_head {
        font-weight: 600;
        font-size: 20px;
    }

    #getRecruit {
        margin-top: 20px;
        background: #FAD6AF;
        border-radius: 5px;
        padding: 10px;
    }

    /*채용정보*/
    .recruit {
        border: 1px solid #AAAAAA;
        border-radius: 10px;
        background: #FAD6AF;
        margin: 10px auto;
        max-width: 80%;
        min-height: 80px;
    }

    .recruit a {
        font-size: 18px;
        font-weight: 650;
    }

    .recruit span {
        margin: 10px auto;
        font-size: 13px;
    }
    .bookmark_div{
        height: 40px;
    }
    /*별점영역*/
    #writeForm{
        display: none;
    }
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
        max-width: 23px; /* 별 크기 조정 */
        cursor: pointer; /* 커서 변경 */
        transition: transform 0.2s; /* 애니메이션 효과 */
    }

    .stars img:hover {
        transform: scale(1.2); /* 마우스 오버 시 크기 증가 */
    }

    /* 아이디별   테마 변경 */
    <c:if test="${empty sessionScope.userid && empty sessionScope.comid}">
    #side { background-color: #FAD673; }  </c:if>/* 비로그인 상태 */
    <c:if test="${not empty sessionScope.userid}">
    #side { background-color: #FAD673; }  </c:if>/* 개인회원 */
    <c:if test="${not empty sessionScope.comid}">
    #side { background-color: #66DD7E; } </c:if> /* 기업회원 */

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
<c:if test="${ empty info.comid && com ne null && sessionScope.comid eq com.comid}">
    <script>
        if(confirm("작성된 기업 정보가 없습니다. 작성하시겠습니까?"))
            window.location.href="/com-info/write";
    </script>
</c:if>

<c:if test="${ empty info.comid && (com eq null || sessionScope.comid==null || com.comid!=sessionScope.comid)}">
    <script>
        alert("작성된 기업 정보가 없습니다.");
        window.location.href="/com-info";
    </script>
</c:if>
<main>
    <div id="info">


        <div id="info_content">

        </div>
        <div>
            <c:if test="${not empty sessionScope.userid}">
                <div>
                    <button id="btn">리뷰쓰기</button>
                </div>
            </c:if>
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
        </div>
        <div id="info_comment">
        </div>
    </div>
    <aside id="side">

        <div id="com_info">
            <div><img src="${info.picture}" alt="company_info_img"/></div>
            <div class="com_head">${com.comname}</div>
            <div class="com_side"><span>대표자 |</span> ${com.boss}</div>
            <div class="com_side"><span>이메일 |</span> ${com.bossemail}</div>
            <div class="com_side"><span>전화번호 |</span> ${com.cphone}</div>
            <div class="com_side"><span>주소 |</span> ${com.caddr}</div>
            <div class="com_side"><span>홈페이지 |</span> <a href="${info.link}" target='_blank'>${info.link}</a></div>
            <hr>
            <div class="com_side"><span>연혁 |</span> ${info.history}</div>
            <div class="com_side"><span>사원 수|</span> ${info.people_num}</div>
            <div class="com_side"><span>소개글 |</span> ${info.content}</div>
        </div>
        <div id="book">
            <div id="yes_book" class="bookmark_div"><a href="/bookmark/${com.comid}" class="bookmark" ><img src="/img/heart.png" alt="heart" style="width: 15px;height: 15px"/> 관심 기업</a></div>
            <div id="no_book" class="bookmark_div"><a href="/bookmark/${com.comid}" class="bookmark" ><img src="/img/blankHeart.png" alt="heart" style="width: 15px;height: 15px"/> 관심 기업</a></div>
            <div id="no_login_book" class="bookmark_div"><a href="#" onclick="alert('로그인이 필요합니다;;^^')" > <img src="/img/blankHeart.png" alt="heart" style="width: 15px;height: 15px"/> 관심 기업</a></div>
            <c:if test="${ check eq 1}">
                <script>
                    document.getElementById("yes_book").style.display='block';
                    document.getElementById("no_book").style.display='none';
                    document.getElementById("no_login_book").style.display='none';
                </script>
            </c:if>
            <c:if test="${check eq 0}">
                <script>
                    document.getElementById("yes_book").style.display='none';
                    document.getElementById("no_book").style.display='block';
                    document.getElementById("no_login_book").style.display='none';
                </script>
            </c:if>
            <c:if test="${check eq -1}">
                <script>
                    document.getElementById("yes_book").style.display='none';
                    document.getElementById("no_book").style.display='none';
                    document.getElementById("no_login_book").style.display='block';
                </script>
            </c:if>

        </div>
        <a href="/com-info/post/${com.comid}" id="getRecruit" onclick="return false">채용 정보</a>
        <div id="com_menu_content">
        </div>
    </aside>
</main>
<script>

    fetch("/com-info/load/${com.comid}", {
        method: "GET"
    }).then(response => response.json())
        .then(starList => {
            //star 계산.
            if (starList.length > 0) {
                let stars = [0, 0, 0, 0, 0];
                let msg = ['복지 및 급여', '업무와 삶의 균형', '사내문화', '승진 기회 및 가능성', '경영진'];
                let comment_output = "";
                let comment_count = 0;
                starList.forEach(function (star) {
                    stars[0] += star.welfare_val;
                    stars[1] += star.balance_val;
                    stars[2] += star.culture_val;
                    stars[3] += star.promotion_val;
                    stars[4] += star.manager_val;
                    if (star.commented != null && star.commented != undefined && star.commented != 'null') {
                        comment_count++;
                        comment_output += '<div class="comment">';
                        comment_output += '<span>' + star.userid + '</span>'
                        comment_output += '<div>' + star.commented + '</div>'
                        comment_output += '</div>';
                    }
                })

                let content_output_head = '<div class="graph_box">';
                content_output_head += '<div><span>전체 리뷰 통계' + starList.length + ' 개</span></div>';
                let stars_avg = 0;
                let content_output = "";
                for (let i = 0; i < 5; i++) {
                    stars[i] = (stars[i] / starList.length);
                    stars_avg += stars[i];
                    content_output += '<div class="star_info">' + msg[i] + ' ' + stars[i].toFixed(1) + ' 점</div>';
                    content_output += '<div class="graph" ><div style="background: #1a73e8;width:' + stars[i] * 20 + '%">&nbsp;</div></div>';
                }
                content_output += '</div>';
                stars_avg = (stars_avg / 5);
                document.getElementById("info_comment").innerHTML += '<div>전체 리뷰수 ' + comment_count + '개</div><hr>' + comment_output;
                document.getElementById("info_content").innerHTML += content_output_head + '<div id="starpoint_avg">' + stars_avg.toFixed(1) + '</div>' + content_output;
            }
            //리뷰가 없을떄
            else {
                let stars = [0, 0, 0, 0, 0];
                let msg = ['복지 및 급여', '업무와 삶의 균형', '사내문화', '승진 기회 및 가능성', '경영진'];
                let comment_output = "";
                let comment_count = 0;
                let content_output = '<div class="graph_box">';
                content_output += '<div><span>전체 리뷰 통계 ' + starList.length + ' 개</span></div>';
                let stars_avg = 0;

                for (let i = 0; i < 5; i++) {

                    content_output += '<div class="star_info">' + msg[i] + ' ' + stars[i] + ' 점</div>';
                    content_output += '<div class="graph" ><div style="background: #1a73e8;width:' + stars[i] * 20 + '%">&nbsp;</div></div>';
                }
                content_output += '</div>';
                document.getElementById("info_comment").innerHTML += '<div>리뷰가 없습니다.</div>';
                document.getElementById("info_comment").innerHTML += '<div>전체 리뷰수 ' + comment_count + '개</div>' + comment_output;
                document.getElementById("info_content").innerHTML += '<div>별점이 없습니다.</div>' + content_output;
            }
        }).catch(err => console.log(err))
    document.getElementById("getRecruit").addEventListener('click', function () {
        fetch(document.getElementById("getRecruit").href, {
            method: "GET"
        }).then(response => response.json())
            .then(recruitList => {
                let output = '<div id="side_output">';
                if (recruitList.length > 0) {
                    recruitList.forEach(function (recruit) {
                        output += '<div class="recruit">'
                        //추가해야댐~~~~~~~~~~~~~~~
                        output += '<div><a href="/post/view/'+ recruit.recnum+'">' + recruit.rectitle + '</a></div>'
                        output += '<span>' + recruit.subtitle + '</span>'
                        output += '</div>'
                    })
                    output += '</div>'
                    document.getElementById("com_menu_content").innerHTML = output;
                } else {
                    output += '<div class="recruit">'
                    //추가해야댐~~~~~~~~~~~~~~~
                    output += '<h4>채용 정보가 없습니다.</h4>'
                    output += '</div>'
                    output += '</div>'
                    document.getElementById("com_menu_content").innerHTML = output;
                }
            })
    })

    document.querySelectorAll(".bookmark").forEach(function (book){
        book.addEventListener('click', function (e) {
            e.preventDefault();
            e.stopPropagation();
            fetch(document.querySelector(".bookmark").href, {
                method: "POST",
                headers: {
                    'Content-type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    value: 1
                })
            }).then(response => response.json())
                .then(result => {
                    if (result==1) {
                        document.getElementById("yes_book").style.display='none';
                        document.getElementById("no_book").style.display='block';
                        document.getElementById("no_login_book").style.display='none';

                    } else if (result==0) {
                        document.getElementById("yes_book").style.display='block';
                        document.getElementById("no_book").style.display='none';
                        document.getElementById("no_login_book").style.display='none';
                    }
                    else{
                        alert("로그인이 필요합니다.;;^^")
                    }
                })
            //return false;
        })
    })


    document.querySelector('#btn').addEventListener('click',function (e){
        console.log('click');
        fetch('/com-info/review-check/${info.comid}', {
            method: "GET"
        }).then(response => response.text())
            .then(check => {
                console.log(check)
                if (check > 0) {
                    alert("이미 작성하신 리뷰가 있습니다.")
                } else {
                    if(document.querySelector('#writeForm').style.display=='block')
                    document.querySelector('#writeForm').style.display='none'
                    else document.querySelector('#writeForm').style.display='block'
                }
            }).catch(err => console.log(err));
    })

//별점 스크립트~~~~~~~~~~~~~~~~~~~~~~~~~
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
                    commented:document.getElementsByName('commented')[0].value
                })
            }).then(response=>response.text())
                .then(res=>{
                    alert("작성완료")
                    window.location.reload();
                }).catch(err=>console.log(err))
        } else {
            alert("별점을 체크해주세요");
        }
    })
    //별점 끝~~~~~~~~~~~~~~~~~~
</script>
</body>
</html>




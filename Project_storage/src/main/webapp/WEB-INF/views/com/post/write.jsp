<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/common.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Insert title here</title>
    <style>
        #listtable {
            margin: 20px auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            max-width: 100%; /* 최대 너비 설정 */
            flex: 1; /* Flex-grow로 크기 조정 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        thead {
            background-color: #f2f2f2;
        }

        thead td {
            font-weight: bold;
            padding: 12px;
            text-align: left;
            border-bottom: 2px solid #ccc;
        }

        tbody tr {
            transition: background-color 0.3s;
        }

        tbody td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
        }

        a {
            text-decoration: none;
            color: #333;
        }

        a:hover {
            text-decoration: underline;
        }

        main {
            width: 70%;
            display: flex; /* Flexbox 사용 */
            align-items: flex-start; /* 위쪽 정렬 */
            margin: 20px auto; /* 메인 마진 추가 */
        }

        main > div {
            width: 100%;
        }

        button {
            padding: 3px 10px;
        }

        .subtitle {
            background-color: skyblue;
        }

        .content {
            height: 500px;
            vertical-align: top;
        }

        .btn {
            margin-left: 20px;
        }

        .radio {
            opacity: 0;
        }

        .radio + label {
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .radio + label:hover {
            background: #cccccc;
        }

        input[type=radio]:checked + label {
            background: #AAAAAA;
            color: white;
        }

        input[name=rectitle],
        input[name=subtitle] {
            width: 400px;
        }

        .clicked {
            background: #AAAAAA;
            color: white;
        }
        .clicked_skill:hover {
            background: #cccccc;
            opacity: 0.75;
        }

        .red {
            color: red;
        }

        #nav {
            position: fixed;
            top: 0;
            right: 0;
            background: #DDDDDD;
            height: 100vh;
            padding: 2em;
            opacity: 0.95;
            transform: translateX(100%);
            transition: transform 0.3s ease-in-out;
            overflow-y: scroll;
        }

        #nav.active {
            transform: translateX(0);
        }

        #nav ul {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        #nav ul li {
            padding: 1em 0;
        }

        #nav a {
            color: black;
            text-decoration: none;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
    <nav id="nav">
        <ul>
        </ul>
    </nav>
    <div>
        <form action="/post/write" id="postWriteForm" method="POST">
            <input type="hidden" name="comid" value="${com.comid}"/>
            <input type="hidden" name="boss" value="${com.boss}"/>
            <table>
                <thead>
                <tr>
                    <td colspan="2">
                        <c class="red">*</c>
                        공고 제목 <input type="text" name="rectitle"/></td>
                    <td>
                        <a class="noa btn btn-primary" id="list" href="/post">목록</a>
                        <a class="noa btn btn-primary" id="backup" href="/post/backup">임시저장</a>
                        <a class="noa btn btn-primary" id="backupList" href="/post/backupList">불러오기</a>
                        <a class="noa btn btn-success" id="submit" href="/post/write">등록</a>
                    </td>
                </tr>
                </thead>
                <tr>
                    <td colspan="3">
                        <c class="red">*</c>
                        부제 <input type="text" name="subtitle"/></td>
                </tr>
                <tr>
                    <td>작성일 ${today}</td>
                    <td>
                        <c class="red">*</c>
                        채용 시작일 <input type="date" name="start_date" value="${today}"></td>
                    <td>
                        <c class="red">*</c>
                        채용 마감일 <input type="date" name="deadline" value="${today}"></td>
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
                    <td colspan="2">
                        <c:forEach var="edu" items="${eduList}">
                            <input type="radio" class="radio" name="edu_code" value="${ edu.edu_code }"
                                   id="${edu.edu_name}" />
                            <label for="${edu.edu_name}"> ${edu.edu_name}</label>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td>우대 경력</td>
                    <td colspan="2">
                        <c:forEach var="career" items="${careerList}">
                            <input type="radio" class="radio" name="career_code" value="${ career.career_code }"
                                   id="${career.career_name}" />
                            <label for="${career.career_name}"> ${career.career_name}</label>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        자격증
                    </td>
                </tr>
                <tr>
                    <td colspan="3" id="licenseList">
                        <input type="text" name="license" class="license licenseCheck"/>
                        <button class="plusBtn">+</button>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">요구 기술분야</td>
                </tr>
                <tr>
                    <td>
                        <div style="height:150px;width:200px; overflow-y: scroll;">
                            <c:forEach items="${ skillCateList }" var="scate">
                                <div value="${scate.scate_code}" class="skillCate"> ${scate.scate}</div>
                            </c:forEach>
                        </div>
                    </td>
                    <td>
                        <div class="skillList" style="height: 150px; width:250px;overflow-y: scroll;display: block">
                        </div>
                    </td>
                    <td class="skill_select" style="height: 180px; width:250px;overflow-y: scroll;display: block">
                        <div><h5>선택한 기술</h5></div>

                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <c class="red">*</c>
                        근무 지역
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="max-height :150px;width:200px; overflow-y: scroll;">
                            <c:forEach items="${sidoList}" var="sido" varStatus="status">
                                <div id="sido${status.index}" value="${sido.sido_code}"
                                     class="sidoCate">${sido.sido}</div>
                            </c:forEach>
                        </div>
                    </td>
                    <td>
                        <div class="gugunList"
                             style="max-height :150px; height:150px;width:250px; display:inline-block; overflow-y: scroll;"></div>
                    </td>
                    <td class="gugun_select" style="height: 180px; width:250px;overflow-y: scroll;display: block">
                        <div><h5>선택한 지역</h5></div>
                        <input type= "hidden" name="gugun_code"/>
                    </td>
                </tr>
            </table>
            <!-- 회사소개--------------------------------------------------- -->
            <table>
                <thead>
                <tr>
                    <td colspan="3">
                        <c class="red">*</c>
                        회사 소개
                    </td>
                </tr>
                </thead>
                <tr class="content">
                    <td colspan="3">
                        <textarea name="gcontent" cols="112" rows="20"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</main>
<script>
    document.getElementsByName("career_code")[0].click();
    document.getElementsByName("edu_code")[0].click();

    let aEl = document.querySelectorAll('.noa');
    aEl.forEach(function (a) {
        a.onclick = function (e) {
            e.preventDefault();
            e.stopPropagation();
            switch (a.id) {
                case "list" :
                    window.location.href = "/post";
                    break;
                case "backup":
                    var skills ="";
                    document.getElementsByName("skill").forEach(function (item){
                        skills+=item.value+",";
                    })
                    skills = skills.substring(0, skills.length - 1);
                    let license ="";
                    document.getElementsByName("license").forEach(function (item){
                        license+=item.value+",";
                    })
                    license = license.substring(0, license.length - 1);
                    fetch(a.href, {
                        method: "POST",
                        headers: {
                            'Content-type': 'application/json; charset=UTF-8',
                        },
                        body: JSON.stringify({
                            comid: '<c:out value="${com.comid}"/>',
                            rectitle: document.getElementsByName("rectitle")[0].value,
                            subtitle: document.getElementsByName("subtitle")[0].value,
                            boss: document.getElementsByName("boss")[0].value,
                            gcontent: document.getElementsByName("gcontent")[0].value,
                            deadline: document.getElementsByName("deadline")[0].value,
                            start_date: document.getElementsByName("start_date")[0].value,
                            career_code: document.querySelector('input[name="career_code"]:checked').value,
                            edu_code:document.querySelector('input[name="edu_code"]:checked').value,
                            gugun_code: document.getElementsByName("gugun_code")[0].value,
                            license: license,
                            skills:skills
                        })
                    })
                        .then(response => response.json())
                        .then(json => {
                            alert("임시저장 되었습니다~!");
                        })
                        .catch(error => {
                            alert("저장실패");
                        })
                    break;write.jsp
                case "backupList":
                    fetch(a.href, {
                        method: "POST",
                        headers: {
                            'Content-type': 'application/json; charset=UTF-8',
                        },
                        body: JSON.stringify({
                            comid: '<c:out value="${com.comid}"/>',
                        })
                    })
                        .then(response => response.json())
                        .then(json => {
                            let btn = document.querySelector("#backup");
                            let menu = document.querySelector("#nav")
                            let output = '<a href="#" id="close">X</a>'
                            json.forEach(function (backup) {
                                output += '<li class="active"><a href="/post/backup/' + backup.rec_backnum + '">'
                                    + backup.rectitle + '</a><span>' + backup.reg_date + '</span></li>'
                            })
                            document.querySelector("#nav ul").innerHTML = output;
                            btn.classList.add("active");
                            menu.classList.add("active");
                            document.querySelector("#close").addEventListener("click", () => {
                                btn.classList.remove("active");
                                menu.classList.remove("active");
                            });
                            document.querySelectorAll("#nav ul li a").forEach(function (back) {
                                back.addEventListener("click", (e) => {
                                    e.preventDefault();
                                    e.stopPropagation();

                                    if (confirm("불러 오시겠습니까?")) {
                                        btn.classList.remove("active");
                                        menu.classList.remove("active");
                                        fetch(back.href, {
                                                method: "GET"
                                            }
                                        ).then(response => response.json())
                                            .then(map => {
                                                let skills = map.backup.skills.split(",");
                                                document.getElementsByClassName('skill_select')[0].innerHTML="<h5>선택한 기술</h5>";
                                                skills.forEach(function(skill,idx){
                                                    let clicked = '<input type="hidden" name="skill" value="'+skill+'"/>'
                                                    clicked += '<div class ="s_click" value="'+skill+'">'+map.skillList[idx]+'</div>';
                                                    document.getElementsByClassName('skill_select')[0].innerHTML+=clicked;
                                                    document.querySelectorAll(".s_click").forEach(function (i){
                                                        i.addEventListener('click',function (){
                                                            document.getElementsByName('skill').forEach(function (j){
                                                                if(j.getAttribute("value")==i.getAttribute("value")){
                                                                    j.remove();
                                                                }
                                                            })
                                                            i.remove();
                                                        })
                                                    })                                                })
                                                console.log(map.backup);
                                                document.getElementsByName("rectitle")[0].value = map.backup.rectitle;
                                                document.getElementsByName("subtitle")[0].value = map.backup.subtitle;
                                                document.getElementsByName("boss")[0].value = map.backup.boss;
                                                document.getElementsByName("gcontent")[0].value = map.backup.gcontent;
                                                document.getElementsByName("deadline")[0].value = map.backup.deadline.substring(0,10);
                                                document.getElementsByName("start_date")[0].value = map.backup.start_date.substring(0,10);
                                                document.getElementsByName("career_code")[map.backup.career_code-1].click();
                                                document.getElementsByName("edu_code")[map.backup.edu_code-1].click();
                                                const getLicenseList = map.backup.license.split(',');
                                                if(getLicenseList){
                                                    for(let i = 0; i<getLicenseList.length; i++){
                                                        let licenseEl = document.getElementsByClassName('license')[i];
                                                        licenseEl.value = getLicenseList[i];
                                                        if(getLicenseList[i+1]){
                                                            let plusBtnEl = document.querySelector('.plusBtn');
                                                            plusBtnEl.click();
                                                        }
                                                    }
                                                }
                                                let clicked="<h5>선택한 지역</h5>"
                                                clicked += '<input type="hidden" name="gugun_code" value="'+map.backup.gugun_code+'"/>'
                                                clicked += '<div class ="g_click" value="'+map.backup.gugun_code+'">'+map.region.sido+" "+map.region.gugun+'</div>';
                                                let check = true;
                                                document.querySelectorAll("input[name=gugun]").forEach(function (i){
                                                    if(i.getAttribute("value")==item.getAttribute("value"))  check=false;
                                                })
                                                if(check) document.getElementsByClassName('gugun_select')[0].innerHTML=clicked;
                                                document.querySelectorAll(".g_click").forEach(function (i){
                                                    i.addEventListener('click',function (){
                                                        document.getElementsByName('gugun_code').forEach(function (j){
                                                            if(j.getAttribute("value")==i.getAttribute("value")){
                                                                j.remove();
                                                            }
                                                        })
                                                        i.remove();
                                                    })
                                                })
                                            })
                                            .catch(error => {
                                                console.log("백업 오류입니다 : " + error)
                                                console.dir(error);
                                            })
                                    }

                                })
                            })
                        })
                        .catch(error => {
                            alert("저장실패");
                        })
            }
        }
    })

    document.querySelectorAll(".skillCate").forEach(function (item){
        item.addEventListener('click',function (){
            fetch("/post/skill/"+item.getAttribute("value"),{
                method:"GET"
            })
            .then(response=>response.json())
            .then(skillList=>{
                let output = ""
                skillList.forEach(function (skill){
                    output+='<div value="'+skill.skill_code+'" class="skill">'+skill.skill+'</div>';
                })
                    document.getElementsByClassName("skillList")[0].innerHTML = output;
                    document.querySelectorAll(".skill").forEach(function (item){
                        item.addEventListener('click',function (){
                            let clicked = '<input type="hidden" name="skill" value="'+item.getAttribute("value")+'"/>'
                                clicked += '<div class ="s_click" value="'+item.getAttribute("value")+'">'+item.innerHTML+'</div>';
                            let check = true;
                            document.querySelectorAll("input[name=skill]").forEach(function (i){
                                    if(i.getAttribute("value")==item.getAttribute("value"))  check=false;
                            })
                            if(check) document.getElementsByClassName('skill_select')[0].innerHTML+=clicked;
                            document.querySelectorAll(".s_click").forEach(function (i){
                                i.addEventListener('click',function (){
                                    document.getElementsByName('skill').forEach(function (j){
                                        if(j.getAttribute("value")==i.getAttribute("value")){
                                            j.remove();
                                        }
                                    })
                                    i.remove();
                                })
                            })
                        })
                    })
            })

        })
    })

    document.querySelectorAll(".sidoCate").forEach(function (item){
        item.addEventListener('click',function (){
            fetch("/post/region/"+item.getAttribute("value"),{
                method:"GET"
            })
                .then(response=>response.json())
                .then(gugunList=>{
                    let sido = item.innerHTML;
                    let output = ""
                    gugunList.forEach(function (gugun){
                        output+='<div value="'+gugun.gugun_code+'" class="gugun">'+gugun.gugun+'</div>';
                    })
                    document.getElementsByClassName("gugunList")[0].innerHTML = output;
                    document.querySelectorAll(".gugun").forEach(function (item){
                        item.addEventListener('click',function (){
                            let clicked="<h5>선택한 지역</h5>"
                                clicked += '<input type="hidden" name="gugun_code" value="'+item.getAttribute("value")+'"/>'
                            clicked += '<div class ="g_click" value="'+item.getAttribute("value")+'">'+sido+" "+item.innerHTML+'</div>';
                            let check = true;
                            document.querySelectorAll("input[name=gugun]").forEach(function (i){
                                if(i.getAttribute("value")==item.getAttribute("value"))  check=false;
                            })
                            if(check) document.getElementsByClassName('gugun_select')[0].innerHTML=clicked;
                            document.querySelectorAll(".g_click").forEach(function (i){
                                i.addEventListener('click',function (){
                                    document.getElementsByName('gugun_code').forEach(function (j){
                                        if(j.getAttribute("value")==i.getAttribute("value")){
                                            j.remove();
                                        }
                                    })
                                    i.remove();
                                })
                            })
                        })
                    })
                })

        })
    })

    document.getElementById('submit').addEventListener('click',function (){
        let deadline = '<c:out value="${today}"/>';
        if($('input[name=rectitle]').val()==null||$('input[name=rectitle]').val()==""){
            alert("제목을 입력해주세요.");
            $('input[name=rectitle]').focus();
            return false;
        }
        if($('input[name=subtitle]').val()==null||$('input[name=subtitle]').val()==""){
            alert("부제를 입력해주세요.");
            $('input[name=subtitle]').focus();
            return false;
        }
        if($('input[name=start_date]').val()==deadline||$('input[name=start_date]').val()<deadline){
            alert('시작일을 설정해주세요.');
            $('input[name=start_date]').focus();
            return false
        }
        if($('input[name=deadline]').val()==deadline||$('input[name=deadline]').val()<deadline){
            alert('마감일을 설정해주세요.');
            $('input[name=deadline]').focus();
            return false
        }
        if($('input[name=gugun_code]').val()==null||$('input[name=gugun_code]').val()==""){
            alert("근무 지역을 선택해주세요.");
            $('input[name=gugun_code]').focus();
            return false;
        }
        if($('textarea[name=gcontent]').val()==null||$('textarea[name=gcontent]').val()==""){
            alert("내용을 입력해주세요.");
            $('textarea[name=gcontent]').focus();
            return false;
        }



        let skills ="";
        document.getElementsByName("skill").forEach(function (item){
            skills+=item.value+",";
        })
        skills = skills.substring(0, skills.length - 1);
        let license ="";
        document.getElementsByName("license").forEach(function (item){
            if(item.value!=null&&item.value!=undefined&&item.value!='')
            license+=item.value+",";
        })
        license = license.substring(0, license.length - 1);
        fetch("/post/write",{
            method:"POST",
            headers: {
                'Content-type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                comid: '<c:out value="${com.comid}"/>',
                rectitle: document.getElementsByName("rectitle")[0].value,
                subtitle: document.getElementsByName("subtitle")[0].value,
                boss: document.getElementsByName("boss")[0].value,
                gcontent: document.getElementsByName("gcontent")[0].value,
                start_date: document.getElementsByName("start_date")[0].value,
                deadline: document.getElementsByName("deadline")[0].value,
                career_code: document.querySelector('input[name="career_code"]:checked').value,
                edu_code:document.querySelector('input[name="edu_code"]:checked').value,
                gugun_code:document.getElementsByName("gugun_code")[0].value,
                license: license,
                skills:skills,

            })
        }).then(res=>res.text())
        .then(write=>{
            alert("작성완료");
            window.location.replace(write);
        }).catch(err=>alert(err));
        return false;
    });

    //자격증 추가 삭제---------------------------------------------------------
    const licenseListEl = document.querySelector('#licenseList');
    const licenseSubmitEl = document.querySelector('#licenseSubmit');

    licenseListEl.addEventListener('click', function(event) {
        let licenseCheckEl = document.querySelectorAll('.licenseCheck');
        console.log(licenseCheckEl.length);
        //alert(event.target.previousElementSibling.value);

        if (event.target.classList.contains('plusBtn')) {
            event.preventDefault(); //button submit 방지
            event.target.remove();

            let licenseEl = document.querySelectorAll('.license');
            if(licenseEl[licenseCheckEl.length-1].value==""){
                alert('입력 후 추가해주세요');

                const newPlusButton = document.createElement('button');
                newPlusButton.className = 'plusBtn';
                newPlusButton.type = 'button';
                newPlusButton.textContent = '+';
                licenseListEl.appendChild(newPlusButton);
            }

            else if(licenseCheckEl.length < 9){
                const newInput = document.createElement('input');
                const newPlusButton = document.createElement('button');
                const newminusButton = document.createElement('button');
                newInput.className = 'license licenseCheck';
                newInput.name = 'license';
                newPlusButton.className = 'plusBtn';
                newPlusButton.type = 'button';
                newPlusButton.textContent = '+';
                newminusButton.className = 'minusBtn';
                newminusButton.textContent = '-';
                newminusButton.type = 'button';

                licenseListEl.appendChild(document.createElement('br'));
                licenseListEl.appendChild(newInput);
                licenseListEl.appendChild(newminusButton);
                licenseListEl.appendChild(newPlusButton);
            }
            else if(licenseCheckEl.length == 9){
                const newInput = document.createElement('input');
                const newminusButton = document.createElement('button');
                newInput.name = 'license';
                newInput.className = 'license';
                newInput.className = 'licenseCheck';
                newminusButton.className = 'minusBtn';
                newminusButton.textContent = '-';
                newminusButton.type = 'button';


                licenseListEl.appendChild(document.createElement('br'));
                licenseListEl.appendChild(newInput);
                licenseListEl.appendChild(newminusButton);

                const div = document.createElement('div');
                div.className = 'red warning';
                div.innerHTML = '*&nbsp;최대 10개까지 추가할 수 있습니다.';
                licenseListEl.appendChild(div);
            }
        }

        else if(event.target.classList.contains('minusBtn')){
            event.preventDefault();
            //console.log(event.target.previousElementSibling);
            const removeInput = event.target.previousElementSibling;//이전 형제 요소 찾음
            const removeBr = removeInput.previousElementSibling;

            licenseListEl.removeChild(removeInput);
            licenseListEl.removeChild(removeBr);
            event.target.remove();

            if(licenseCheckEl.length == 10){
                const warningEl = document.querySelector('.warning');
                //console.log(warningEl);
                warningEl.remove();

                const newPlusButton = document.createElement('button');
                newPlusButton.className = 'plusBtn';
                newPlusButton.type = 'button';
                newPlusButton.textContent = '+';

                licenseListEl.appendChild(newPlusButton);
            }
        }
    });
</script>
</body>
</html>



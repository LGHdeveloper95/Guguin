<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>사람과 기업을 연결하는 구구인</title>
  <link rel="icon" type="image/png" href="/img/favicon.ico" />
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    main { display: flex; justify-content: center; margin-top: 30px; }
    .table{
    border: 1px solid #dee2e6; 
    width: 100%;
    }
	/* 제목 셀의 첫 번째 항목에 스타일 적용 */
	.subtitle td:first-of-type {
	    background-color: rgb(253, 241, 211);
	    padding: 5px;  /* 패딩 줄이기 */
	}
    .table th, .table td {
	  padding: 10px;             /* 셀 안쪽 패딩을 설정하여 내용이 겹치지 않도록 */
	  text-align: center;        /* 텍스트 중앙 정렬 */
	  border: 1px solid rgb(255, 194, 62); /* 셀 테두리 색상 설정 */
	}
	thead { background-color: #FAD673; /* 헤더의 배경색 설정 */ }
	.subtitle td:first-of-type{ background-color: rgb(253, 241, 211); }
	.shadow{ box-shadow:  5px 5px 15px 5px rgba(0, 0, 0, 0.3); }
	.red { color: red; }
	.btn { background-color: white; color: rgb(83, 83, 83); }
	thead input{ width: 50%; margin-right: 120px;}
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
  img {
    max-width: 200px;
  }
  </style>
</head>
<body>
  <!-- jQuery (Bootstrap 5는 jQuery 의존성이 없지만, AJAX 등 사용을 위해 추가) -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  <%@include file="/WEB-INF/include/header.jsp" %>
  <main>
    <%@include file="/WEB-INF/include/mypageSide.jsp" %>
	  <div class="main">
	    <h5>이력서 수정</h5>
	    <nav id="nav">
          <ul>
          </ul>
        </nav>
      <div>
       <form action="" id="resumeWriteForm" method="POST" enctype="multipart/form-data">
           <input type="hidden" name="userid" value="${ user.userid }"/>
           <input type="hidden" name="username" value="${ user.username }"/>
           <input type="hidden" name="uphone" value="${ user.uphone }"/>
           <input type="hidden" name="email" value="${ user.email }"/>
           <input type="hidden" name="uaddr" value="${ user.uaddr }"/>
           <input type="hidden" name="gender" value="${ user.gender }"/>
           <table class="table shadow info">
               <thead>
               <tr>
                   <td colspan="3" class="between">
                     <span>
                       <span class="red">*</span>
                       이력서 제목 <input type="text" name="restitle" value="${ resume.restitle }"/>
                     </span>
                     <span>
                       <a class="noa btn btn-outline-warning" id="list" href="/user/resume">목록</a>
                       <a class="noa btn btn-outline-warning" id="submit" href="/user/resume/insert">수정</a>
                     </span>
                   </td>
               </tr>
               </thead>
               <tr>
                   <td rowspan="6" class="profile">
                       <img id="picturePreview" src="" alt="미리보기 이미지"><br>
                       <span class="red">*</span>
                       <input type="file" id="fileInput" name="picture" accept="image/*">
                   </td>
               </tr>
               <tr class="subtitle">
                   <td id="date">작성일</td>
                   <td>${ resume.reg_date }</td>
               </tr>
               <tr class="subtitle">
                   <td>성명</td>
                   <td>${ user.username } </td>
               </tr>
               <tr class="subtitle">
                   <td>연락처</td>
                   <td>${ user.uphone }</td>
               </tr>
               <tr class="subtitle">
                   <td>이메일</td>
                   <td>${ user.email }</td>
               </tr>
               <tr class="subtitle">
                   <td>주소</td>
                   <td>${ user.uaddr }</td>
               </tr>
               <tr class="subtitle">
                   <td>최종 학력</td>
                   <td colspan="2">
                       <c:forEach var="edu" items="${eduList}">
                           <input type="radio" class="radio" name="edu_code" value="${ edu.edu_code }"
                                  id="${edu.edu_name}"/>
                           <label for="${edu.edu_name}"> ${edu.edu_name}</label>
                       </c:forEach>
                   </td>
               </tr>
               <tr class="subtitle">
                 <td>학력 세부사항</td>
                 <td colspan="2"><input type="text" name="edu_content" value="${ resume.edu_content }"/></td>
               </tr>
               <tr class="subtitle">
                   <td>경력</td>
                   <td colspan="2">
                       <c:forEach var="career" items="${careerList}">
                           <input type="radio" class="radio" name="career_code" value="${ career.career_code }"
                                  id="${career.career_name}"/>
                           <label for="${career.career_name}"> ${career.career_name}</label>
                       </c:forEach>
                   </td>
               </tr>
               <tr class="subtitle">
                 <td>경력 세부사항</td>
                 <td colspan="2"><input type="text" name="career_content" value="${ resume.career_content }"/></td>
               </tr>
               <tr class="subtitle">
                    <td colspan="3">
                        자격증
                    </td>
                </tr>
                <tr>
                    <td colspan="3" id="licenseList">
                      <div class="lastLicense">
                        <button class="plusBtn btn btn-warning">+</button>
                        <input type="text" name="license" class="license licenseCheck"/>
                      </div>
                    </td>
                </tr>
               
               <tr class="subtitle">
                   <td colspan="3">기술분야</td>
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
                        <input type="hidden" name="skill" />

                   </td>
               </tr>
               <tr class="subtitle">
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
                        <input type="hidden" name="gugun_code"/>
                   </td>
               </tr>
           </table>
           <!-- 자기소개서--------------------------------------------------- -->
		    <table class="table shadow">
		      <thead>
		        <tr>
		          <td colspan="3">자기소개서</td>
		        </tr>
		      </thead>
		      <tr class="subtitle"><td colspan="3">성장배경</td></tr>
		      <tr class="content"><td colspan="3">
		        <textarea name="background" class="fullBox"></textarea>
		      </td></tr>
		      <tr class="subtitle"><td colspan="3">성격의 장단점</td></tr>
		      <tr class="content"><td colspan="3">
		        <textarea name="personality" class="fullBox"></textarea>
		      </td></tr>
		      <tr class="subtitle"><td colspan="3">지원동기</td></tr>
		      <tr class="content"><td colspan="3">
		        <textarea name="motivation" class="fullBox"></textarea>
		      </td></tr>
		    </table>
       </form>
   </div>
  </div>
</main>
<script>
function img (resnum) {
  	const imgEl = document.querySelector('#picturePreview');
  	console.log(resnum);
    const fileUrl = "http://192.168.0.214:9090/download/";
    $.ajax({
  	  url: fileUrl+resnum,
  	  method: "GET"
    }).done(files => {
    	console.log(files[0]);
  	  imgEl.setAttribute("src",files[0]);
    }).fail(error => {
     console.log(error);
    })
  }
   window.onload = function(){
	   let href="/user/resume/"+'${resume.resnum}';
	   fetch(href, {
           method: "GET"
       }).then(response => response.json())
       .then(map => {
           console.log(map.resume);
           document.getElementsByName("restitle")[0].value = map.resume.restitle;
           //document.getElementsByName("picture")[0].value = map.resume.picture;
           document.getElementsByName("career_code")[map.resume.career_code-1].click();
           document.getElementsByName("edu_code")[map.resume.edu_code-1].click();
           document.getElementsByName("edu_content")[0].value = map.resume.edu_content;
           document.getElementsByName("career_content")[0].value = map.resume.career_content;
           document.getElementsByName("motivation")[0].value = map.resume.motivation;
           document.getElementsByName("background")[0].value = map.resume.background;
           document.getElementsByName("personality")[0].value = map.resume.personality;
           //-------------------스킬-------------
           let skills = map.resume.skills.split(",");
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

           //-------------------자격증-------------
           const getLicenseList = map.resume.license.split(',');
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

           //-------------------지역-------------
           let clicked="<h5>선택한 지역</h5>"
           clicked += '<input type="hidden" name="gugun_code" value="'+map.resume.gugun_code+'"/>'
           clicked += '<div class ="g_click" value="'+map.resume.gugun_code+'">'+map.region.sido+" "+map.region.gugun+'</div>';
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
           img(map.resume.resnum);
       })
       .catch(error => {
            console.log(error)
            console.dir(error)
       })
   }
    document.querySelectorAll(".skillCate").forEach(function (item){
        item.addEventListener('click',function (){
            fetch("/user/resume/skill/"+item.getAttribute("value"),{
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
            fetch("/user/resume/region/"+item.getAttribute("value"),{
                method:"GET"
            })
                .then(response=>response.json())
                .then(gugunList=>{
                    let output = ""
                    gugunList.forEach(function (gugun){
                        output+='<div value="'+gugun.gugun_code+'" class="gugun">'+gugun.gugun+'</div>';
                    })
                    document.getElementsByClassName("gugunList")[0].innerHTML = output;
                    document.querySelectorAll(".gugun").forEach(function (item){
                        item.addEventListener('click',function (){
                            let clicked="<h5>선택한 지역</h5>"
                                clicked += '<input type="hidden" name="gugun_code" value="'+item.getAttribute("value")+'"/>'
                            clicked += '<div class ="g_click" value="'+item.getAttribute("value")+'">'+item.innerHTML+'</div>';
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

    document.getElementById('submit').addEventListener('click',function (e){
    	e.preventDefault();
    	
        if($('input[name=restitle]').val()==null||$('input[name=restitle]').val()==""){
            alert("제목을 입력해주세요.");
            $('input[name=restitle]').focus();
            return false;
        }
        if($('input[name=gugun_code]').val()==null||$('input[name=gugun_code]').val()==""){
            alert("근무 지역을 선택해주세요.");
            $('input[name=gugun_code]').focus();
            return false;
        }
        if($('textarea[name=background]').val()==null||$('textarea[name=background]').val()==""){
            alert("성장배경을 입력해주세요.");
            $('textarea[name=background]').focus();
            return false;
        }
        if($('textarea[name=personality]').val()==null||$('textarea[name=personality]').val()==""){
            alert("성격의 장단점을 입력해주세요.");
            $('textarea[name=personality]').focus();
            return false;
        }
        if($('textarea[name=motivation]').val()==null||$('textarea[name=motivation]').val()==""){
            alert("지원동기를 입력해주세요.");
            $('textarea[name=motivation]').focus();
            return false;
        }

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
          const resnum = "${resume.resnum}";
          console.log(resnum);
          var formData = new FormData();
          if(document.getElementById("fileInput") != null){
          formData.append("file", document.getElementById("fileInput").files[0]);
          }
          formData.append("resnum", resnum);
          formData.append("userid", '<c:out value="${user.userid}"/>');
          formData.append("restitle", document.getElementsByName("restitle")[0].value);
          formData.append("username", document.getElementsByName("username")[0].value);
          formData.append("uphone", document.getElementsByName("uphone")[0].value);
          formData.append("email", document.getElementsByName("email")[0].value);
          formData.append("gender", document.getElementsByName("gender")[0].value);
          formData.append("career_code", document.querySelector('input[name="career_code"]:checked').value);
          formData.append("career_content", document.getElementsByName("career_content")[0].value);
          formData.append("edu_code", document.querySelector('input[name="edu_code"]:checked').value);
          formData.append("edu_content", document.getElementsByName("edu_content")[0].value);
          formData.append("background", document.getElementsByName("background")[0].value);
          formData.append("personality", document.getElementsByName("personality")[0].value);
          formData.append("motivation", document.getElementsByName("motivation")[0].value);
          formData.append("license", license);
          formData.append("skills", skills);
          formData.append("gugun_code", document.getElementsByName("gugun_code")[0].value);

        fetch("http://192.168.0.214:9090/User/Mypage/Resume/Update",{
        	method: "POST",
            body: formData
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
        
        //부수자재-----------------
        const newInput = document.createElement('input');
        newInput.className = 'license licenseCheck';
        newInput.name = 'license';
        const newPlusButton = document.createElement('button');
        newPlusButton.className = 'plusBtn btn btn-warning';
        newPlusButton.type = 'button';
        newPlusButton.textContent = '+';
        const newminusButton = document.createElement('button');
        newminusButton.className = 'minusBtn btn btn-warning';
        newminusButton.textContent = '-';
        newminusButton.type = 'button';
        const nbsp = document.createTextNode('\u00A0');
        const newDiv = document.createElement('div');
        newDiv.className = 'lastLicense';
        newDiv.appendChild(newminusButton);
        newDiv.appendChild(newPlusButton);
        newDiv.appendChild(nbsp);
        newDiv.appendChild(newInput);

        let licenseEl = document.querySelectorAll('.license');
        let lastLicenseEl = licenseEl[licenseEl.length - 1];
        
      //함수----------------------
      function plusBtn(target){
          	if(licenseEl[licenseCheckEl.length-1].value==""){
                  alert('입력 후 추가해주세요');
                  return false;
          	}
          	else if(licenseCheckEl.length == 9){
          		 target.parentNode.classList.remove('lastLicense');
                  newDiv.removeChild(newPlusButton);
                  licenseListEl.appendChild(newDiv);
                  const warning = document.createElement('div');
                  warning.className = 'red warning';
                  warning.innerHTML = '*&nbsp;최대 10개까지 추가할 수 있습니다.';
                  licenseListEl.appendChild(warning);
              }
          	else{
          		target.parentNode.classList.remove('lastLicense');
          		target.parentNode.removeChild(target.parentNode.querySelector('.plusBtn'));
          		licenseListEl.appendChild(newDiv);
              }
          }
      
        function minusBtn(target){
        	const targetPre = target.parentNode.previousElementSibling;
        	
        	if(target.parentNode.classList.contains('lastLicense')){
        		//console.log('hihi');
        		console.log(targetPre.querySelector('.minusBtn'));
        		targetPre.insertBefore(newPlusButton, targetPre.querySelector('input'));
        		target.parentNode.remove();
        	}
        	else{
        		target.parentNode.remove();
        	}
        }
        //함수 end---------------------------
        
      //+버튼 클릭시---------------------------
      if (event.target.classList.contains('plusBtn')) {
          event.preventDefault(); //button submit 방지
          plusBtn(event.target);
      }

    //-버튼 클릭시---------------------------
      else if(event.target.classList.contains('minusBtn')) {
          event.preventDefault();
          minusBtn(event.target);
      }

    });
    //파일 업로드시 미리보기 이미지 변경
    const imgPreView = document.querySelector('#picturePreview');
    const fileInput = document.querySelector('[name = "picture"]');
    fileInput.addEventListener('change', function(event){
    	let file = event.target.files[0];
    	console.log(file);
    	const reader = new FileReader();
        reader.onload = function(e) {
        	imgPreView.src = e.target.result; // 이미지 소스를 로드한 결과로 설정
        	imgPreView.style.display = 'block'; // 이미지가 로드되면 표시
        };
        reader.readAsDataURL(file);
    })
    


</script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
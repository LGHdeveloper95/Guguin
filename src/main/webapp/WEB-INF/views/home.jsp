<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* 전체 페이지 스타일 */
        body {
            margin: 0; /* 페이지의 기본 여백 제거 */
            padding: 0; /* 페이지의 기본 패딩 제거 */
            font-family: Arial, sans-serif; /* 기본 폰트 설정 */
             text-align: center; /* 텍스트를 중앙 정렬 */
        }
       .homeBox {
            max-width: 80%;
            margin: 40px auto;
            margin-top: 65px;
            margin-bottom: 70px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
          }
        
        
        
            /* 모든 요소에 상속된 박스 모델 설정 */
    *, *:before, *:after {
        box-sizing: inherit; /* 부모의 box-sizing을 상속 */
    }

    /* clearfix를 위한 유틸리티 클래스 */
    .clearfix:after {
        content: ''; /* 콘텐츠가 없는 더미 요소 생성 */
        display: block; /* 블록 요소로 설정 */
        clear: both; /* 플로트를 초기화 */
        float: none; /* 플로트 제거 */
    }

    /* 제목 스타일 */
    .title {
        margin-bottom: 0; /* 하단 여백 제거 */
        text-align: center; /* 텍스트 중앙 정렬 */
        font-size: 30px; /* 폰트 크기 설정 */
        color: #333; /* 텍스트 색상 */
    }

    /* 링크 기본 스타일 및 방문 후 스타일 */
    .link, .link:visited {
        display: inline-block; /* 인라인 블록으로 표시 */
        margin: 20px 0; /* 상단과 하단 여백 설정 */
        color: #555; /* 링크 텍스트 색상 */
        text-decoration: none; /* 밑줄 제거 */
        font-weight: bold; /* 폰트 두께 설정 */
    }

    /* 링크 호버 및 포커스 시 스타일 */
    .link:hover, .link:focus {
        color: #9fd6c2; /* 호버 및 포커스 시 텍스트 색상 변경 */
    }

    /* 컨테이너 설정 */
    #container {
        width: 1000px; /* 컨테이너 너비 */
        margin: auto; /* 화면 중앙 정렬 */
    }


    /* 슬라이드 콘텐츠 설정 */
    .slide_content {
        display: table; /* 테이블 레이아웃 */
        float: left; /* 왼쪽 정렬 */
        width: 1000px; /* 슬라이드 콘텐츠 너비 */
        height: 320px; /* 슬라이드 콘텐츠 높이 */
    }
    /* 슬라이드 전체 래퍼 */
    .slide_wrap {
        position: relative; /* 버튼과 페이지네이션 배치를 위한 상대 위치 */
        width: 100%; /* 부모의 전체 너비 사용 */
        margin: auto; /* 화면 중앙 정렬 */
        padding-bottom: 30px; /* 하단 여백 추가 */
    }

    /* 슬라이드 박스 - 콘텐츠가 스크롤되지 않도록 숨김 */
    .slide_box {
        width: 1000px; /* 슬라이드 박스의 너비 */
        height:320px;
        margin: auto; /* 가운데 정렬 */
        margin-top: 50px; /* 위 여백 */
        scroll: no; /* 스크롤바 제거 */
        border: 3px gray solid; /* 회색 테두리 */
        border-radius: 10px; /* 둥근 모서리 */
        overflow: hidden; /* 내용이 박스 밖으로 넘치지 않도록 설정 */
    }



    /* 슬라이드 이미지 설정 */
       .slide_content img {
        width: 100%; /* 이미지 너비를 슬라이드에 맞춤 */
        height: 100%; /* 이미지 높이를 슬라이드에 맞춤 */
        object-fit: cover; /* 이미지 왜곡 없이 박스 크기에 맞춤 */
    }


    /* 슬라이드 버튼 기본 스타일 */
     .slide_btn_box > button {
        position: relative; /* 기본 위치 기준으로 상대적 배치 */
        bottom: 30px; /* 버튼을 아래로 이동 */
        width: 45px; /* 버튼 너비 */
        height: 25px; /* 버튼 높이 */
        font-size: 16px; /* 글자 크기 */
        border-radius: 50px; /* 둥근 모서리 */
        color: #FFF; /* 버튼 글자 색상 */
        background-color: rgba(20, 20, 20, 0.2); /* 반투명 배경색 */
        border: 1px solid #FFF; /* 흰색 테두리 */
    }


    /* 이전 버튼 위치 */
      .slide_btn_box > .slide_btn_prev {
        left: -269px; /* 왼쪽으로 버튼 이동 */
    }


    /* 다음 버튼 위치 */
      .slide_btn_box > .slide_btn_next {
        right: -269px; /* 오른쪽으로 버튼 이동 */
    }



    /* 슬라이드 페이지네이션 (하단 점) */
    .slide_pagination {
        position: absolute; /* 부모 기준으로 위치 설정 */
        left: 50%; /* 가로 가운데 정렬 */
        bottom: 60px; /* 아래로 60px 이동 */
        list-style: none; /* 리스트 점 제거 */
        margin: 0; /* 리스트 마진 제거 */
        padding: 0; /* 리스트 패딩 제거 */
        transform: translateX(-50%); /* 중앙 정렬 */
    }


    /* 페이지네이션 점 스타일 */
   .slide_pagination .dot {
        display: inline-block; /* 인라인 블록 */
        width: 15px; /* 점 너비 */
        height: 15px; /* 점 높이 */
        margin: 0 5px; /* 좌우 간격 */
        border: 1px rgba(20, 20, 20, 0.4) solid; /* 회색 반투명 테두리 */
        background: rgba(240, 240, 240, 0.5); /* 점의 배경색 */
        border-radius: 50%; /* 점을 원 모양으로 */
        transition: 0.3s; /* 부드러운 전환 효과 */
    }


    /* 활성화된 페이지네이션 점 스타일 */
     .slide_pagination .dot.dot_active {
        background: rgba(20, 20, 20, 0.6); /* 활성화된 점의 배경색 */
    }


    /* 페이지네이션 점 내부 링크 */
    .slide_pagination .dot a {
        display: block; /* 블록 요소로 설정 */
        width: 100%; /* 부모의 너비를 가짐 */
        height: 100%; /* 부모의 높이를 가짐 */
    }

        
 .grid-section {
        margin: 50px auto; /* 섹션 전체 위, 아래 여백 설정 */
        max-width: 1300px; /* 전체 그리드 섹션의 최대 너비 */
    }

    .grid-title {
        font-size: 24px; /* 제목 글꼴 크기 */
        font-weight: bold; /* 글꼴 두께 설정 */
        color: #333; /* 제목 글자 색상 */
        margin-bottom: 20px; /* 제목과 그리드 사이의 간격 */
        text-align: left; /* 제목 왼쪽 정렬 */
    }

    .grid-container {
    display: grid;
    grid-template-columns: repeat(5, 1fr); /* 한 줄에 5개 */
    gap: 20px; /* 칸 간의 간격 */
    justify-content: center;
    margin: 0 auto; /* 그리드 중앙 정렬 */
    padding: 20px; /* 그리드 내부 여백 */
    max-width: 1300px; /* 최대 너비 설정 */
}

.card {
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    text-align: center;
    display: flex;
    flex-direction: column; /* 세로 정렬 */
}

.card-img-top {
/*     width: 100%;
 */    /* height: 160px; */ /* 고정된 높이 */
    
/*     object-fit: cover; */ /* 이미지 비율 유지 */
}

.card-body {
    padding: 10px;
    flex: 1; /* 남은 공간 채우기 */
}

.card-title {
    font-size: 16px;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
    text-align: left;
}

.card-text {
    font-size: 14px;
    color: #666;
     text-align: left;
}
       /* 우측 리모컨 스타일 */
.remote-control {
    border: 2px solid #6c757d;
    border-radius: 5px;
    position: fixed; /* 화면의 고정 위치 */
    top: 70px; /* 위쪽에서 70px 떨어짐 */
    width: 103px; /* 리모컨 너비 */
    height: 364px; /* 리모컨 높이 */
    right: 20px; /* 오른쪽에서 20px 떨어짐 */
    display: flex; /* Flexbox로 레이아웃 설정 */
    flex-direction: column; /* 버튼을 세로 방향으로 나열 */
    gap: 10px; /* 버튼 간 간격 */
    justify-content: center; /* 리모컨 내부 버튼들을 수직 중앙 정렬 */
    align-items: center; /* 버튼을 가로 중앙 정렬 */
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


/* 버튼 스타일 */
.remote-control button {
    border: 2px solid #6c757d; /* 버튼 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    background-color: white; /* 버튼 배경 색상 */
    color: #6c757d; /* 버튼 텍스트 색상 */
    padding: 10px 15px; /* 버튼 내부 여백 */
    font-size: 14px; /* 텍스트 크기 */
    cursor: pointer; /* 커서를 포인터 모양으로 */
    width: 80px; /* 버튼 너비 */
    height: 120px; /* 버튼 높이 */
    display: flex; /* Flexbox로 버튼 내용 정렬 */
    justify-content: center; /* 버튼 텍스트 수평 중앙 정렬 */
    align-items: center; /* 버튼 텍스트 수직 중앙 정렬 */
}
    </style>
</head>
<body>
    <%@include file="/WEB-INF/include/header.jsp" %>
<div class="homeBox" >
    <!-- 상단 캐러셀 -->
  <div id="container">
  <!-- 페이지의 메인 콘텐츠를 담는 컨테이너 역할 -->

  <div class="slide_wrap">
    <!-- 슬라이드 전체를 감싸는 래퍼 요소 -->
    
    <div class="slide_box">
      <!-- 슬라이드 박스: 슬라이드 콘텐츠를 보여주는 영역 -->
      
      <div class="slide_list clearfix" style= "transition: 300ms">
         <!-- 슬라이드 목록: 여러 슬라이드 콘텐츠를 포함 -->
         <!-- style="transition: 300ms"은 슬라이드가 이동할 때 부드러운 애니메이션 효과를 설정 -->
         
         <div class="slide_content slide01">
           <!-- 개별 슬라이드 콘텐츠 -->
           <img src="/img/ca.png">
           <!-- 이미지 추가: 슬라이드 1의 콘텐츠 -->
         </div>
         
         <div class="slide_content slide02">
           <img src="/img/cb.png">
           <!-- 슬라이드 2의 이미지 -->
         </div>
         
         <div class="slide_content slide03">
           <a href="/calendar">
           <img src="/img/cc.png">
           </a>
           <!-- 슬라이드 3의 이미지 -->
         </div>
         
         <div class="slide_content slide04">
           <img src="/img/cd.png">
           <!-- 슬라이드 4의 이미지 -->
         </div>
         
         <div class="slide_content slide05">
           <img src="/img/ce.png">
           <!-- 슬라이드 5의 이미지 -->
         </div>
      </div>
    </div>

    <div class="slide_btn_box">
    <!-- 슬라이드 버튼을 포함하는 박스 -->
    
    <button type="button" class="slide_btn_prev">&larr;</button>
    <!-- 이전 슬라이드로 이동하는 버튼. &larr;는 화살표(←) 문자입니다. -->
    
    <button type="button" class="slide_btn_next">&rarr;</button>
    <!-- 다음 슬라이드로 이동하는 버튼. &rarr;는 화살표(→) 문자입니다. -->
    </div>

    <ul class="slide_pagination">
    <!-- 슬라이드 하단에 위치한 페이지네이션(점 표시) -->

    <li class="dot" data-index="0">
      <a href="#"></a>
      <!-- 첫 번째 슬라이드를 나타내는 점 -->
    </li>
    
    <li class="dot" data-index="1">
      <a href="#"></a>
      <!-- 두 번째 슬라이드를 나타내는 점 -->
    </li>
    
    <li class="dot" data-index="2">
      <a href="#"></a>
      <!-- 세 번째 슬라이드를 나타내는 점 -->
    </li>
    
    <li class="dot" data-index="3">
      <a href="#"></a>
      <!-- 네 번째 슬라이드를 나타내는 점 -->
    </li>
    
    <li class="dot" data-index="4">
      <a href="#"></a>
      <!-- 다섯 번째 슬라이드를 나타내는 점 -->
    </li>
    </ul>
  </div>
</div>

 <!-- 하단 그리드 -->
  <div class="grid-section">
        <div class="grid-title">핫한 공고 TOP 10 🔥</div>
        <div class="grid-container">
            <c:forEach var="rec" items="${recList}">
                <div class="card">
                    <img src="${rec.picture}" class="card-img-top" alt="공고 이미지">
                    <div class="card-body">
                        <h5 class="card-title">${rec.rectitle}</h5>
                        <p class="card-text"><a href="/post/view/${rec.recnum}" >${rec.comname}</a></p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
</div>
    
    
    
    <!-- 우측 리모컨 -->
    <div id="my_remote">
		<a href="#" id="top_button">Top</a>
	</div>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
   <script>

   (function () {
		  // 슬라이드 관련 DOM 요소 선택
		  const slideList     = document.querySelector('.slide_list');      // 슬라이드 전체 리스트를 감싸는 요소
		  const slideContents = document.querySelectorAll('.slide_content'); // 개별 슬라이드들
		  const slideBtnNext  = document.querySelector('.slide_btn_next');   // 다음 버튼
		  const slideBtnPrev  = document.querySelector('.slide_btn_prev');   // 이전 버튼
		  const pagination    = document.querySelector('.slide_pagination'); // 페이지네이션 컨테이너
		  const slideLen      = slideContents.length;                        // 슬라이드 개수
		  const slideWidth    = 1000;                                         // 슬라이드 하나의 너비
		  const slideSpeed    = 400;                                         // 슬라이드 애니메이션 속도(ms)
		  const startNum      = 0;                                           // 초기 슬라이드 인덱스
		  const autoSlideInterval = 5000;                                   // 자동 슬라이드 간격(ms)
		  let autoSlideTimer;                                               // 자동 슬라이드 타이머 변수
		  
		  //  리모컨 
		  document.getElementById('top_button').addEventListener('click', (e) => {
		        e.preventDefault();
		        window.scrollTo({ top: 0, behavior: 'smooth' });
		    });

		  // 슬라이드 리스트의 너비를 설정 (슬라이드 개수 + 앞뒤 복제 슬라이드)
		  slideList.style.width = slideWidth * (slideLen + 2) + "px";

		  // 슬라이드 첫 번째와 마지막 항목 복제
		  let firstChild  = slideList.firstElementChild;
		  let lastChild   = slideList.lastElementChild;
		  let clonedFirst = firstChild.cloneNode(true);
		  let clonedLast  = lastChild.cloneNode(true);
		  slideList.appendChild(clonedFirst);                                // 첫 번째 슬라이드 복제본을 끝에 추가
		  slideList.insertBefore(clonedLast, slideList.firstElementChild);   // 마지막 슬라이드 복제본을 맨 앞에 추가

		  // 페이지네이션 버튼 동적 생성
		  let pageChild = '';
		  for (let i = 0; i < slideLen; i++) {
		    pageChild += '<li class="dot';
		    pageChild += (i === startNum) ? ' dot_active' : '';              // 초기 활성화된 페이지네이션 설정
		    pageChild += '" data-index="' + i + '"><a href="#"></a></li>';
		  }
		  pagination.innerHTML = pageChild;                                 // 페이지네이션 컨테이너에 추가
		  const pageDots = document.querySelectorAll('.dot');               // 페이지네이션 버튼 요소

		  // 초기 슬라이드 위치 설정 (첫 번째 슬라이드로 이동)
		  slideList.style.transform = "translate3d(-" + (slideWidth * (startNum + 1)) + "px, 0px, 0px)";
		  let curIndex = startNum;                                          // 현재 슬라이드 인덱스
		  let curSlide = slideContents[curIndex];                           // 현재 활성화된 슬라이드
		  curSlide.classList.add('slide_active');                           // 활성화된 슬라이드에 클래스 추가

		  /** 자동 슬라이드 시작 */
		  function startAutoSlide() {
		    stopAutoSlide();                                                // 기존 자동 슬라이드 타이머 중지
		    autoSlideTimer = setInterval(() => {
		    	slideBtnNextClick();
		    	}, autoSlideInterval);
		  }

		  /** 자동 슬라이드 중지 */
		  function stopAutoSlide() {
		    clearInterval(autoSlideTimer);                                  // 타이머 제거
		  }
		 let slideBtnNextClick=function(){
			 stopAutoSlide();                                                // 버튼 클릭 시 자동 슬라이드 중지
			    if (curIndex <= slideLen - 1) {                                 // 마지막 슬라이드가 아닐 때
			      slideList.style.transition = slideSpeed + "ms";               // 애니메이션 속도 설정
			      slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 2)) + "px, 0px, 0px)";
			    }
			    if (curIndex === slideLen - 1) {                                // 마지막 슬라이드일 때
			      setTimeout(function() {
			        slideList.style.transition = "0ms";                         // 애니메이션 효과 제거
			        slideList.style.transform = "translate3d(-" + slideWidth + "px, 0px, 0px)";
			      }, slideSpeed);
			      curIndex = -1;                                                // 인덱스 초기화
			    }
			    curSlide.classList.remove('slide_active');                      // 기존 활성화 슬라이드 비활성화
			    pageDots[(curIndex === -1) ? slideLen - 1 : curIndex].classList.remove('dot_active'); // 기존 페이지네이션 비활성화
			    curSlide = slideContents[++curIndex];                           // 다음 슬라이드로 이동
			    curSlide.classList.add('slide_active');                         // 새로운 슬라이드 활성화
			    pageDots[curIndex].classList.add('dot_active');                 // 새로운 페이지네이션 활성화
			    startAutoSlide();                                               // 자동 슬라이드 재개
		 }                                         // 다음 버튼 클릭 이벤트 호출


		  /** 다음 버튼 클릭 이벤트 */
		  slideBtnNext.addEventListener('click',slideBtnNextClick);

		  /** 이전 버튼 클릭 이벤트 */
		  slideBtnPrev.addEventListener('click', function() {
		    stopAutoSlide();                                                // 버튼 클릭 시 자동 슬라이드 중지
		    if (curIndex >= 0) {                                            // 첫 슬라이드가 아닐 때
		      slideList.style.transition = slideSpeed + "ms";
		      slideList.style.transform = "translate3d(-" + (slideWidth * curIndex) + "px, 0px, 0px)";
		    }
		    if (curIndex === 0) {                                           // 첫 슬라이드일 때
		      setTimeout(function() {
		        slideList.style.transition = "0ms";
		        slideList.style.transform = "translate3d(-" + (slideWidth * slideLen) + "px, 0px, 0px)";
		      }, slideSpeed);
		      curIndex = slideLen;                                          // 인덱스를 마지막으로 초기화
		    }
		    curSlide.classList.remove('slide_active');                      // 기존 슬라이드 비활성화
		    pageDots[(curIndex === slideLen) ? 0 : curIndex].classList.remove('dot_active'); // 기존 페이지네이션 비활성화
		    curSlide = slideContents[--curIndex];                           // 이전 슬라이드로 이동
		    curSlide.classList.add('slide_active');                         // 새로운 슬라이드 활성화
		    pageDots[curIndex].classList.add('dot_active');                 // 새로운 페이지네이션 활성화
		    startAutoSlide();                                               // 자동 슬라이드 재개
		  });

		  /** 페이지네이션 클릭 이벤트 */
		  Array.prototype.forEach.call(pageDots, function (dot, i) {
		    dot.addEventListener('click', function (e) {
		      e.preventDefault();                                           // 기본 동작 방지 (페이지 이동 방지)
		      stopAutoSlide();                                              // 버튼 클릭 시 자동 슬라이드 중지
		      const curDot = document.querySelector('.dot_active');         // 현재 활성화된 페이지네이션
		      curDot.classList.remove('dot_active');                        // 기존 활성화 페이지네이션 비활성화
		      this.classList.add('dot_active');                             // 새로운 페이지네이션 활성화
		      curSlide.classList.remove('slide_active');                    // 기존 활성화 슬라이드 비활성화
		      curIndex = Number(this.getAttribute('data-index'));           // 클릭된 인덱스 값 가져오기
		      curSlide = slideContents[curIndex];                           // 해당 슬라이드로 이동
		      curSlide.classList.add('slide_active');                       // 새로운 슬라이드 활성화
		      slideList.style.transition = slideSpeed + "ms";
		      slideList.style.transform = "translate3d(-" + (slideWidth * (curIndex + 1)) + "px, 0px, 0px)";
		      startAutoSlide();                                             // 자동 슬라이드 재개
		    });
		  });

		  // 페이지 로드 시 자동 슬라이드 시작
		  startAutoSlide();
		})();



</script>
<%@include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
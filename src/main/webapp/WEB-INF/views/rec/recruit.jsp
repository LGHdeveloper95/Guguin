<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>채용정보</title>
     <style>
        /* 기본적인 페이지 스타일 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* 메인 컨테이너 스타일 */
        .bigcontainer {
            max-width: 80%;
            margin: 40px auto;
            margin-top: 65px;
            margin-bottom: 70px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        /* 제목 스타일 */
        h3 {
            text-align: left;
            margin-bottom: 20px;
        }

        /* 필터 영역 스타일 */
        .filters {
            display: flex;
            gap: 20px; /* 요소 간의 간격 */
            margin-bottom: 30px;
            align-items: center; /* 수직 정렬 */
        }

     
        /* 필터 버튼 기본 스타일 */
        .filters button {
            height: 40px; /* 버튼 높이 */
            width: 100px; /* 버튼 너비 */
            padding: 5px; /* 내부 여백 */
            font-size: 16px; /* 글자 크기 */
            border: 1px solid #ddd; /* 테두리 스타일 */
            border-radius: 5px; /* 모서리 둥글게 */
            background-color: #FAD673; /* 배경색 변경 */
            color: #000; /* 글자 색상 */
            font-weight: bold; /* 글자 두께 */
            cursor: pointer; /* 마우스 포인터 변경 */
            transition: background-color 0.3s ease; /* 배경색 변화 애니메이션 */
        }

        /* 필터 버튼 호버 스타일 */
        .filters button:hover {
            background-color: #EFC03E; /* 호버 시 배경색 변경 */
        }

        /* 드롭다운 메뉴 스타일 */
        .dropdown-menu {
          
            position: absolute;
            top: 100%;
            left: 0;
            z-index: 1000;
            display: none;
            min-width: 650px; /* 드롭다운 너비 확대 */
            padding: 15px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            
           
        }

        .dropdown-menu.show {
            display: block;
           /*  transition: opacity 0.3s ease, visibility 0.3s ease; */ /* 부드러운 애니메이션 */
        }

        /* 드롭다운 내부의 필터 행 스타일 */
        .dropdown-menu .filter-row {
            display: flex;
            align-items: center; /* 수직 가운데 정렬 */
            margin-bottom: 15px;
        }

        /* 직종 및 지역 대분류 선택창 스타일 */
        .dropdown-menu .scate-select,
        .dropdown-menu .sido-select,
        .dropdown-menu .edu-select,
        .dropdown-menu .career-select {
            width: 100px; /* 대분류 선택창 너비 */
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .sido-container {
            margin-left: 130px; /* 왼쪽 마진 추가 */
        }

        /* 학력 및 경력 버튼 그룹 스타일 */
        .edu-career-group {
            margin-left: auto; /* 오른쪽 정렬 */
            display: flex; /* 버튼들을 가로로 배치 */
            gap: 10px; /* 버튼 간의 간격 */
        }

        /* 학력 및 경력 버튼 스타일 */
        .Dbtn {
            background-color: #fff; /* 배경색 흰색 */
            height: 30px; /* 높이 30px */
            width: 100px; /* 너비 100px */
            font-size: 14px; /* 글자 크기 조정 */
            border: 1px solid #ddd; /* 테두리 스타일 */
            border-radius: 5px; /* 모서리 둥글게 */
            color: #000; /* 글자 색상 */
            font-weight: bold; /* 글자 두께 */
            cursor: pointer; /* 마우스 포인터 변경 */
            /* 추가적인 특이성을 높이기 위해 아래와 같이 */
        }

        /* 학력 및 경력 버튼의 특이성 증가 */
        .dropdown-menu .Dbtn {
            background-color: #fff; /* 배경색 흰색 */
            height: 30px; /* 높이 30px */
            width: 80px; /* 너비 100px */
            font-size: 14px; /* 글자 크기 조정 */
            border: 1px solid #ddd; /* 테두리 스타일 */
            border-radius: 5px; /* 모서리 둥글게 */
            color: #000; /* 글자 색상 */
            font-weight: bold; /* 글자 두께 */
            cursor: pointer; /* 마우스 포인터 변경 */
        }

        /* 필터 옵션 영역 스타일 */
        .filter-options {
            display: flex;
            gap: 20px; /* 요소 간의 간격 */
            margin-top: 20px;
        }

        /* 소분류 선택 영역 스타일 */
        .skill-checkboxes,
        .gugun-checkboxes {
            max-height: 150px; /* 최대 높이 설정 */
            overflow-y: auto; /* 스크롤 생성 */
            width: 190px; /* 소분류 영역 너비 */
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 4px;
        }

        .skill-checkboxes label,
        .gugun-checkboxes label {
            display: block;
            margin-bottom: 5px;
        }

        /* 학력 선택 영역 스타일 */
        .edu-selection {
            display: flex;
            flex-direction: column;
        }

        .edu-selection label {
            margin-bottom: 5px;
        }

        /* 경력 선택 영역 스타일 */
        .career-selection {
            display: flex;
            flex-direction: column;
            margin-top: 10px; /* 학력 선택 필드 아래에 위치하도록 여백 추가 */
        }

        .career-selection label {
            margin-bottom: 5px;
        }

        /* 날짜 선택 영역 스타일 */
        .date-selection {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        /* 날짜 입력 필드 스타일 */
        .date-selection input[type="date"] {
            width: 130px; /* 날짜 입력 필드 너비 */
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* 그리드 컨테이너 스타일 */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4열 그리드 */
            gap: 20px;
        }

        /* 카드 스타일 */
        .card {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .card-body {
            padding: 10px;
            text-align: center;
        }

        .card-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .card-text {
            font-size: 14px;
            color: #555;
        }

        /* 필터 적용 및 닫기 버튼 컨테이너 스타일 */
        .button-group {
            display: flex;
            justify-content: center; /* 가운데 정렬 */
            gap: 10px; /* 버튼 간의 간격 */
            margin-top: 15px; /* 위쪽 여백 추가 */
        }
  /* 필터 적용 버튼 스타일 */
        .dropdown-menu .apply-btn {
            background-color: #F1E8B6; /* 배경색 변경 */
            height: 30px; /* 높이 줄이기 */
            width: 100px; /* 너비 줄이기 */
            border: none; /* 테두리 제거 */
            border-radius: 5px; /* 모서리 둥글게 */
            cursor: pointer; /* 마우스 포인터 변경 */
            font-size: 14px; /* 글자 크기 조정 */
            font-weight: bold; /* 글자 두께 */
            transition: background-color 0.3s; /* 배경색 변화 애니메이션 */
        }

        /* 필터 적용 버튼 호버 스타일 */
        .dropdown-menu .apply-btn:hover {
            background-color: #A37F1C; /* 호버 시 배경색 변경 */
        }

        /* 닫기 버튼 스타일 */
        .dropdown-menu .close-btn {
            background-color: #FF6666; /* 배경색 변경 */
            color: white; /* 글자 색상 흰색 */
            height: 30px; /* 높이 줄이기 */
            width: 100px; /* 너비 줄이기 */
            border: none; /* 테두리 제거 */
            border-radius: 5px; /* 모서리 둥글게 */
            cursor: pointer; /* 마우스 포인터 변경 */
            font-size: 14px; /* 글자 크기 조정 */
            font-weight: bold; /* 글자 두께 */
            transition: background-color 0.3s; /* 배경색 변화 애니메이션 */
        }

        /* 닫기 버튼 호버 스타일 */
        .dropdown-menu .close-btn:hover {
            background-color: #CC0000; /* 호버 시 배경색 변경 */
        }
        
        .dropdown{
        position: relative
        }
        .card img.card-img-top {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/include/header.jsp" %>
<div class="bigcontainer">
    <h3>채용 정보</h3>
    <div class="filters">
        <!-- 필터 버튼 -->
        <div class="dropdown">
            <button class="btn" id="jobDropdown" type="button">상세조건</button>
            <div class="dropdown-menu" id="jobDropdownMenu">
                <!-- 드롭다운 내부 필터 행 -->
                <div class="filter-row">
                    <!-- 직종 대분류 선택 -->
                    <div>
                        <label for="scate"></label>
                        <select id="scate" class="scate-select">
                            <option value="">직무형태</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.scate_code}">${category.scate}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- 지역 대분류 선택 -->
                    <div class="sido-container">
                        <label for="sido"></label>
                        <select id="sido" class="sido-select">
                            <option value="">지역</option>
                            <c:forEach var="sido" items="${sidoList}">
                                <option value="${sido.sido_code}">${sido.sido}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- 학력 및 경력 선택 버튼 그룹 -->
                    <div class="edu-career-group">
                        <!-- 학력 선택 버튼 -->
                        <button id="eduButton" class="Dbtn">학력</button>
                        <!-- 경력 선택 버튼 -->
                        <button id="careerButton" class="Dbtn">경력</button>
                    </div>
                </div>
                <hr>
                <!-- 필터 옵션 영역 -->
                <div class="filter-options">
                    <!-- 소분류 선택 (체크박스 형태) -->
                    <div>
                        <label></label>
                        <div id="skillCheckboxes" class="skill-checkboxes">
                            <!-- 체크박스들이 여기에 동적으로 추가됩니다 -->
                        </div>
                    </div>
                    <!-- 지역 소분류 선택 (체크박스 형태) -->
                    <div>
                        <label></label>
                        <div id="gugunCheckboxes" class="gugun-checkboxes">
                            <!-- 체크박스들이 여기에 동적으로 추가됩니다 -->
                        </div>
                    </div>
                    <!-- 학력 및 경력 선택 영역 -->
                    <div>
                        <!-- 학력 선택 영역 -->
                        <div class="edu-selection" id="eduSelection" style="display: none;">
                            <label for="edu">학력 조건</label>
                            <select id="edu" class="edu-select">
                                <option value="">선택</option>
                                <c:forEach var="edu" items="${eduList}">
                                    <option value="${edu.edu_code}">${edu.edu_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <!-- 경력 선택 영역 -->
                        <div class="career-selection" id="careerSelection" style="display: none;">
                            <label for="career">경력 조건</label>
                            <select id="career" class="career-select">
                                <option value="">선택</option>
                                <c:forEach var="career" items="${careerList}">
                                    <option value="${career.career_code}">${career.career_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <!-- 필터 적용 및 닫기 버튼을 가로로 배치하고 가운데 정렬 -->
                <div class="button-group">
                    <button id="applyFilter" class="btn apply-btn">필터 적용</button>
                    <button id="closeDropdown" class="btn close-btn">닫기</button>
                </div>
            </div>
        </div>
        <!-- 날짜 선택 영역을 드롭다운 외부로 이동 -->
        <div class="date-selection">
            <div>
                <label for="startDate">시작일</label>
                <input type="date" id="startDate">
            </div>
            <div>
                <label for="endDate">마감일</label>
                <input type="date" id="endDate">
            </div>
        </div>
    </div>
    <div class="grid-container">
        <c:forEach var="recruit" items="${recruitList}">
            <div class="card">
                <img src="${recruit.picture}" alt="공고 이미지"  class="card-img-top" >
                <div class="card-body">
                    <h5 class="card-title"><a href="/post/view/${recruit.recnum}">${recruit.rectitle}</a></h5>
                    <p class="card-text">${recruit.comname}</p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    const dropdownButton = document.getElementById('jobDropdown');
    const dropdownMenu = document.getElementById('jobDropdownMenu');
    const closeDropdownButton = document.getElementById('closeDropdown');

    // 필터 버튼 클릭 시 드롭다운 열기/닫기
    dropdownButton.addEventListener('click', (event) => {
        event.stopPropagation();
        dropdownMenu.classList.toggle('show');
    });

    // 닫기 버튼 클릭 시 드롭다운 닫기
    closeDropdownButton.addEventListener('click', () => {
        dropdownMenu.classList.remove('show');
    });

    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener('click', (event) => {
        if (!dropdownMenu.contains(event.target) && event.target !== dropdownButton) {
            dropdownMenu.classList.remove('show');
        }
    });

    // 학력 선택 버튼 클릭 시 학력 선택 영역 토글
    document.getElementById('eduButton').addEventListener('click', function() {
        const eduSelection = document.getElementById('eduSelection');
        eduSelection.style.display = eduSelection.style.display === 'none' ? 'block' : 'none';
    });

    // 경력 선택 버튼 클릭 시 경력 선택 영역 토글
    document.getElementById('careerButton').addEventListener('click', function() {
        const careerSelection = document.getElementById('careerSelection');
        careerSelection.style.display = careerSelection.style.display === 'none' ? 'block' : 'none';
    });

    // 직종 대분류 선택 시 소분류 불러오기
    document.getElementById('scate').addEventListener('change', function () {
        const scateCode = this.value;
        if (scateCode) {
            fetch('/Rec/recruit/skill/' + scateCode)
                .then(response => response.json())
                .then(data => {
                    console.log('Fetched data:', data); // 디버깅용
                    const skillCheckboxes = document.getElementById('skillCheckboxes');
                    skillCheckboxes.innerHTML = ''; // 초기화
                    data.forEach(skill => {
                        const label = document.createElement('label');
                        const checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.value = skill.skill_code;
                        label.appendChild(checkbox);
                        label.appendChild(document.createTextNode(' ' + skill.skill));
                        skillCheckboxes.appendChild(label);
                    });
                })
                .catch(err => console.error('Failed to fetch skills:', err));
        } else {
            document.getElementById('skillCheckboxes').innerHTML = ''; // 초기화
        }
    });

    // 지역 대분류 선택 시 소분류 불러오기
    document.getElementById('sido').addEventListener('change', function () {
        const sidoCode = this.value;
        if (sidoCode) {
            fetch('/Rec/recruit/gugun/' + sidoCode)
                .then(response => response.json())
                .then(data => {
                    console.log('Fetched Gugun data:', data); // 디버깅용
                    const gugunCheckboxes = document.getElementById('gugunCheckboxes');
                    gugunCheckboxes.innerHTML = ''; // 초기화
                    data.forEach(gugun => {
                        const label = document.createElement('label');
                        const checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.value = gugun.gugun_code;
                        checkbox.name = 'gugun';
                        checkbox.addEventListener('change', limitGugunSelection);
                        label.appendChild(checkbox);
                        label.appendChild(document.createTextNode(' ' + gugun.gugun));
                        gugunCheckboxes.appendChild(label);
                    });
                })
                .catch(err => console.error('Failed to fetch Gugun:', err));
        } else {
            document.getElementById('gugunCheckboxes').innerHTML = ''; // 초기화
        }
    });

    // 최대 3개의 Gugun 선택 제한
    function limitGugunSelection() {
        const checkedGugun = document.querySelectorAll('#gugunCheckboxes input[type="checkbox"]:checked');
        if (checkedGugun.length > 3) {
            this.checked = false;
            alert('지역은 최대 3개까지 선택 가능합니다.');
        }
    }

    // 필터 적용 버튼 클릭 시
    document.getElementById('applyFilter').addEventListener('click', () => {
        // 선택된 소분류 코드 가져오기
        const selectedSkills = Array.from(document.querySelectorAll('#skillCheckboxes input[type="checkbox"]:checked'))
            .map(checkbox => checkbox.value);

        // 선택된 지역 소분류 코드 가져오기
        const selectedGugunCodes = Array.from(document.querySelectorAll('#gugunCheckboxes input[type="checkbox"]:checked'))
            .map(checkbox => checkbox.value);

        // 선택된 학력 코드 가져오기
        const selectedEduCode = document.getElementById('edu').value;

        // 선택된 경력 코드 가져오기
        const selectedCareerCode = document.getElementById('career').value;

        // 선택된 날짜 가져오기
        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;

        // 서버로 보낼 데이터 구성
        const filterData = {
            skillCodes: selectedSkills,
            gugunCodes: selectedGugunCodes,
            eduCode: selectedEduCode,
            careerCode: selectedCareerCode,
            startDate: startDate,
            endDate: endDate
        };

        console.log(JSON.stringify(filterData)); // 디버깅용

        fetch('/Rec/recruit/filter', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(filterData)
        })
            .then(response => response.json())
            .then(data => {
                console.log('Filtered data:', data); // 디버깅용
                const gridContainer = document.querySelector('.grid-container');
                gridContainer.innerHTML = ''; // 초기화
                data.forEach(recruit => {   
                    const card = document.createElement('div');  
                    card.className = 'card';  
                    card.innerHTML = 
                        '<img src="' + recruit.picture + '" alt="공고 이미지" class="card-img-top">'
                        + '<div class="card-body">'
                        + '<h5 class="card-title">' + recruit.rectitle + '</h5>'
                        +  '<p class="card-text">' + recruit.comname + '</p>'
                        + '</div>';
                    gridContainer.appendChild(card);
                });
            })
            .catch(err => console.error('Error fetching filtered data:', err));

        // 필터 적용 후 드롭다운 닫기
        dropdownMenu.classList.remove('show');
    });
});
</script>
<%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
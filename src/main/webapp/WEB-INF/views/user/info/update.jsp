<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사람과 기업을 연결하는 구구인</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Daum 우편번호 API 스크립트 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
  main { display: flex; justify-content: center; margin-top: 30px; width: 100wv; }
  .main { width: 70%; margin-top: 30px; }
  .table{
    border: 1px solid #dee2e6; 
    border-collapse: collapse; /* 테이블 셀 간 간격을 없앰 */
    width: 100%; 
    }
  .table th, .table td {
	  padding: 10px;             /* 셀 안쪽 패딩을 설정하여 내용이 겹치지 않도록 */
	  text-align: center;        /* 텍스트 중앙 정렬 */
	  border: 1px solid rgb(255, 194, 62); /* 셀 테두리 색상 설정 */
	}
  .table tr>td:first-child, tr>td:nth-child(3) { background-color: #FAD673; /* 헤더의 배경색 설정 */ }
  .table input{ width: 100%; }
  .red{ color: red; }
</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<%@include file="/WEB-INF/include/header.jsp" %>
<main>
  <%@include file="/WEB-INF/include/mypageSide.jsp" %>
  <section class="main">
    <!-- UserVo(userid=BO112, userpw=null, username=천보경, gender=여, birth=1990-01-01
    , uphone=010-1234-5678, uaddr=서울시 강남구, email=hong@example.com) -->
    <h5>회원정보 수정</h5>
    <form action="/User/Info/Update" method="POST" id="updateForm">
    <table class="table">
      <tr>
        <td>ID</td>
        <td colspan="3"><input type="text" name="userid" value="${ user.userid }" style="color: gray" readonly></td>
      </tr>
      <tr>
        <td>이름</td>
        <td  colspan="3"><input type="text"name="username"  value="${ user.username }" style="color: gray" readonly></td>
      </tr>
      <tr>
        <td>성별</td>
        <td  colspan="3"><input type="text" name="gender" value="${ user.gender }" style="color: gray" readonly></td>
      </tr>
      <tr>
        <td>생일</td>
        <td  colspan="3"><input type="date" name="birth" value="${ user.birth }" style="color: gray" readonly></td>
      </tr>
      <tr>
        <td><span class="red">*&nbsp;</span>휴대전화</td>
        <td colspan="3"><input type="text" name="uphone" value="${ user.uphone }" required></td>
      </tr>
      <!-- 주소 입력 -->
      <tr class="form-floating">
        <td>
          <label for="uaddr"><span class="red">*&nbsp;</span>주소</label>
        </td>
        <td>
          <input type="text" id="uaddr" name="uaddr" value="${ user.uaddr }" required onclick="execDaumPostcode()" readonly>
        </td>
        <td>
          <label for="post_code">우편번호</label>
        </td>
        <td>
          <input type="text" id="post_code" name="post_code" value="${ user.post_code }"  placeholder="자동입력" required readonly>
        </td>
      </tr>

      <!-- 상세주소 입력 -->
      <tr class="form-floating">
        <td>
          <label for="uaddr2">상세주소</label>
        </td>
        <td colspan="3">
          <input type="text" id="uaddr2" name="uaddr2" value="${ user.uaddr2 }">
        </td>
      </tr>

      <tr>
        <td><span class="red">*&nbsp;</span>이메일</td>
        <td colspan="3"><input type="text" name="email" value="${ user.email }" required></td>
      </tr>
    </table>
    <input type="submit" value="수정" class="btn btn-warning" id="updateBtn">
    </form>
  </section>
</main>
<script>
// Daum 우편번호 서비스를 실행하는 함수
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 선택된 주소 정보를 활용
            var addr = ''; // 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 도로명 주소
                addr = data.roadAddress;
            } else { // 지번 주소
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post_code').value = data.zonecode;
            document.getElementById('uaddr').value = addr;

            // 상세주소 입력 필드로 커서를 이동한다.
            document.getElementById('uaddr2').focus();
        },
        theme: {
            // 원하는 테마 설정 가능
            searchBgColor: "#DEDB0A", // 검색창 배경색
            queryTextColor: "#030202" // 검색창 글자색
        },
        autoClose: true // 주소 선택 후 팝업 자동 닫힘 설정
    }).open();
}
  //수정 버튼 클릭시----------------------------------------------------
  const updateBtn = document.querySelector('#updateBtn');
  updateBtn.addEventListener('click', function(e){
	  e.preventDefault();
	  const form = document.querySelector('#updateForm');
	  if (form.checkValidity()) {
	        alert("회원정보 수정이 완료되었습니다.");
	        form.submit();
	    } else {
	        alert("필수 입력 항목을 확인해주세요.");
	    }
  })
</script>
</body>
</html>
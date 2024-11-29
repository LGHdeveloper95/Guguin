<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>채용 달력</title>
    <style>
        /* 달력 스타일 */
        .calendar {
            width: 100%;
            border-collapse: collapse;
        }
        
        .calendar th {
            border: 1px solid #ddd;
            width: 14.28%;
            vertical-align: middle;
            padding: 5px;
            height: 20px;
            position: relative;
        }

        .calendar td {
            border: 1px solid #ddd;
            width: 14.28%;
            vertical-align: top;
            padding: 5px;
            height: 100px;
            position: relative;
        }

        .calendar th {
            background-color: #f2f2f2;
        }

        .calendar .date {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .start-posting {
            color: blue;
            font-size: 14px;
        }

        .end-posting {
            color: red;
            font-size: 14px;
        }

        .more-postings {
            cursor: pointer;
            color: green;
            font-weight: bold;
            font-size: 14px;
        }

        /* 공고 제목 링크 스타일 */
        .start-posting a, .end-posting a {
            text-decoration: none;
            color: inherit;
        }

        .start-posting a:hover, .end-posting a:hover {
            text-decoration: underline;
        }
        .calBox{
            width: 90%;
            margin: 40px auto;
            margin-top: 65px;

            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .mmm{
            width: 100%;
            height: 40px;
        }
        .calendarhead {
            height: 50px;
        }
    </style>
</head>
<%@include file="/WEB-INF/include/header.jsp" %>

<body>
    <div class="calBox" >
    <h1>${currentYear}년 ${currentMonth}월 채용 달력</h1>
    <table class="calendar">
        <thead>
            <tr class="calendarhead">
                <th>일</th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
                <th>토</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="dayCounter" value="1"/>
            <c:forEach var="week" begin="1" end="6">
                <tr>
                    <c:forEach var="dayOfWeek" begin="0" end="6">
                        <c:choose>
                            <c:when test="${week == 1 && dayOfWeek < startDayOfWeek}">
                                <td>&nbsp;</td>
                            </c:when>
                            <c:when test="${dayCounter <= daysInMonth}">
                                <td>
                                    <div class="date">${dayCounter}</div>
                                    
                                    <!-- 두 자리 숫자로 포맷 -->
                                    <fmt:formatNumber var="formattedMonth" value="${currentMonth}" pattern="00"/>
                                    <fmt:formatNumber var="formattedDay" value="${dayCounter}" pattern="00"/>
                                    
                                    <c:set var="dateKey" value="${currentYear}-${formattedMonth}-${formattedDay}"/>
                                    
                                    <c:if test="${not empty calendarData[dateKey]}">
                                        <c:forEach var="posting" items="${calendarData[dateKey]}">
                                            <c:choose>
                                                <c:when test="${posting.type == '시'}">
                                                    <div class="start-posting">
                                                        시) 
                                                        <a href="/post/view/${posting.recnum}">
                                                            <c:out value="${posting.comname}"/>
                                                        </a>
                                                    </div>
                                                </c:when>
                                                <c:when test="${posting.type == '마'}">
                                                    <div class="end-posting">
                                                        마) 
                                                        <a href="/post/view/${posting.recnum}">
                                                            <c:out value="${posting.comname}"/>
                                                        </a>
                                                    </div>
                                                </c:when>
                                                <c:when test="${posting.type == '+'}">
                                                    <div class="more-postings" onclick="location.href='/Rec/recruit'">
                                                        +${posting.extraCount}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="more-postings" onclick="location.href='/Rec/recruit'">
                                                        +${posting.extraCount}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </c:if>
                                </td>
                                <c:set var="dayCounter" value="${dayCounter + 1}"/>
                            </c:when>
                            <c:otherwise>
                                <td>&nbsp;</td>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    <%@include file="/WEB-INF/include/calenderfooter.jsp" %>
</body>
</html>
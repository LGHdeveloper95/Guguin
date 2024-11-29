package com.guguin.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * 채용 달력 페이지를 처리하는 컨트롤러
 */
@Controller
public class CalendarController {

    @Autowired
    private CalendarMapper calendarMapper;

    /**
     * 달력 페이지를 보여주는 메서드
     * @param year 년도 (선택사항)
     * @param month 월 (선택사항)
     * @param model 모델 객체
     * @return 달력 뷰의 경로
     */
    @RequestMapping("/calendar")
    public String calendarView(
            @RequestParam(value = "year", required = false) String year,
            @RequestParam(value = "month", required = false) String month,
            Model model) {
        // 현재 년도와 월을 가져옴
        LocalDate now = LocalDate.now();
        int currentYear = now.getYear();
        int currentMonth = now.getMonthValue();

        // 파라미터로 받은 년도와 월이 있으면 사용
        if (year != null && month != null) {
            try {
                currentYear = Integer.parseInt(year);
                currentMonth = Integer.parseInt(month);
                if (currentMonth < 1 || currentMonth > 12) {
                    currentMonth = now.getMonthValue();
                }
            } catch (NumberFormatException e) {
                // 파싱 오류 시 현재 날짜 사용
                currentYear = now.getYear();
                currentMonth = now.getMonthValue();
            }
        }

        // 해당 월의 시작일과 종료일 계산
        YearMonth yearMonth = YearMonth.of(currentYear, currentMonth);
        LocalDate startDate = yearMonth.atDay(1);
        LocalDate endDate = yearMonth.atEndOfMonth();

        // 날짜 형식 지정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Mapper에 전달할 파라미터 설정
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate.format(formatter));
        params.put("endDate", endDate.format(formatter));

        // 해당 기간의 공고를 가져옴
        List<CalendarVo> recruitments = calendarMapper.getRecruitmentsInDateRange(params);

        // 날짜별로 공고를 분류
        Map<String, List<Map<String, Object>>> calendarData = new HashMap<>();
        // 구조: date -> List of Map { type, comname, views }

        for (CalendarVo vo : recruitments) {
            // 시작일 공고
            if (vo.getStartDate() != null && !vo.getStartDate().isEmpty()) {
                String date = vo.getStartDate();
                calendarData.putIfAbsent(date, new ArrayList<>());
                Map<String, Object> data = new HashMap<>();
                data.put("type", "시"); // 시작
                data.put("recnum", vo.getRecnum());
                data.put("comname", vo.getComname()); // 회사 이름 추가
                data.put("views", vo.getViews());
                calendarData.get(date).add(data);
            }
            // 마감일 공고
            if (vo.getDeadline() != null && !vo.getDeadline().isEmpty()) {
                String date = vo.getDeadline();
                calendarData.putIfAbsent(date, new ArrayList<>());
                Map<String, Object> data = new HashMap<>();
                data.put("type", "마"); // 마감
                data.put("recnum", vo.getRecnum());
                data.put("comname", vo.getComname()); // 회사 이름 추가
                data.put("views", vo.getViews());
                calendarData.get(date).add(data);
            }
        }

        // 각 날짜별로 조회수가 높은 순으로 정렬하고 상위 4개만 남김
        for (String date : calendarData.keySet()) {
            List<Map<String, Object>> postings = calendarData.get(date);
            postings.sort((a, b) -> ((Integer)b.get("views")).compareTo((Integer)a.get("views")));
            int totalSize = postings.size();
            if (totalSize > 4) {
                // 상위 4개만 유지
                List<Map<String, Object>> top4 = new ArrayList<>(postings.subList(0, 4));
                // 초과 개수 추가
                Map<String, Object> extraData = new HashMap<>();
                extraData.put("type", "+");
                extraData.put("extraCount", totalSize - 4);
                top4.add(extraData);
                calendarData.put(date, top4);
            }
        }

        // 시작 요일 계산 (일요일을 0으로)
        int startDayOfWeek = startDate.getDayOfWeek().getValue() % 7; // 월요일=1, 일요일=7 => 일요일=0
        //String dateKey = currentYear - currentMonth < 10 ? '0' + currentMonth : currentMonth - dayCounter < 10 ? '0' + dayCounter : dayCounter;

        // 모델에 데이터 추가
        model.addAttribute("calendarData", calendarData);
        model.addAttribute("currentYear", currentYear);
        model.addAttribute("currentMonth", currentMonth);
        model.addAttribute("startDayOfWeek", startDayOfWeek);
        model.addAttribute("daysInMonth", yearMonth.lengthOfMonth());
        

        return "/calendar/calendarview";
    }
}
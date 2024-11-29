package com.guguin.calendar;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 채용 달력 관련 데이터베이스 작업을 위한 Mapper 인터페이스
 */
@Mapper
public interface CalendarMapper {
    /**
     * 특정 기간 내의 공고 정보를 가져오는 메서드
     * @param params 시작일과 종료일을 담은 Map (startDate, endDate)
     * @return 공고 정보 리스트
     */
    List<CalendarVo> getRecruitmentsInDateRange(Map<String, Object> params);
}
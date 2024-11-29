package com.guguin.user.recruit;

import java.util.List;

public class FilterCriteria {
    private List<String> skillCodes; // 선택된 소분류 코드 목록
    private List<String> gugunCodes; // 선택된 지역 소분류 코드 목록
    private String eduCode;          // 선택된 학력 코드
    private String careerCode;       // 선택된 경력 코드
    private String startDate;        // 시작일 (YYYY-MM-DD 형식)
    private String endDate;          // 종료일 (YYYY-MM-DD 형식)

    // Getter와 Setter
    public List<String> getSkillCodes() {
        return skillCodes;
    }

    public void setSkillCodes(List<String> skillCodes) {
        this.skillCodes = skillCodes;
    }

    public List<String> getGugunCodes() {
        return gugunCodes;
    }

    public void setGugunCodes(List<String> gugunCodes) {
        this.gugunCodes = gugunCodes;
    }

    public String getEduCode() {
        return eduCode;
    }

    public void setEduCode(String eduCode) {
        this.eduCode = eduCode;
    }

    public String getCareerCode() {
        return careerCode;
    }

    public void setCareerCode(String careerCode) {
        this.careerCode = careerCode;
    }

    public String getStartDate() {
        return startDate;
    }
 
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
 
    public String getEndDate() {
        return endDate;
    }
 
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
}
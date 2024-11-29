package com.guguin.user.recruit;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RecruitMapper {
    List<RecruitVo> getAllRecruits(); // 전체 공고 가져오기 (최신순)
    List<SkillVo> getSkillList(int scate_code); // 직종 대분류에 따른 소분류 가져오기
    List<SkillVo> getSkillCategories(); // 직종 대분류 가져오기
    List<RecruitVo> getRecruitsByFilters(FilterCriteria criteria); // 필터 조건에 따른 공고 가져오기
    List<SidoVo> getSidoList(); // 지역 대분류 가져오기
    List<GugunVo> getGugunList(int sido_code); // 지역 소분류 가져오기
    List<EduVo> getEduList(); // 학력 리스트 가져오기
    List<CareerVo> getCareerList(); // 경력 리스트 가져오기
}
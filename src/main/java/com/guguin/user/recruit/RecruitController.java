package com.guguin.user.recruit;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/Rec")
public class RecruitController {
    
    @Autowired
    private RecruitMapper recruitMapper;

    @GetMapping("/recruit")
    public ModelAndView recruit() {
        List<RecruitVo> recruitList = recruitMapper.getAllRecruits(); // 전체 공고
        List<SkillVo> categories = recruitMapper.getSkillCategories(); // 직종 대분류 가져오기
        List<SidoVo> sidoList = recruitMapper.getSidoList(); // 지역 대분류 가져오기
        List<EduVo> eduList = recruitMapper.getEduList(); // 학력 리스트 가져오기
        List<CareerVo> careerList = recruitMapper.getCareerList(); // 경력 리스트 가져오기

        ModelAndView mv = new ModelAndView();
        mv.addObject("recruitList", recruitList);
        mv.addObject("categories", categories); // 직종 대분류 데이터 추가
        mv.addObject("sidoList", sidoList); // 지역 대분류 데이터 추가
        mv.addObject("eduList", eduList); // 학력 데이터 추가
        mv.addObject("careerList", careerList); // 경력 데이터 추가
        mv.setViewName("/rec/recruit");
        return mv;
    }
    
    // 직종 대분류에 따라 소분류 필터 가져오기
    @GetMapping("/recruit/skill/{scate_code}")
    public ResponseEntity<List<SkillVo>> getSkills(@PathVariable("scate_code") int scate_code) {
        // System.out.println("Received scate_code: " + scate_code);
        List<SkillVo> skillList = recruitMapper.getSkillList(scate_code);
        // System.out.println("Fetched skills: " + skillList);
        return ResponseEntity.ok(skillList);
    }
    
    // 지역 대분류에 따른 소분류 가져오기
    @GetMapping("/recruit/gugun/{sido_code}")
    public ResponseEntity<List<GugunVo>> getGuguns(@PathVariable("sido_code") int sido_code) {
        List<GugunVo> gugunList = recruitMapper.getGugunList(sido_code);
        return ResponseEntity.ok(gugunList);
    }

    // 선택된 필터로 공고 검색
    @PostMapping("/recruit/filter")
    public ResponseEntity<List<RecruitVo>> filterRecruits(@RequestBody FilterCriteria criteria) {
        List<RecruitVo> recruits = recruitMapper.getRecruitsByFilters(criteria);
        return ResponseEntity.ok(recruits);
    }
}
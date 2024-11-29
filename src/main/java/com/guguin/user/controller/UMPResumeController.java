package com.guguin.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.guguin.user.vo.SidoVo;
import com.guguin.com.mapper.ComMapper;
import com.guguin.user.mapper.UserMypageMapper;
import com.guguin.user.vo.CareerVo;
import com.guguin.user.vo.EduVo;
import com.guguin.user.vo.GugunVo;
import com.guguin.user.vo.ResumeVo;
import com.guguin.user.vo.SkillCateVo;
import com.guguin.user.vo.SkillVo;
import com.guguin.user.vo.UserMypageVo;
import com.guguin.user.vo.UserVo;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/user/resume")
public class UMPResumeController {
	
	@Autowired
	private UserMypageMapper userMypageMapper;
	@Autowired
	private ComMapper comMapper;
	
	@GetMapping("")
	public ModelAndView resume(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		List<ResumeVo> resumeList = userMypageMapper.getResumeList(userid);
		
		//System.out.println(resumeList);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("userid",userid);
		mv.addObject("resumeList",resumeList);
		mv.setViewName("/user/resume/board");
		return mv;
	}
	
	@GetMapping("/menu/{menu}")
	public List<UserMypageVo> mypageList(@PathVariable("menu") String menu, HttpServletRequest request){
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		Map<String, Object> params = new HashMap<>();
		params.put("userid", userid);
		params.put("menu", menu);
		
		List<UserMypageVo> list = userMypageMapper.getList(params);
		System.out.println(list);
		
		return list;
	}
	
	@PostMapping("/backup")
	public ResponseEntity<List<UserMypageVo>> backup(@RequestBody UserMypageVo vo) {
		System.out.println(vo);
		userMypageMapper.backupResume(vo);
		
		List<UserMypageVo> backupList = userMypageMapper.getBackupResumeList(vo);
		System.out.println(backupList);
		ResponseEntity<List<UserMypageVo>> result = (backupList != null) ?
				ResponseEntity.status(HttpStatus.OK).body(backupList)
				: ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		return result;
	}

	@PostMapping("/backupList")
	public ResponseEntity<List<UserMypageVo>> backupList(@RequestBody UserMypageVo vo) {
		List<UserMypageVo> backupList = userMypageMapper.getBackupResumeList(vo);
		ResponseEntity<List<UserMypageVo>> result = (backupList != null) ?
				ResponseEntity.status(HttpStatus.OK).body(backupList)
				: ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		if(backupList.size()>15){
			userMypageMapper.deleteBackup();
		}
		return result;
	}

	@GetMapping("/backup/{res_backnum}")
    public ResponseEntity<Map<String,Object>> loadBackup(@PathVariable("res_backnum") String res_backnum) {
        UserMypageVo backup = userMypageMapper.getBackupResume(res_backnum);
        String[] skills = backup.getSkills().split(",");
        List<String> skillList = new ArrayList<>();
        
        for(String skill:skills){
        }
        com.guguin.com.vo.GugunVo region = comMapper.getRegion(backup.getGugun_code());

        Map<String,Object> map = new HashMap<>();//전달할 map
        map.put("backup",backup);//PostVo Backup 정보
        map.put("skillList", skillList);//skills로 찾은 SKillNameList
        map.put("region", region);//gugunCode로 찾은 SidoName,GugunName 정보

        ResponseEntity<Map<String,Object>> result = (backup != null) ?
                ResponseEntity.status(HttpStatus.OK).body(map)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

	
	@GetMapping("/one/{resnum}")
	public ResumeVo resumeOne(@PathVariable("resnum") String resnum) {
		ResumeVo resume = userMypageMapper.getResume(resnum);
		
		String[] skillCodeList = resume.getSkills().split(",");
		String[] skillList = new String[skillCodeList.length];
		for(int i = 0; i < skillCodeList.length; i++) {
			skillList[i] = userMypageMapper.getResumeSkills(skillCodeList[i]);
		}
		resume.setSkillnames(skillList);
		
		String edu = userMypageMapper.getResumeEduList(resnum);
		resume.setEdu_name(edu);
		
		String carrer = userMypageMapper.getResumeCarrer(resnum);
		resume.setCareer_name(carrer);
		
		return resume;
	}
	
	@GetMapping("/one/view/{resnum}")
	public ModelAndView resumeOneView(@PathVariable("resnum") String resnum) {
		ResumeVo resume = userMypageMapper.getResume(resnum);
		
		String[] skillCodeList = resume.getSkills().split(",");
		String[] skillList = new String[skillCodeList.length];
		for(int i = 0; i < skillCodeList.length; i++) {
			skillList[i] = userMypageMapper.getResumeSkills(skillCodeList[i]);
		}
		resume.setSkillnames(skillList);
		String edu = userMypageMapper.getResumeEduList(resnum);
		resume.setEdu_name(edu);
		String carrer = userMypageMapper.getResumeCarrer(resnum);
		resume.setCareer_name(carrer);
		
		//System.out.println(resume);
		ModelAndView mv = new ModelAndView();
		mv.addObject("resume",resume);
		mv.setViewName("/user/resume/view");
		return mv;
	}
	
	@GetMapping("/insert")
	public ModelAndView insertForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		
		UserVo user = userMypageMapper.getUser(userid);
		List<EduVo> eduList = userMypageMapper.getEduList();
        List<CareerVo> careerList = userMypageMapper.getCareerList();
        List<SkillCateVo> skillCateList = userMypageMapper.getSkillCateList();
        List<SidoVo> sidoList = userMypageMapper.getSidoList();
        
		ModelAndView mv = new ModelAndView();

    	mv.addObject("eduList", eduList);
    	mv.addObject("careerList", careerList);
    	mv.addObject("skillCateList", skillCateList);
        mv.addObject("sidoList", sidoList);
		mv.addObject("user",user);
		mv.setViewName("/user/resume/insert");
		
		return mv;
	}
	
	@GetMapping("/skill/{scate_code}")
    public ResponseEntity<List<SkillVo>> skill(@PathVariable("scate_code")String scate_code) {
        List<SkillVo> skillList = userMypageMapper.getSkillListByCateCode(scate_code);
        ResponseEntity<List<SkillVo>> result = (skillList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(skillList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @GetMapping("/region/{sido_code}")
    public ResponseEntity<List<GugunVo>> gugun(@PathVariable("sido_code")String sido_code) {
        List<GugunVo> regionList = userMypageMapper.getSkillListBySidoCode(sido_code);
        ResponseEntity<List<GugunVo>> result = (regionList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(regionList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }
    
    
    
    @GetMapping("/{resnum}/update")
    public ModelAndView update(@PathVariable(name = "resnum") String resnum,HttpServletRequest request) {
		
    	HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		
    	ResumeVo resume = userMypageMapper.getResume(resnum);
    	UserVo user = userMypageMapper.getUser(userid);
    	List<EduVo> eduList = userMypageMapper.getEduList();
        List<CareerVo> careerList = userMypageMapper.getCareerList();
        List<SkillCateVo> skillCateList = userMypageMapper.getSkillCateList();
        List<SidoVo> sidoList = userMypageMapper.getSidoList();
    	
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("user", user);
    	mv.addObject("resume", resume);
    	mv.addObject("eduList", eduList);
    	mv.addObject("careerList", careerList);
    	mv.addObject("skillCateList", skillCateList);
        mv.addObject("sidoList", sidoList);
    	mv.setViewName("/user/resume/update");
    	
    	System.out.println(resume);
    	return mv;
    }
	
    @GetMapping("/{resnum}")
    public ResponseEntity<Map<String,Object>> loadResume(@PathVariable("resnum") String resnum) {
        ResumeVo resume = userMypageMapper.getResume(resnum);
        
        Map<String,Object> map = new HashMap<>();//전달할 map
        if(resume.getSkills() != null && resume.getSkills() != "") {
	        String[] skills = resume.getSkills().split(",");
	        List<String> skillList = new ArrayList<>();
	        
	        for(String skill:skills){
	            skillList.add(comMapper.getSkillName(skill));
	        }
	        map.put("skillList", skillList);//skills로 찾은 SKillNameList
        }
        com.guguin.com.vo.GugunVo region = comMapper.getRegion(resume.getGugun_code());

        map.put("resume",resume);//PostVo Backup 정보
        map.put("region", region);//gugunCode로 찾은 SidoName,GugunName 정보

        ResponseEntity<Map<String,Object>> result = (resume != null) ?
                ResponseEntity.status(HttpStatus.OK).body(map)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }
    
    @GetMapping("/{resnum}/delete")
    public ModelAndView resumeDel(@PathVariable("resnum") String resnum) {
    	//System.out.println(resnum);
    	userMypageMapper.delResume(resnum);
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("redirect:/user/resume");
    	return mv;
    }
}

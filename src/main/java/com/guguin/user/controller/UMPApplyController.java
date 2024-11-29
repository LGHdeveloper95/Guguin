package com.guguin.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity.BodyBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.guguin.user.mapper.UserMypageMapper;
import com.guguin.user.vo.ApplyVo;
import com.guguin.user.vo.ResumeVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/user")
public class UMPApplyController {
	
	@Autowired
	private UserMypageMapper userMypageMapper;
	
	@GetMapping("/apply")
	public ModelAndView applyList(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		List<ApplyVo> list = userMypageMapper.getApplyList(userid);
		//RESTITLE, SENDNUM, RECTITLE, COMNAME, COMID, REG_DATE, PASS_CODE
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		//System.out.println(list);
		mv.setViewName("/user/apply/status");
		return mv;
	}
	
//	@GetMapping("/list")
//	public List<ApplyVo> applyList(HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		String userid = (String) session.getAttribute("userid");
//		List<ApplyVo> list = userMypageMapper.getApplyList(userid);
//		//RESTITLE, SENDNUM, RECTITLE, COMNAME, COMID, REG_DATE, PASS_CODE
//		return list;
//	}
	
	@GetMapping("/apply/filter/{pass_code}")
	public List<ApplyVo> applyfilter(HttpServletRequest request, @PathVariable("pass_code") String pass_code){
		System.out.println(pass_code);
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		
		 Map<String, Object> params = new HashMap<>();
		 params.put("userid", userid);
		 params.put("pass_code", pass_code);
		
		List<ApplyVo> filterList = userMypageMapper.getApplyListFilter(params);
		//System.out.println(filterList);
		//ApplyVo(restitle=test, sendnum=SD00000000000000000005, rectitle=AI 연구원 모집, comname=비전컴퍼니, comid=COM025, reg_date=2024-11-25 16:25:05, pass_code=null, userid=null, username=null, picture=null, edu_code=null, edu_content=null, license=null, career_code=null, career_content=null, skill=null, sido_code=null, gugun_code=null, background=null, motivation=null, personality=null, recnum=null, skills=null, resnum=null)
		return filterList;
	}
	
	@GetMapping("/resumeList/{recnum}/{comid}")
	public ModelAndView resumeList(HttpServletRequest request, @PathVariable("recnum") String recnum, @PathVariable("comid") String comid){
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		List<ResumeVo> resumeList = userMypageMapper.getResumeList(userid);
		ModelAndView mv = new ModelAndView();
		mv.addObject("resumeList", resumeList);
		mv.addObject("recnum", recnum);
		mv.addObject("comid", comid);
		mv.setViewName("/user/apply/resumePopup");
		return mv;
	}
	
	@PostMapping("/apply")
	public ResponseEntity<Object> apply(@RequestBody Map<String, Object> map) {
		//System.out.println("map:"+map);
		if(map.get("resnum") != null) {
		  String resnum = (String) map.get("resnum");
		  //System.out.println("resnum: "+resnum);
		  ApplyVo resume = userMypageMapper.getResumeApply(resnum);
		  resume.setComid(resnum);
		  resume.setRecnum((String)map.get("recnum"));
		  resume.setComid((String)map.get("comid"));
		  //System.out.println("resume: "+resume);
		  userMypageMapper.insertApplyResume(resume);
		  String sendnum = resume.getSendnum();
		  System.out.println("sendnum: "+sendnum);
		  userMypageMapper.insertFileUrl(sendnum, resnum);
		  
	      return ResponseEntity.ok().body(resume);
	    }
		else {
			return ResponseEntity.badRequest().body(null);
		}
	}
	
	@GetMapping("/apply/check/{recnum}")
	public int applyCheck(@PathVariable("recnum") String recnum, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		int applyCnt = userMypageMapper.getApplyCnt(userid,recnum);
		System.out.println("check: "+applyCnt);
		return applyCnt;
	}
	
	@GetMapping("/apply/view/{sendnum}")
	public ModelAndView view(@PathVariable("sendnum") String sendnum) {
		
		ApplyVo resume = userMypageMapper.getApplyResume(sendnum);
		if(resume.getSkills() != null && resume.getSkills().trim() != "") {
		  String[] skillCodeList = resume.getSkills().split(",");
		  String[] skillList = new String[skillCodeList.length];
		  for(int i = 0; i < skillCodeList.length; i++) {
			skillList[i] = userMypageMapper.getResumeSkills(skillCodeList[i]);
		  }
		  resume.setSkillnames(skillList);
		}
		String edu = userMypageMapper.getApplyResumeEduList(resume.getSendnum());
		resume.setEdu_name(edu);
		String carrer = userMypageMapper.getApplyResumeCarrer(resume.getSendnum());
		resume.setCareer_name(carrer);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("resume",resume);
		mv.setViewName("/user/apply/view");
		return mv;
	}
}
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

import com.guguin.community.CommunityVo;
import com.guguin.user.mapper.UserMypageMapper;
import com.guguin.user.vo.ApplyVo;
import com.guguin.user.vo.ResumeVo;
import com.guguin.user.vo.ScrapVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/user/community")
public class UMPCommunityController {
	
	@Autowired
	private UserMypageMapper userMypageMapper;
	
	@GetMapping("/com")
	public ModelAndView comReviewForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		List<ScrapVo> comReviewList = userMypageMapper.getReviewList(userid);
		ModelAndView mv = new ModelAndView();
		mv.addObject("comReviewList",comReviewList);
		mv.setViewName("/user/community/review");
		return mv;
	}
	
	@GetMapping("/board")
	public ModelAndView commBoardForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		List<CommunityVo> commList = userMypageMapper.getCommList(userid);
		ModelAndView mv = new ModelAndView();
		mv.addObject("commList",commList);
		mv.setViewName("/user/community/commBoard");
		return mv;
	}
	
}
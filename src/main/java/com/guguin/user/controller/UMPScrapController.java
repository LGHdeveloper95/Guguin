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
import com.guguin.user.vo.ScrapVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/user")
public class UMPScrapController {
	
	@Autowired
	private UserMypageMapper userMypageMapper;
	
	@GetMapping("/scrap")
	public ModelAndView userScrapForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		List<ScrapVo> scrapList = userMypageMapper.getScrapList(userid);
		ModelAndView mv = new ModelAndView();
		mv.addObject("scrapList",scrapList);
		mv.setViewName("/user/check/scrapView");
		return mv;
	}
	
	@GetMapping("/bookmark")
	public ModelAndView userBookmarkForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		List<ScrapVo> bookmarkList = userMypageMapper.getBookmarkList(userid);
		ModelAndView mv = new ModelAndView();
		mv.addObject("bookmarkList",bookmarkList);
		mv.setViewName("/user/check/bookmarkView");
		return mv;
	}
	
}
package com.guguin.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.guguin.user.mapper.UserMypageMapper;
import com.guguin.user.vo.UserVo;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/User/Info")
public class UMPInfoController {
	
	@Autowired
	private UserMypageMapper userMypageMapper;
	
	@GetMapping("/Update")
	public ModelAndView userUpdateForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		UserVo user = userMypageMapper.getUser(userid);
		System.out.println(user);
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", user);
		mv.setViewName("/user/info/update");
		return mv;
	}
	
	@PostMapping("/Update")
	public String userUpdate(UserVo user) {
		System.out.println("info/update user: "+user);
		userMypageMapper.updateUser(user);
		return "redirect:/user/resume";
	}
	
	@GetMapping("/PwUpdate")
	public ModelAndView userPwUpdateForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		String userpw = userMypageMapper.getUserPw(userid);
		ModelAndView mv = new ModelAndView();
		mv.addObject("userpw",userpw);
		mv.addObject("userid",userid);
		mv.setViewName("user/info/pwUpdate");
		return mv;
	}
	
	@PostMapping("/PwUpdate")
	public String userPwUpdate(UserVo update) {
		userMypageMapper.updateUserPw(update);
		return "redirect:/user/resume";
	}
}

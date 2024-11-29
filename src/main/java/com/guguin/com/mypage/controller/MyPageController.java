package com.guguin.com.mypage.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.guguin.com.mypage.mapper.MyPageMapper;
import com.guguin.com.mypage.vo.MyPageVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RequestMapping("/MyPage")
@Controller
public class MyPageController {

	@Autowired
	private MyPageMapper myPageMapper;
	
	
	  
	  @RequestMapping("/Board")
	  public ModelAndView board(HttpServletRequest request) {
	        HttpSession session = request.getSession();

	        // 세션에서 comid 가져오기
	        String comid = (String) session.getAttribute("comid");
	        ModelAndView mv = new ModelAndView();
	        if (comid == null) {
	        mv.setViewName("redirect:/Login/");
	        
	        } 

	        MyPageVo com = myPageMapper.getCom(comid);

	        // MyPageMapper에서 데이터 가져오기
	        List<MyPageVo> recList  = myPageMapper.getRecList(comid);
	        List<MyPageVo> scrList  = myPageMapper.getScrapList(comid);
	        List<MyPageVo> appList  = myPageMapper.getApplyList(comid);
	        List<MyPageVo> passList = myPageMapper.getPassList(comid);
	        
	        // ModelAndView 생성 및 데이터 추가
	        mv.addObject("count1", recList != null ? recList.size() : 0);
	        mv.addObject("recList", recList);
	        mv.addObject("count2", scrList != null ? scrList.size() : 0);
	        mv.addObject("scrList", scrList);           
	        mv.addObject("count3", appList != null ? appList.size() : 0);
	        mv.addObject("appList", appList);
	        mv.addObject("count4", passList != null ? passList.size() : 0);
	        mv.addObject("passList", passList);
	        mv.addObject("com",com);
	        
	        
	        // 뷰 이름 설정
	        mv.setViewName("/mypage/board"); // 템플릿 경로에 맞게 설정
	        return mv;
	    }
	  
	  
	 

}





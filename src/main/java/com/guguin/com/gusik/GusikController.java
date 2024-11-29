package com.guguin.com.gusik;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

	@Controller
	@RequestMapping("/Gusik")
	public class GusikController {
	    @Autowired
	    private GusikMapper gusikMapper;
	
	    @RequestMapping("/Board")
	    public ModelAndView board(HttpServletRequest request) {
	        HttpSession session = request.getSession();
	
	        // 세션에서 comid 가져오기
	        String comid = (String) session.getAttribute("comid");
	        ModelAndView mv = new ModelAndView();
	        if (comid == null) {
	            mv.setViewName("redirect:/Login/");
	            return mv;
	        }
	
	        // MyPageMapper에서 데이터 가져오기
	        List<GusikVo> resList = gusikMapper.getResList();  // 전체 이력서
	        List<GusikVo> sidoList = gusikMapper.getSidoList();  // 지역 리스트
	        List<GusikVo> gugunList = gusikMapper.getGugunList();  // 구군 리스트
	
	     // 구군별 이력서 분류
	        Map<Integer, List<GusikVo>> sidoMap = new HashMap<>();
	        Map<Integer, List<GusikVo>> gugunMap = new HashMap<>();
	
	        for (GusikVo res : resList) {
	            int sidoCode = res.getSido_code();  // sido_code가 int일 경우
	            if (!sidoMap.containsKey(sidoCode)) {
	                sidoMap.put(sidoCode, new ArrayList<>());
	            }
	            sidoMap.get(sidoCode).add(res);
	        }
	
	        // 구군별 이력서 분류
	        for (GusikVo res : resList) {
	            int gugunCode = res.getGugun_code();  // gugun_code가 int일 경우
	            if (!gugunMap.containsKey(gugunCode)) {
	                gugunMap.put(gugunCode, new ArrayList<>());
	            }
	            gugunMap.get(gugunCode).add(res);
	        }
	
	        // ModelAndView 생성 및 데이터 추가
	        mv.addObject("count1", resList != null ? resList.size() : 0);
	        mv.addObject("resList", resList);
	        mv.addObject("sidoList", sidoList);
	        mv.addObject("gugunList", gugunList);
	        mv.addObject("sidoMap", sidoMap);
	        mv.addObject("gugunMap", gugunMap);
	
	        // 뷰 이름 설정
	        mv.setViewName("/gusik/board");
	        return mv;
	    }
	}

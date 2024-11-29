package com.guguin;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class HomeController {
	
  @Autowired
  private HomeMapper homeMapper;
  
  @RequestMapping("/")
  public ModelAndView home() {
	  
	  // 조회수 순으로 공고 받기
	  List<HomeVo> recList = homeMapper.getTopViewsRecList();
	  // 개수는 10개 즉 탑텐  리스트임
	  List<HomeVo> limitedRecList = recList.stream().limit(10).toList();
	  
	
	  
	  ModelAndView mv = new ModelAndView();
	  mv.addObject("recList",limitedRecList);
	  mv.setViewName("home");
	  return mv;
	  
  }
  
  
	
	
	
	
    
}
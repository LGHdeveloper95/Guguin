package com.guguin.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/Join")
public class UserjoinController {

	@Autowired
	private UserjoinMapper userjoinMapper;
	
	@RequestMapping("/UserJoinForm")
	public  ModelAndView   writeForm() {	
		ModelAndView  mv = new ModelAndView();
		mv.setViewName("join/userJoin");
		return  mv;
	}

		@RequestMapping("/UserJoin")
		public  ModelAndView  ComJoin( UserjoinVo vo ) {
			// comjoin.jsp 가 넘겨준 데이터를 저장
			System.out.println(vo);
			//UserjoinVo(userid=testuser, userpw=pass1, username=쿠로미, gender=여,
			//birth=null, uphone=010-1111-1111, uaddr=부산 금정구 범어사로 2011, email=null)
			userjoinMapper.insertUser( vo );
			
			ModelAndView  mv  =  new ModelAndView();
			mv.setViewName("redirect:/Login/");
			return  mv;
		}


		@RequestMapping("/checkUserId")
		public ModelAndView checkId(@RequestParam("userid") String userid, Model model) {
		    boolean isDuplicate = userjoinMapper.checkUserIdDuplicate(userid);
		    model.addAttribute("isDuplicate", isDuplicate);
		    return new ModelAndView("/join/checkIdPopup");
		}
	

}
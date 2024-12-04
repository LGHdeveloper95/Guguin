package com.guguin.com.post.controller;

import com.guguin.com.mapper.ComMapper;
import com.guguin.com.post.mapper.PostMapper;
import com.guguin.com.post.vo.PostVo;
import com.guguin.com.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
public class PostController {

    @Autowired
    private PostMapper postMapper;
    @Autowired
    private ComMapper comMapper;

    @GetMapping("/post")
    public ModelAndView list(HttpServletRequest request){
        HttpSession session = request.getSession();

        //login 하기 귀찮아서 /post 로 가면 session에 comid 값을 넣어줌.
        session.setAttribute("comid","KWANG_GOD");

        String comid = (String) session.getAttribute("comid");
        ModelAndView mv = new ModelAndView();
        List<PostVo> postList= postMapper.getPostListByComid(comid);
        int count = postMapper.getCount();
        mv.addObject("postList",postList);
        mv.addObject("count",count);
        mv.setViewName("com/post/list");
        return mv;
    }

    @GetMapping("/post/write")
    public ModelAndView write(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        String comid = (String) session.getAttribute("comid");
        ModelAndView mv = new ModelAndView();
        ComVo com = comMapper.getCom(comid);
        String today = comMapper.getToday();
        List<CareerVo> careerList = comMapper.getCareerList();
        List<EduVo> eduList = comMapper.getEduList();
        List<GugunVo> gugunList = comMapper.getGugunList();
        List<SidoVo> sidoList = comMapper.getSidoList();
        List<SkillCategoryVo> skillCateList = comMapper.getSkillCateList();
        List<SkillVo> skillList = comMapper.getSkillList();
        mv.addObject("com", com);
        mv.addObject("careerList", careerList);
        mv.addObject("eduList", eduList);
        mv.addObject("gugunList", gugunList);
        mv.addObject("sidoList", sidoList);
        mv.addObject("skillCateList", skillCateList);
        mv.addObject("skillList", skillList);
        mv.addObject("today", today);
        mv.setViewName("com/post/write");
        return mv;
    }

    @GetMapping("/post/view/{recnum}")
    public ModelAndView view(@PathVariable("recnum") String recnum){
        ModelAndView mv = new ModelAndView();
        PostVo post = postMapper.getPost(recnum);
        post.setDeadline(post.getDeadline().substring(0,10));
        post.setStart_date(post.getStart_date().substring(0,10));
        post.setReg_date(post.getReg_date().substring(0,10));
        EduVo edu = comMapper.getEdu(post.getEdu_code());
        CareerVo career = comMapper.getCareer(post.getCareer_code());
        GugunVo region = comMapper.getRegion(post.getGugun_code());
        ComVo com = comMapper.getCom(post.getComid());


        String[] skills = post.getSkills().split(",");
        List<String> skillList = new ArrayList<>();
        for(String skill:skills){
            skillList.add(comMapper.getSkillName(skill));
        }

        mv.addObject("post",post);
        mv.addObject("edu",edu);
        mv.addObject("com",com);
        mv.addObject("career",career);
        mv.addObject("region",region);
        mv.addObject("skillList", skillList);
        mv.setViewName("com/post/view");
        return mv;
    }

    @GetMapping("/post/update/{recnum}")
    public ModelAndView update(@PathVariable("recnum") String recnum){

        ModelAndView mv = new ModelAndView();
        PostVo post = postMapper.getPost(recnum);
        ComVo com = comMapper.getCom(post.getComid());
        String today = comMapper.getToday();
        List<CareerVo> careerList = comMapper.getCareerList();
        List<EduVo> eduList = comMapper.getEduList();
        List<GugunVo> gugunList = comMapper.getGugunList();
        List<SidoVo> sidoList = comMapper.getSidoList();
        List<SkillCategoryVo> skillCateList = comMapper.getSkillCateList();
        List<SkillVo> skillList = comMapper.getSkillList();
        mv.addObject("recnum",recnum);
        mv.addObject("com", com);
        mv.addObject("careerList", careerList);
        mv.addObject("eduList", eduList);
        mv.addObject("gugunList", gugunList);
        mv.addObject("sidoList", sidoList);
        mv.addObject("skillCateList", skillCateList);
        mv.addObject("skillList", skillList);
        mv.addObject("today", today);
        mv.setViewName("com/post/update");
        return mv;
    }

}

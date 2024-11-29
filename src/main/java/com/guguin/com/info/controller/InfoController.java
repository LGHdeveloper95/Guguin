package com.guguin.com.info.controller;

import com.guguin.com.info.mapper.InfoMapper;
import com.guguin.com.info.vo.InfoVo;
import com.guguin.com.mapper.ComMapper;
import com.guguin.com.vo.ComVo;
import com.guguin.com.vo.StarPointVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.util.StringUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Controller
public class InfoController {

    @Autowired
    private InfoMapper infoMapper;
    @Autowired
    private ComMapper comMapper;

    @GetMapping("/com-info")
    public ModelAndView main() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("com/info/main");
        return mv;
    }

    @GetMapping("/com-info/{comid}")
    public ModelAndView view(@PathVariable("comid") String comid, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();
        String userid = (String) session.getAttribute("userid");
        InfoVo info = infoMapper.getInfo(comid);
        ComVo com = comMapper.getCom(comid);

        if (userid!=null && userid!="") {
            int check = infoMapper.checkBookmark(comid, userid);
            if (check > 0) {
                //북마크 있으면 1 
                mv.addObject("check", 1);
            } else {
                //없으면 0
                mv.addObject("check", 0);
            }
        }else{
            //로그인 세션 없으면 -1 반환
            mv.addObject("check",-1);
        }
        mv.addObject("info", info);
        mv.addObject("com",com);

        mv.setViewName("com/info/view");
        return mv;
    }

    @GetMapping("/com-info/write")
    public ModelAndView write(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();
        String comid = (String) session.getAttribute("comid");
        ComVo com = comMapper.getCom(comid);

        mv.addObject("com",com);
        mv.setViewName("com/info/write");
        return mv;
    }

    @GetMapping("/com-info/update/{comid}")
    public ModelAndView update(HttpServletRequest request,@PathVariable("comid") String comid) {
        ModelAndView mv = new ModelAndView();
        ComVo com = comMapper.getCom(comid);
        InfoVo info = infoMapper.getInfo(comid);
        mv.addObject("com",com);
        mv.addObject("info",info);
        mv.setViewName("com/info/update");
        return mv;
    }

    @GetMapping("/com-info/review/{comid}")
    public ModelAndView review(@PathVariable("comid")String comid){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("com/info/review");
        mv.addObject("comid",comid);
        return mv;
    }

}
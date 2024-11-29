package com.guguin.note;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/note")
public class NoteController {

    @Autowired
    private NoteMapper noteMapper;

    @GetMapping("/")
    public ModelAndView main(HttpServletRequest request){
        HttpSession session = request.getSession();
        ModelAndView mv = new ModelAndView();

        //session 값에 따라 type값을 준다.
        if(session.getAttribute("userid")!=null) {
            mv.addObject("type","USER");
        }
        else if(session.getAttribute("comid")!=null) {
            mv.addObject("type","COM");
        }

        mv.setViewName("note/main");
        return mv;
    }

    @GetMapping("/view/{note_num}")
    public ModelAndView view(@PathVariable("note_num") String note_num){
        ModelAndView mv = new ModelAndView();
        noteMapper.updateViewed(note_num);
        NoteVo note = noteMapper.getNote(note_num);
        mv.addObject("note", note);
        mv.setViewName("note/view");
        return mv;
    }
    @GetMapping("/send-view/{note_num}")
    public ModelAndView sendView(@PathVariable("note_num") String note_num){
        ModelAndView mv = new ModelAndView();
        NoteVo note = noteMapper.getNote(note_num);
        mv.addObject("note", note);
        mv.setViewName("note/sendview");
        return mv;
    }

    @GetMapping("/write")
    public ModelAndView view(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();

        //session 값에 따라 type값을 준다.
        if(session.getAttribute("userid")!=null) {
            mv.addObject("type","USER");
            mv.addObject("id",(String)session.getAttribute("userid"));
        }

        else if(session.getAttribute("comid")!=null) {
            mv.addObject("type","COM");
            mv.addObject("id",(String)session.getAttribute("comid"));
        }
        mv.setViewName("note/write");
        return mv;
    }

    @GetMapping("/write/{send_id}")
    public ModelAndView view(@PathVariable("send_id") String send_id,HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();

        //session 값에 따라 type값을 준다.
        if(session.getAttribute("userid")!=null) {
            mv.addObject("type","USER");
            mv.addObject("id",(String)session.getAttribute("userid"));
        }

        else if(session.getAttribute("comid")!=null) {
            mv.addObject("type","COM");
            mv.addObject("id",(String)session.getAttribute("comid"));
        }
        mv.addObject("send_id",send_id);
        mv.setViewName("note/write");
        return mv;
    }
}

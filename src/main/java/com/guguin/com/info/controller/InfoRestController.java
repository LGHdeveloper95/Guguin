package com.guguin.com.info.controller;

import com.guguin.com.info.mapper.InfoMapper;
import com.guguin.com.info.vo.InfoVo;
import com.guguin.com.post.mapper.PostMapper;
import com.guguin.com.post.vo.PostVo;
import com.guguin.com.vo.StarPointVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class InfoRestController {

    @Autowired
    private InfoMapper infoMapper;
    @Autowired
    private PostMapper postMapper;

    @GetMapping("/com-info/list/{idx}")
    public ResponseEntity<List<InfoVo>> infoList(@PathVariable("idx") int idx) {
        // 가져올 info 갯수
        int set_range = 12;
        //시작 행번호
        int start = set_range * idx;
        List<InfoVo> infoList = infoMapper.getInfoList(start, set_range);
        ResponseEntity<List<InfoVo>> result = (infoList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(infoList) :
                ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

        return result;
    }

    @GetMapping("/com-info/load/{comid}")
    public ResponseEntity<List<StarPointVo>> info(@PathVariable("comid") String comid) {
        List<StarPointVo> starList = infoMapper.getStarList(comid);
        ResponseEntity<List<StarPointVo>> result = (starList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(starList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        return result;
    }

    @GetMapping("/com-info/post/{comid}")
    public ResponseEntity<List<PostVo>> recruit(@PathVariable("comid") String comid) {
        List<PostVo> postList = postMapper.getPostListByComid(comid);
        ResponseEntity<List<PostVo>> result = (postList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(postList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        return result;
    }

    @PostMapping("/bookmark/{comid}")
    public ResponseEntity<Object> bookmark(HttpServletRequest request, @PathVariable("comid") String comid) {
        HttpSession session = request.getSession(false);
        String userid = (String) session.getAttribute("userid");
        //북마크 찾아보기
        if (!userid.equals(null) && !userid.equals("")) {
            int check = infoMapper.checkBookmark(comid, userid);
            //북마크 찾아보고 있으면 delete
            if (check > 0) {
                infoMapper.deleteBookmark(comid, userid);
                //북마크 찾아보고 없으면 insert
            } else {
                infoMapper.insertBookmark(comid, userid);
            }
            ResponseEntity<Object> result = ResponseEntity.status(HttpStatus.OK).body(check);
            return result;
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(-1);
        }

    }

    @PostMapping("/com-info/write")
    public ResponseEntity<String> write(@RequestBody InfoVo info){
        System.out.println(info);
        int check = infoMapper.insertInfo(info);
        ResponseEntity<String> result = (check==1) ? ResponseEntity.status(HttpStatus.OK).body("/com-info"):
                ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

        return result;
    }

    @PatchMapping("/com-info/update")
    public ResponseEntity<String> update(@RequestBody InfoVo info){
        System.out.println(info);
        int check = infoMapper.updateInfo(info);
        ResponseEntity<String> result = (check==1) ? ResponseEntity.status(HttpStatus.OK).body("/com-info/"+info.getComid()):
                ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

        return result;
    }
    @GetMapping("/com-info/review-check/{comid}")
    public String checkReview(@PathVariable("comid")String comid,HttpServletRequest request){
        HttpSession session = request.getSession();
        String userid = (String) session.getAttribute("userid");
        String check = infoMapper.getReviewed(userid,comid);
        return check;
    }

    @PostMapping("/com-info/review")
    public ResponseEntity<String> review(@RequestBody StarPointVo star,HttpServletRequest request){
        HttpSession session = request.getSession();
        String userid = (String) session.getAttribute("userid");
        star.setUserid(userid);
        int check = infoMapper.insertStarPoint(star);
        ResponseEntity<String> result = (check==1) ? ResponseEntity.status(HttpStatus.OK).body("/com-info"):
                ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

        return result;
    }
}

package com.guguin.com.post.controller;

import com.guguin.com.mapper.ComMapper;
import com.guguin.com.post.mapper.PostMapper;
import com.guguin.com.post.vo.PostVo;
import com.guguin.com.vo.GugunVo;
import com.guguin.com.vo.SkillVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class PostRestController {

    @Autowired
    private PostMapper postMapper;
    @Autowired
    private ComMapper comMapper;

    @PostMapping("/post/backup")
    public ResponseEntity<List<PostVo>> backup(@RequestBody PostVo post) {
        System.out.println(post);
        postMapper.backupPost(post);
        List<PostVo> backupList = postMapper.getBackupPostList(post);
        ResponseEntity<List<PostVo>> result = (backupList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(backupList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();

        return result;
    }

    @PostMapping("/post/backupList")
    public ResponseEntity<List<PostVo>> backupList(@RequestBody PostVo post) {
        List<PostVo> backupList = postMapper.getBackupPostList(post);
        ResponseEntity<List<PostVo>> result = (backupList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(backupList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        if(backupList.size()>15){
            postMapper.deleteBackup();
        }
        return result;
    }

    @GetMapping("/post/backup/{rec_backnum}")
    public ResponseEntity<Map<String,Object>> loadBackup(@PathVariable("rec_backnum") String rec_backnum) {
        PostVo backup = postMapper.getBackupPost(rec_backnum);
        String[] skills = backup.getSkills().split(",");
        List<String> skillList = new ArrayList<>();
        for(String skill:skills){
            skillList.add(comMapper.getSkillName(skill));
        }
        GugunVo region = comMapper.getRegion(backup.getGugun_code());

        Map<String,Object> map = new HashMap<>();//전달할 map
        map.put("backup",backup);//PostVo Backup 정보
        map.put("skillList", skillList);//skills로 찾은 SKillNameList
        map.put("region", region);//gugunCode로 찾은 SidoName,GugunName 정보

        ResponseEntity<Map<String,Object>> result = (backup != null) ?
                ResponseEntity.status(HttpStatus.OK).body(map)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @GetMapping("/post/update-backup/{recnum}")
    public ResponseEntity<Map<String,Object>> loadUpdate(@PathVariable("recnum") String recnum) {
        PostVo post = postMapper.getPost(recnum);
        String[] skills = post.getSkills().split(",");
        List<String> skillList = new ArrayList<>();
        for(String skill:skills){
            skillList.add(comMapper.getSkillName(skill));
        }
        GugunVo region = comMapper.getRegion(post.getGugun_code());

        Map<String,Object> map = new HashMap<>();//전달할 map
        map.put("post",post);//PostVo Backup 정보
        map.put("skillList", skillList);//skills로 찾은 SKillNameList
        map.put("region", region);//gugunCode로 찾은 SidoName,GugunName 정보

        ResponseEntity<Map<String,Object>> result = (post != null) ?
                ResponseEntity.status(HttpStatus.OK).body(map)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }


    @GetMapping("/post/skill/{scate_code}")
    public ResponseEntity<List<SkillVo>> skill(@PathVariable("scate_code")String scate_code) {
        List<SkillVo> skillList = comMapper.getSkillListByCateCode(scate_code);
        ResponseEntity<List<SkillVo>> result = (skillList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(skillList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @GetMapping("/post/region/{sido_code}")
    public ResponseEntity<List<GugunVo>> gugun(@PathVariable("sido_code")String sido_code) {
        List<GugunVo> regionList = comMapper.getSkillListBySidoCode(sido_code);
        ResponseEntity<List<GugunVo>> result = (regionList != null) ?
                ResponseEntity.status(HttpStatus.OK).body(regionList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @PostMapping("/post/write")
    public ResponseEntity<String> write(@RequestBody PostVo post){
        System.out.println(post);
        int success  = postMapper.savePost(post);
        ResponseEntity<String> result = (success == 1) ?
                ResponseEntity.status(HttpStatus.OK).body("/post")
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @PostMapping("/post/update")
    public ResponseEntity<String> update(@RequestBody PostVo post){
        System.out.println(post);
        int success  = postMapper.updatePost(post);
        ResponseEntity<String> result = (success == 1) ?
                ResponseEntity.status(HttpStatus.OK).body("/post/view/"+post.getRecnum())
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @DeleteMapping("/post/delete/{recnum}")
    public ResponseEntity<String> deletePost(@PathVariable("recnum") String recnum){
        int success  = postMapper.deletePost(recnum);
        ResponseEntity<String> result = (success == 1) ?
                ResponseEntity.status(HttpStatus.OK).body("")
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }
}

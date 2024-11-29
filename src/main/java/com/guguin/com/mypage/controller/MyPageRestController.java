package com.guguin.com.mypage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.guguin.com.mypage.mapper.MyPageMapper;

@Transactional
@RestController
@RequestMapping("/MyPage")
public class MyPageRestController {
    @Autowired
    private MyPageMapper myPageMapper;

    @Transactional
    @PostMapping("/Delete")
    public ResponseEntity<String> deleteScraps(@RequestBody List<String> resnums) {
        if (resnums == null || resnums.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("삭제할 스크랩이 없습니다.");
        }

        try {
            myPageMapper.deleteScraps(resnums);
            return ResponseEntity.ok("선택된 스크랩이 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("스크랩 삭제 중 오류가 발생했습니다.");
        }
    }
}
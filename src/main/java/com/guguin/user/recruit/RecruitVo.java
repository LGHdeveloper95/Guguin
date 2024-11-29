package com.guguin.user.recruit;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecruitVo {
    private String recnum;        // 공고 번호
    private String rectitle;      // 공고 제목
    private String comname;       // 회사명
    private int views;            // 조회수
    private String regionName;    // 지역 이름
    private String picture;     
    private List<String> skillCodes;
}
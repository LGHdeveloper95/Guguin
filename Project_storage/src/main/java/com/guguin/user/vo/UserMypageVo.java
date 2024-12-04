package com.guguin.user.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserMypageVo {
	//backup id
    private String res_backnum;
    //applyres
    private String resnum;
    private String restitle;
    private String userid;

    //apply //bookmark
    private String sendnum;
    private int pass_code;
    private String comid;

    //scrap
    private String recnum;

    //backup items
    private String license;
    private String skills;
    private int gugun_code;
    private String username;
    private String reg_date;
    private String picture;
    private String edu_code;
    private String edu_content;
    private String career_code;
    private String career_content;
    private String background;
    private String motivation;
    private String personality;
    private String gender;
}

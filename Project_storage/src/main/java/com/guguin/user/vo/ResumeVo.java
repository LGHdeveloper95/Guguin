package com.guguin.user.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResumeVo {
	
	private String resnum;
	private String restitle;
	private String userid;
	private String username;
	private String reg_date;
	private String picture;
	private int edu_code;
	private String edu_name;
	private String edu_content;
	private String license;
	private int career_code;
	private String career_name;
	private String career_content;
	private String background;
	private String motivation;
	private String personality;
	private int gugun_code;
	private String gugun;
	private String gender;
	
	private String skills;
	
	
}

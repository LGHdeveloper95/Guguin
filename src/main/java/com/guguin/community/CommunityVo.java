package com.guguin.community;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommunityVo {
	private String conum;
	private String not_title;
	private String not_content;
	private String hiredate;
	private String userid;
	private String comid;
	private int views;
}

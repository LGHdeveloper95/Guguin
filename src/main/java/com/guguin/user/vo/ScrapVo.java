package com.guguin.user.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ScrapVo {
	private String scnum;
	private String comid;
	private String recnum;
	private String rectitle;
	private String comname;
	private String deadline;
	private int views;
	
	private String bmnum;
	private double average_val;
	
	private String commented;
}

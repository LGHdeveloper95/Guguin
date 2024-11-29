package com.guguin.community;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ComentVo {
	private String renum;
	private String conum;
	private String userid;
	private String comid;
	private String c_comment;
	private String reg_date;
}

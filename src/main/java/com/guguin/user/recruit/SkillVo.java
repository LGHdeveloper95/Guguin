package com.guguin.user.recruit;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SkillVo {
	private String skill;
    private String scate;       // 대분류 이름
	private String scate_code;
	private String skill_code;	
}

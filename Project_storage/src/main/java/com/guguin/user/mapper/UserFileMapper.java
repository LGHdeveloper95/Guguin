package com.guguin.user.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.guguin.user.vo.GugunVo;
import com.guguin.user.vo.ApplyVo;
import com.guguin.user.vo.CareerVo;
import com.guguin.user.vo.EduVo;
import com.guguin.user.vo.ResumeVo;
import com.guguin.user.vo.SidoVo;
import com.guguin.user.vo.SkillCateVo;
import com.guguin.user.vo.SkillVo;
import com.guguin.user.vo.UserMypageVo;
import com.guguin.user.vo.UserVo;

@Mapper
public interface UserFileMapper {

	ResumeVo getResume(String resnum);

	List<EduVo> getEduList();

	List<CareerVo> getCareerList();

	List<SkillCateVo> getSkillCateList();

	List<SidoVo> getSidoList();

	UserVo getUser(String userid);

	void insertResume(Map<String, Object> map);

	String  getUrl(String resnum);

	List<String> getFileIdList(String id);

	void insertFile(Map<String, Object> map);

	void insertFile(Object id, Object saveFile);

	String getFilePath(Object resnum);

    void delFile(Object resnum);

	void updateResume(Map<String, Object> map);
}

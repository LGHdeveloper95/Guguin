package com.guguin.user.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.guguin.user.vo.GugunVo;
import com.guguin.community.CommunityVo;
import com.guguin.user.vo.ApplyVo;
import com.guguin.user.vo.CareerVo;
import com.guguin.user.vo.EduVo;
import com.guguin.user.vo.ResumeVo;
import com.guguin.user.vo.ScrapVo;
import com.guguin.user.vo.SidoVo;
import com.guguin.user.vo.SkillCateVo;
import com.guguin.user.vo.SkillVo;
import com.guguin.user.vo.UserMypageVo;
import com.guguin.user.vo.UserVo;

@Mapper
public interface UserMypageMapper {

	List<ResumeVo> getResumeList(String userId);

	List<UserMypageVo> getList(Map<String, Object> params);

	ResumeVo getResume(String resnum);

	String getResumeEduList(String resnum);

	String getResumeCarrer(String resnum);

	// Data List ------------------------------
	List<EduVo> getEduList();

	List<CareerVo> getCareerList();

	List<SkillCateVo> getSkillCateList();

	List<SidoVo> getSidoList();

	List<SkillVo> getSkillListByCateCode(String scate_code);

	List<GugunVo> getSkillListBySidoCode(String sido_code);
	//------------------------------------------
	
	UserVo getUser(String userid);

	UserMypageVo getBackupResume(String res_backnum);

    void backupResume(UserMypageVo vo);

	List<UserMypageVo> getBackupResumeList(UserMypageVo vo);

	void deleteBackup();

	void insertResume(HashMap<String, Object> map);

	List<ApplyVo> getApplyList(String userid);

	List<ApplyVo> getApplyListFilter(Map<String, Object> params);

	void insertApplyResume(ApplyVo resume);

	ApplyVo getResumeApply(String resnum);

	int getApplyCnt(String userid, String recnum);

	void updateUser(UserVo user);

	String getUserPw(String userid);

	void updateUserPw(UserVo update);

	ApplyVo getApplyResume(String sendnum);

	String getApplyResumeEduList(String sendnum);

	String getApplyResumeCarrer(String sendnum);

	String getResumeSkills(String skill_code);

	void delResume(String resnum);

	void insertFileUrl(String sendnum, String resnum);

	//scrap, bookmark, review-------------------------------------------

	List<ScrapVo> getScrapList(String userid);

	List<ScrapVo> getBookmarkList(String userid);

	List<ScrapVo> getReviewList(String userid);

	List<CommunityVo> getCommList(String userid);

}

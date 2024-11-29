package com.guguin.community;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommunityMapper {

	List<CommunityVo> getList(int arg0, int arg1);

	CommunityVo getComm(String conum);

	int getTotalBoardCount();

	List<FileVo> getFiles(String conum);

	void upViews(String conum);

	void delCom(String conum);

	void delFile(String finum);

	List<ComentVo> getComment(String conum);

	void insertComment(HashMap<String, Object> map);

	void updateComment(HashMap<String, Object> map);

	void delComment(String conum);

}

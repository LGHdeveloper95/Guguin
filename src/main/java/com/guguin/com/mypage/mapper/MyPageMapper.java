package com.guguin.com.mypage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.guguin.com.mypage.vo.MyPageVo;

@Mapper
public interface MyPageMapper {


	MyPageVo getCom(String comid);


	List<MyPageVo> getScrapList(String comid);

	List<MyPageVo> getRecList(String comid);


	void deleteScrap(String scnum);


	void deleteScraps(List<String> resnums);


	List<MyPageVo> getApplyList(String comid);


	List<MyPageVo> getPassList(String comid);

	
}

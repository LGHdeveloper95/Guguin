package com.guguin.join;

import org.apache.ibatis.annotations.Mapper;


@Mapper

public interface UserjoinMapper {

	void insertUser(UserjoinVo vo);

	boolean checkUserIdDuplicate(String userid);


}
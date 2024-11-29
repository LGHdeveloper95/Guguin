package com.guguin.join;

import org.apache.ibatis.annotations.Mapper;



@Mapper

public interface ComjoinMapper {

	void insertCompany(ComjoinVo vo);

	boolean checkIdDuplicate(String comid);

}
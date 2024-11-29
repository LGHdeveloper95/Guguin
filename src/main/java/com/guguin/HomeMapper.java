package com.guguin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface HomeMapper {

	List<HomeVo> getTopViewsRecList();

	
	
	
}

package com.guguin.com.gusik;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface GusikMapper {

	 // 이력서 목록 조회
    
    List<GusikVo> getResList();

    // 시/도 목록 조회
    
    List<GusikVo> getSidoList();

    // 구/군 목록 조회
    
    List<GusikVo> getGugunList();
}
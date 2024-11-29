package com.guguin.com.info.mapper;

import com.guguin.com.info.vo.InfoVo;
import com.guguin.com.vo.StarPointVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InfoMapper {

    List<InfoVo> getInfoList(int start,int set_range);

    InfoVo getInfo(String comid);

    List<StarPointVo> getStarList(String comid);

    int checkBookmark(String comid, String userid);

    void insertBookmark(String comid, String userid);

    void deleteBookmark(String comid, String userid);

    int insertInfo(InfoVo info);

    int updateInfo(InfoVo info);

    String getReviewed(String userid,String comid);

    int insertStarPoint(StarPointVo star);
}

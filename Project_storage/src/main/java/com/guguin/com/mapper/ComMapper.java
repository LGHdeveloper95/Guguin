package com.guguin.com.mapper;

import com.guguin.com.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ComMapper {

    String getToday();

    List<CareerVo> getCareerList();

    List<EduVo> getEduList();

    ComVo getCom(String comid);


    List<SkillCategoryVo> getSkillCateList();

    List<SidoVo> getSidoList();

    List<GugunVo> getGugunList();

    List<SkillVo> getSkillList();

    List<SkillVo> getSkillListByCateCode(String cate_code);

    List<GugunVo> getSkillListBySidoCode(String sido_code);

    EduVo getEdu(int edu_code);

    CareerVo getCareer(int career_code);

    GugunVo getRegion(int gugun_code);

    String getSkillName(String skill);

}

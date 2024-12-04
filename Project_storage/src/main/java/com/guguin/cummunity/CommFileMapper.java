package com.guguin.cummunity;

import org.apache.ibatis.annotations.Mapper;

import java.nio.file.Path;
import java.util.Map;

@Mapper
public interface CommFileMapper {

    void insertCommunity(Map<String, Object> map);

    String getConum(Map<String, Object> user);

    String getFileUrl(String finum);

    void updateCommunity(Map<String, Object> map);
}

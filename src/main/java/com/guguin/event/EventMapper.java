package com.guguin.event;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EventMapper {
    List<EventVo> getEventList(String id);

    void updateViewed(String alnum);

    void deleteEvent(String alnum);


    String getUserNoteCount(String id);

    String getComNoteCount(String id);
}

package com.guguin.search;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SearchMapper {
    // 커뮤니티 게시글 총 개수
    int countCommunityPosts(@Param("keyword") String keyword);

    // 커뮤니티 게시글 검색 메서드 (페이징 적용)
    List<CommunityPost> searchCommunityPosts(@Param("keyword") String keyword,
                                             @Param("offset") int offset,
                                             @Param("limit") int limit);

    // 채용 공고 총 개수
    int countRecruitPosts(@Param("keyword") String keyword);

    // 채용 공고 검색 메서드 (페이징 적용)
    List<RecruitPost> searchRecruitPosts(@Param("keyword") String keyword,
                                         @Param("offset") int offset,
                                         @Param("limit") int limit);
}
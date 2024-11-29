package com.guguin.search;

import com.guguin.csboard.PagingHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class SearchController {

    @Autowired
    private SearchMapper searchMapper;

    // 한 페이지에 보여줄 게시글 수
    private static final int RECORDS_PER_PAGE = 10;

    // 검색 결과를 처리하는 메서드
    @GetMapping("/search")
    public ModelAndView search(@RequestParam("keyword") String keyword,
                               @RequestParam(value = "commPage", defaultValue = "1") int commPage,
                               @RequestParam(value = "recruitPage", defaultValue = "1") int recruitPage) {

        ModelAndView mv = new ModelAndView("search/searchresult");
        mv.addObject("keyword", keyword);

        // 커뮤니티 게시글 페이징 처리
        int totalCommRecords = searchMapper.countCommunityPosts(keyword);
        PagingHelper commPaging = new PagingHelper(totalCommRecords, commPage, RECORDS_PER_PAGE);
        List<CommunityPost> communityPosts = searchMapper.searchCommunityPosts(keyword, (commPage - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        mv.addObject("communityPosts", communityPosts);
        mv.addObject("commPagingHelper", commPaging);

        // 채용 공고 페이징 처리
        int totalRecruitRecords = searchMapper.countRecruitPosts(keyword);
        PagingHelper recruitPaging = new PagingHelper(totalRecruitRecords, recruitPage, RECORDS_PER_PAGE);
        List<RecruitPost> recruitPosts = searchMapper.searchRecruitPosts(keyword, (recruitPage - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        mv.addObject("recruitPosts", recruitPosts);
        mv.addObject("recruitPagingHelper", recruitPaging);

        return mv;
    }
}
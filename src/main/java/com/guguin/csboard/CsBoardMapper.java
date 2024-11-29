package com.guguin.csboard;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CsBoardMapper {

    List<CsBoardVo> getAllBoardList();  // 전체 게시글 목록 조회
    List<CsBoardVo> getPagedBoardList(int arg0, int arg1);  // 페이징 처리된 게시글 목록 조회
    int getTotalBoardCount();  // 게시글 총 개수 조회
    CsBoardVo getBoardDetail(String qnum);  // 게시글 상세 조회
    int updateBoard(CsBoardVo board);  // 게시글 수정
    int insertBoard(CsBoardVo board);  // 게시글 작성
    int getLastQnum();  // 게시글 번호 자동 설정용 쿼리

    // 사용자별 페이징 처리된 게시글 목록 조회
   // List<CsBoardVo> getBoardListByUserIdPaged(String loggedInUser, int offset, int recordsPerPage);

    // 기업별 페이징 처리된 게시글 목록 조회
  //  List<CsBoardVo> getBoardListByComIdPaged(String loggedInComId, int offset, int recordsPerPage);

    // 사용자 게시글 총 개수 조회

    // 기업 게시글 총 개수 조회
    List<CsBoardVo> getBoardListByUserIdPaged(Map<String, Object> params);
    List<CsBoardVo> getBoardListByComIdPaged(Map<String, Object> params);
    int getUserBoardCount(String loggedInUser);
    int getComBoardCount(String loggedInComId);
    
	void updateAnswer(CsBoardVo vo);
}
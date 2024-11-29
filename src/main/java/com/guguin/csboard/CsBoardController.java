
package com.guguin.csboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Cs")
public class CsBoardController {

    @Autowired
    private CsBoardMapper csBoardMapper;
/*
    // 게시판 목록
    @GetMapping("/csboard")
    public String boardList(Model model) {
        List<CsBoardVo> boardList = csBoardMapper.getAllBoardList();
        model.addAttribute("boardList", boardList);
        return "/WEB-INF/views/csboard/board.jsp";
    }
    */
 // 게시판 목록 (페이징 처리)
    @GetMapping("/Board")
    public String boardList(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
        int recordsPerPage = 10;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        int totalRecords = csBoardMapper.getTotalBoardCount();  // 전체 게시글 수
        PagingHelper pagingHelper = new PagingHelper(totalRecords, page, recordsPerPage);
        System.out.println(arg0);
        List<CsBoardVo> boardList = csBoardMapper.getPagedBoardList(arg0, recordsPerPage);
       System.out.println(boardList);
        model.addAttribute("boardList", boardList);
        model.addAttribute("pagingHelper", pagingHelper);

        return "/csboard/board";
    }
    // 컨트롤러 메서드에서 Map 사용
    @GetMapping("/myPosts")
    public String myPosts(
        @RequestParam(value = "page", defaultValue = "1") int page,
        HttpSession session, Model model) {

        String loggedInUserId = (String) session.getAttribute("userid");
        String loggedInComId = (String) session.getAttribute("comid");

        int recordsPerPage = 10;  // 페이지당 보여줄 게시글 수
        int offset = (page - 1) * recordsPerPage;  // 오프셋 계산

        List<CsBoardVo> myBoardList;
        int totalRecords;

        // 매개변수를 담을 Map 생성
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("recordsPerPage", recordsPerPage);

        if (loggedInUserId != null) {
            params.put("loggedInUser", loggedInUserId);
            myBoardList = csBoardMapper.getBoardListByUserIdPaged(params);
            totalRecords = csBoardMapper.getUserBoardCount(loggedInUserId);  // 전체 게시글 수 조회
        } else {
            params.put("loggedInComId", loggedInComId);
            myBoardList = csBoardMapper.getBoardListByComIdPaged(params);
            totalRecords = csBoardMapper.getComBoardCount(loggedInComId);  // 전체 게시글 수 조회
        }

        PagingHelper pagingHelper = new PagingHelper(totalRecords, page, recordsPerPage);
        model.addAttribute("boardList", myBoardList);
        model.addAttribute("pagingHelper", pagingHelper);

        return "/csboard/board";
    }

    @GetMapping("/View")
    public String boardView(@RequestParam("qnum") String qnum, Model model, HttpSession session) {
        // 세션에서 로그인된 사용자 ID와 기업 ID를 가져오기
        String loggedInUserId = (String) session.getAttribute("userid");
        String loggedInComId = (String) session.getAttribute("comid");

        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
        if (loggedInUserId == null && loggedInComId == null) {
            model.addAttribute("loginError", "로그인 하신후 이용부탁드립니다.");
            return "/csboard/alert";  // 알림용 JSP 페이지로 이동
        }

        // 게시글 상세 정보 가져오기
        CsBoardVo board = csBoardMapper.getBoardDetail(qnum);
        
     // 본인이 작성한 글인지 확인 (userid와 comid 둘 다 체크)
        if ((board.getUserid() == null || !board.getUserid().equals(loggedInUserId)) &&
            (board.getComid() == null || !board.getComid().equals(loggedInComId))
            && !loggedInUserId.equals("admin")) {
            model.addAttribute("error", "본인이 작성한 글만 볼 수 없습니다.");
            return "/csboard/alert";  // 알림용 JSP 페이지로 이동
        }
        
        if(board.getAnswer() == null) {
        	board.setAnswer("");
        }else {
        	board.setAnswer(board.getAnswer().trim());
        }

        // 게시글 정보를 모델에 추가
        model.addAttribute("board", board);
        return "/csboard/view";  // 게시글 상세 페이지로 이동
    }
    
    

    
    @GetMapping("/Writeform")
    public String insertBoardForm(HttpSession session, Model model) {
        String loggedInUser = (String) session.getAttribute("loggedInUser");
        String loggedInComId = (String) session.getAttribute("loggedInComId");


        

        // 작성 페이지로 이동
        return "/csboard/write";
    }
    // 게시글 수정 페이지로 이동
    @GetMapping("/Updateform")
    public String updateBoard(@RequestParam("qnum") String qnum, Model model) {
    	CsBoardVo board = csBoardMapper.getBoardDetail(qnum);
    	model.addAttribute("board", board);
    	return "/csboard/update";
    }

    @PostMapping("/Write")
    public String insertBoard(CsBoardVo board, HttpSession session) {
    	String loggedInUserId = (String) session.getAttribute("userid");
        String loggedInComId = (String) session.getAttribute("comid");

        // 작성자 ID를 설정 (userid 또는 comid 중 하나만 설정)
        if (loggedInUserId != null) {
            board.setUserid(loggedInUserId);
            board.setComid(null);  // 기업 ID는 null로 설정
        } else if (loggedInComId != null) {
            board.setComid(loggedInComId);
            board.setUserid(null);  // 개인 ID는 null로 설정
        }

        // 게시글 작성 로직 처리
        csBoardMapper.insertBoard(board);

        return "redirect:/Cs/Board";  // 작성 완료 후 목록 페이지로 리다이렉트
    }


    // 게시글 수정
    @PostMapping("/Update")
    public String updateBoardProcess(CsBoardVo board) {
        csBoardMapper.updateBoard(board);
        return "redirect:/Cs/Board";
    }
    
    @RequestMapping("/Answer")
    public ModelAndView answer(@RequestParam(value = "qnum") String qnum, @RequestParam(value = "answer")String answer) {
    	CsBoardVo vo = new CsBoardVo();
    	vo.setAnswer(answer);
    	vo.setQnum(qnum);
    	csBoardMapper.updateAnswer(vo);
    	
    	ModelAndView mv = new ModelAndView();
    	mv.setViewName("redirect:/Cs/View?qnum="+qnum);
    	
    	return mv;
    }
}

package com.guguin.community;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.guguin.com.vo.ComVo;
import com.guguin.csboard.PagingHelper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/community")
public class CommunityController {
	
	@Autowired
	private CommunityMapper communityMapper;
	
	@GetMapping("")
	public ModelAndView commList(@RequestParam(value = "page", defaultValue = "1") int page) {
		int recordsPerPage = 10; // 페이지당 보여줄 게시글 수
		int arg0 = (page - 1) * recordsPerPage; // 오프셋 계산
		int totalRecords = communityMapper.getTotalBoardCount(); // 전체 게시글 수
		PagingHelper pagingHelper = new PagingHelper(totalRecords, page, recordsPerPage);
		System.out.println(arg0);
		List<CommunityVo> list = communityMapper.getList(arg0, recordsPerPage);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.addObject("pagingHelper", pagingHelper);
		mv.setViewName("/community/board");
		return mv;
	}
	
	@GetMapping("/insert")
	public ModelAndView commInsertForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		String comid = (String) session.getAttribute("comid");
		
		ModelAndView mv = new ModelAndView();
		if(userid != null || comid != null) {
			mv.setViewName("/community/insert");
		}
		else {
			mv.setViewName("redirect:/Login/");
		}
		return mv;
	}
	
	@RequestMapping("/view/{conum}")
	public ModelAndView commView(@PathVariable("conum") String conum) {
		System.out.println(conum);
		ModelAndView mv = new ModelAndView();

		CommunityVo comm = communityMapper.getComm(conum);
		comm.setNot_content(comm.getNot_content().replace("\n", "<br>"));
		List<ComentVo> coment = communityMapper.getComment(conum);
		for(int i = 0; i < coment.size(); i++ ) {
			coment.get(i).setC_comment(coment.get(i).getC_comment().replace("\n", "<br>"));
		}
		communityMapper.upViews(conum);
		
		List<FileVo> files = communityMapper.getFiles(comm.getConum());
		if(files != null) {
			for(int i = 0; i < files.size(); i++ ) {
				String[] fileNameList = files.get(i).getUrl().split("_");
				String fileName = "";
				//uuid 잘라내기, file 이름자체에 _ 들어가는 경우 때문에 fileName+=
				for(int j =1; j < fileNameList.length; j++) {
					fileName += fileNameList[j];
					if(j+1 != fileNameList.length) {
						fileName += "_";
					}
				}
				System.out.println(fileName);
				files.get(i).setFileName(fileName);
			}
			mv.addObject("files", files);
		}
		mv.addObject("comm", comm);
		mv.addObject("coment", coment);
		mv.setViewName("/community/view");
		return mv;
	}
	
	@GetMapping("/update/{conum}")
	public ModelAndView commUpdate(@PathVariable("conum")String conum) {
		ModelAndView mv = new ModelAndView();
		CommunityVo comm = communityMapper.getComm(conum);

		List<FileVo> files = communityMapper.getFiles(comm.getConum());
		if(files != null) {
			for(int i = 0; i < files.size(); i++ ) {
				String[] fileNameList = files.get(i).getUrl().split("_");
				String fileName = "";
				//uuid 잘라내기, file 이름자체에 _ 들어가는 경우 때문에 fileName+=
				for(int j =1; j < fileNameList.length; j++) {
					fileName += fileNameList[j];
					if(j+1 != fileNameList.length) {
						fileName += "_";
					}
				}
				System.out.println(fileName);
				files.get(i).setFileName(fileName);
			}
			mv.addObject("files", files);
		}
		mv.addObject("comm", comm);
		mv.setViewName("/community/update");
		return mv;
	}
	
	@GetMapping("/del/{conum}")
	public ModelAndView commDel(@PathVariable("conum") String conum) {
		communityMapper.delCom(conum);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community");
		return mv;
	}
	
	@GetMapping("/fileDel/{finum}")
	public ResponseEntity<String> commFileDel(@PathVariable("finum") String finum){
		try {
			communityMapper.delFile(finum);
			return ResponseEntity.ok("파일이 삭제되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("파일 삭제 중 오류발생");
		}
	}
	
	@PostMapping("/comment/insert")
	public ResponseEntity<String> commentInsert(@RequestBody HashMap<String, Object> map){
		System.out.println("comment map: "+map);
		try {
			communityMapper.insertComment(map);
			return ResponseEntity.ok("ok");			
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(null);
		}
	}
	
	@PostMapping("/comment/update")
	public ModelAndView commentUpdate(@RequestParam HashMap<String, Object> map) {
		System.out.println("comment update map: "+map);
		communityMapper.updateComment(map);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/community/view/"+map.get("conum"));
		return mv;
	}
	
	@RequestMapping("/comment/del/{renum}")
	public ResponseEntity<String> commentDel(@PathVariable("renum") String renum) {
		try {
			communityMapper.delComment(renum);
			return ResponseEntity.ok(renum);
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(null);
		}
	}
	
}

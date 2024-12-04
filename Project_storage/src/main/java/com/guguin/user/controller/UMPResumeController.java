package com.guguin.user.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

import com.guguin.com.mapper.ComMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.guguin.user.vo.SidoVo;
import com.guguin.user.mapper.UserFileMapper;
import com.guguin.user.vo.CareerVo;
import com.guguin.user.vo.EduVo;
import com.guguin.user.vo.ResumeVo;
import com.guguin.user.vo.SkillCateVo;
import com.guguin.user.vo.UserVo;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/User/Mypage/Resume")
public class UMPResumeController {
	
	@Autowired
	private UserFileMapper userFileMapper;
	@Autowired
	private ComMapper comMapper;
	@Value("${upload-path}")
	    private String uploadPath;

    @PostMapping("/Insert")
    public String insert(@RequestParam Map<String, Object> map, @RequestParam("file") MultipartFile[] file)  {
    	try {// 파일 처리
			System.out.println("file[0] name:"+file[0].getOriginalFilename());
			map.put("uploadPath",uploadPath);
            if (!file[0].isEmpty()) {
                for (MultipartFile multipartFile : file) {
                    String fileName = multipartFile.getOriginalFilename();
					//server에 파일 저장 -> fileList로 받아옴
                    save(map, file);
//dur;nkj
					List<String> fileList = (List<String>) map.get("fileList");
					System.out.println("controller fileList : "+fileList);
					String saveFile = fileList.get(0);
					System.out.println("controller saveFile : "+saveFile);
					map.put("picture",saveFile);

					userFileMapper.insertResume(map);
					System.out.println(map);
					userFileMapper.insertFile(map.get("resnum"),map.get("picture"));
                }
            }
            return "/user/resume";
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage";
        }

        
    }

	@PostMapping("/Update")
	    public String update(@RequestParam Map<String, Object> map, @RequestParam(value = "file", required = false) MultipartFile[] file)  {
		System.out.println("hi");
		System.out.println(file);
		System.out.println("map: "+map);

		userFileMapper.updateResume(map);

		if(file != null) {
			try {// 파일 처리
				userFileMapper.delFile(map.get("resnum"));
				System.out.println("file[0] name:" + file[0].getOriginalFilename());
				map.put("uploadPath", uploadPath);
				if (!file[0].isEmpty()) {
					for (MultipartFile multipartFile : file) {
						String fileName = multipartFile.getOriginalFilename();
						//server에 파일 저장 -> fileList로 받아옴
						save(map, file);
						//dur;nkj
						List<String> fileList = (List<String>) map.get("fileList");
						System.out.println("controller fileList : " + fileList);
						String saveFile = fileList.get(0);
						System.out.println("controller saveFile : " + saveFile);
						map.put("picture", saveFile);

						userFileMapper.insertFile(map.get("resnum"), map.get("picture"));
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				return "errorPage";
			}
		}

		return "/user/resume";
    }

	private void save(Map<String, Object> map, MultipartFile[] file) {
		//돌려줄 map에 저장할 리스트 생성
		List<String> fileList = new ArrayList<>();
		//파일 하나씩 뽑기
		for (MultipartFile onceFile : file) {
			//파일 이름 가져오기
			String fileName = onceFile.getOriginalFilename();
			String uuid = UUID.randomUUID().toString();
			//저장할 폴더 이름 가져오기 -> 저장 날짜별로 폴더 생성 /yyyy/mm/dd
			String folderPath = makeFolder(uploadPath);
			//저장할 경로 + 이름
			String saveName = uploadPath+File.separator+folderPath+File.separator+uuid+"_"+fileName;
			//저장 경로(Path) 변수로 변환
			Path savePath = Paths.get(saveName);
			//서버에 파일저장
			try{
				onceFile.transferTo(savePath);
				System.out.println("파일저장완료");
				System.out.println("saveName : "+saveName);
				System.out.println("savePath : "+savePath);
			}catch (IllegalStateException e){
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			fileList.add(saveName);
		}
		map.put("fileList",fileList);
	}

	private String makeFolder(String uploadPath) {
		//C:\\Users\\GGG\\Desktop\\prj2\\data
		String dateStr = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		String folderPath = dateStr.replace("/",File.separator);
		File uploadPathFolder = new File(uploadPath, folderPath);
		if(uploadPathFolder.exists() == false){
			uploadPathFolder.mkdirs();//해당 folder 없으면 폴더 만들기
		}
		return folderPath;
	}


}

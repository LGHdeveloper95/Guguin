package com.guguin;

import com.guguin.cummunity.CommFileMapper;
import com.guguin.user.mapper.UserFileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class HomeController {

	@Autowired
	private UserFileMapper userFileMapper;
	@Autowired
	private CommFileMapper commFileMapper;
	@Value("${upload-path}")
		    private String uploadPath;

        @GetMapping("/")
        public String home() {
            return "home"; // home.jsp를 반환
        }

		
		//    자료 들고올 primary key를 입력 하면 id에 맞는 자료실에 있는 
		//    finum(자료실 primary key) 반환 후 다운로드 받을 수 있는 링크로 만들어 return함
	    //    사용 예 ) fetch(192.168.0.214:9090/download/{id}).then(list=>{
		//				list.forEach(function(file){
		//					let output+='<img src="'+file+'">;
		//				}) window.innerHTML+=output;

		// 아이디 입력시 자료실에 있는 파일 아이디 불러와줌. => 192.168.0.214:9090/file/url
		@RequestMapping("/download/{id}")
		@ResponseBody
		public ResponseEntity<List<String>> getFileList(@PathVariable("id") String id) throws IOException {
			System.out.println("들어옴");
		        		List<String> fileIdList = userFileMapper.getFileIdList(id);

						if (fileIdList.size()==0) return ResponseEntity.status( HttpStatus.BAD_REQUEST).body(null);

						String server = "http://192.168.0.214:9090";
						List<String> urlList =new ArrayList<>();
						for(String url:fileIdList){
							urlList.add(server+ "/file/"+url);
						}
			return  ResponseEntity.status( HttpStatus.OK).body(urlList);
		}

		//자료실 파일 불러오는 애
        @RequestMapping("/file/{id}")
        	public ResponseEntity<Resource> getFile(@PathVariable("id") String id) throws IOException {
        		HttpHeaders header = new HttpHeaders();
				String url = userFileMapper.getUrl(id);
				if(url==null) return null;
        		Resource resource = new FileSystemResource(url);
        		Path filePath = Paths.get(url);
        		header.add("Content-Type", Files.probeContentType(filePath));
        		return new ResponseEntity<>(resource, header, HttpStatus.OK);
    	}

		@PostMapping("/Community/Insert")
		@ResponseBody
	    public String commInsert(@RequestParam Map<String, Object> map, @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFiles)  {
	        	try {// 파일 처리
					System.out.println("map: "+map);
					//map: {userid=BO112, not_title=test, not_content=test2}
					if(uploadFiles != null){
						map.put("uploadPath",uploadPath);
					}

					String user = "";
					if(map.get("userid")!=null && map.get("userid")!=""){
						user = String.valueOf(map.get("userid"));
					}
					else{
						user = String.valueOf(map.get("comid"));
					}

					commFileMapper.insertCommunity(map);
					String conum = commFileMapper.getConum(map);
					System.out.println("conum: "+conum);
	                if (uploadFiles!=null && !uploadFiles[0].isEmpty()) {
						save(map, uploadFiles);
						List<String> fileList = (List<String>) map.get("fileList");
						for (int i =0; i< fileList.size(); i++){
							userFileMapper.insertFile(conum,fileList.get(i));
							System.out.println(i+"번 파일 DB 저장완료: "+fileList.get(i));
						}
					}
					return "/community/view/"+conum;
				} catch (Exception e) {
					e.printStackTrace();
					return "errorPage";
				}
		}



	@PostMapping("/Community/Update")
	@ResponseBody
    public String commUpdate(@RequestParam Map<String, Object> map, @RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFiles)  {
        	try {// 파일 처리
				System.out.println("map: "+map);
				//map: {userid=BO112, not_title=test, not_content=test2}
				if(uploadFiles != null){
					map.put("uploadPath",uploadPath);
				}
				//업데이트
				commFileMapper.updateCommunity(map);
				String conum =String.valueOf(map.get("conum"));
				System.out.println("conum: "+conum);
                if (uploadFiles!=null && !uploadFiles[0].isEmpty()) {
					save(map, uploadFiles);
					List<String> fileList = (List<String>) map.get("fileList");
					for (int i =0; i< fileList.size(); i++){
						userFileMapper.insertFile(conum,fileList.get(i));
						System.out.println(i+"번 파일 DB 저장완료: "+fileList.get(i));
					}
				}
				return "/community/view/"+conum;
			} catch (Exception e) {
				e.printStackTrace();
				return "errorPage";
			}
	}



	private void save(Map<String, Object> map, MultipartFile[] file) {
		System.out.println("파일 길이: "+file.length);
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
				String saveName = uploadPath+ File.separator+folderPath+File.separator+uuid+"_"+fileName;
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

		@GetMapping("/fileDownload/{finum}")
	    public ResponseEntity<Resource> fileDownload(@PathVariable("finum") String finum){
			String filePath = commFileMapper.getFileUrl(finum);
			System.out.println("filePath: "+filePath);
			File file = new File(filePath);

			String[] fileNameList = file.getName().split("_");
			String fileName ="";
			for (int i=1; i < fileNameList.length; i++){
				fileName += fileNameList[i];
				if(i+1 != fileNameList.length){
					fileName += "_";
				}
			}
			System.out.println(fileName);

			if(!file.exists()){
				return ResponseEntity.badRequest().body(null);
			}
			Resource resource = new FileSystemResource(file);
			return ResponseEntity.ok()
			                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getName() + "\"")
			                .body(resource);
		}

}
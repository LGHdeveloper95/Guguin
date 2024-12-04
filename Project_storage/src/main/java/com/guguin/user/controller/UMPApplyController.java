package com.guguin.user.controller;

import com.guguin.user.mapper.UserFileMapper;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/Apply")
public class UMPApplyController {

	private final UserFileMapper userFileMapper;

	public UMPApplyController(UserFileMapper userFileMapper) {
		this.userFileMapper = userFileMapper;
	}

	@PostMapping("")
	public String apply(@RequestParam Map<String, Object> map){
		String Path = userFileMapper.getFilePath(map.get("resnum"));
		File file = new File(Path);
		String filename = file.getName().substring(file.getName().indexOf("-"));
		try (FileInputStream inputStream = new FileInputStream(file)) {
		        MultipartFile multipartFile = new MockMultipartFile(
		            file.getName(),                    // 원본 파일명
		            filename,                    // 새 파일명 (원본 그대로 사용 가능)
		            "application/octet-stream",        // 파일의 MIME 타입 (적절히 설정)
		            inputStream                        // 파일 내용 (InputStream)
		        );
		    } catch (FileNotFoundException e) {
            System.out.println(e.toString());
        } catch (IOException e) {
			System.out.println(e.toString());
        }
        return "";
	}

}

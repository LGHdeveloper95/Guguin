package com.guguin.community;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FileVo {
	private String finum;
	private String storage_user;
	private String url;
	private String fileName;
}

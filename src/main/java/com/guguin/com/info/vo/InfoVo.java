package com.guguin.com.info.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.PathVariable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InfoVo {
  private String comname;
  private  String comid;
  private  String title;
  private  String content;
  private  String history;
  private  String people_num;
  private  String link;
  private  String starrating;
  private  String picture;
}

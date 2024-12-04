package com.guguin.com.post.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostVo {
   private String rec_backnum;
   private String recnum;
   private String comid;
   private String rectitle;
   private String subtitle;
   private String boss;
   private String gcontent;
   private String start_date;
   private String reg_date;
   private String deadline;
   private int career_code;
   private int edu_code;
   private int book_count;
   private String picture;
   private String license;
   private int gugun_code;
   private String skills;
   private int views;
}

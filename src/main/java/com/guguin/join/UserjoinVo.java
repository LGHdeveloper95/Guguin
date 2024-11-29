package com.guguin.join;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserjoinVo {

  private String userid;
  private String userpw;
  private String username;
  private String gender;
  private String birth;
  private String uphone;
  private String uaddr;
  private String uaddr2;
  private int post_code;
  private String email;
 
}
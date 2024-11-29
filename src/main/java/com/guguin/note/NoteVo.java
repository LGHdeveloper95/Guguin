package com.guguin.note;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoteVo {
  private String note_num;
  private String note_title;
  private String note_content;
  private String viewed;
  private String reg_date;
  private String user_receive_id;
  private String com_send_id;
  private String com_receive_id;
  private String user_send_id;
  private String send_type;
  private String receive_type;
  private String send_id;
  private String receive_id;
}

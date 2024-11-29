package com.guguin.event;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EventVo {

private String alnum;
private String title;
private String url;
private String userid;
private String viewed;
private String hiredate;
}

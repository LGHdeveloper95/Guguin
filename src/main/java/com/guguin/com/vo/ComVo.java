package com.guguin.com.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ComVo {
    private String comid;
    private String comnum;
    private String compw;
    private String comname;
    private String boss;
    private String cphone;
    private String caddr;
    private String bossemail;
}

package com.guguin.com.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StarPointVo {

    private String  joinners;
    private String  userid;
    private String  comid;
    private int  welfare_val;
    private int  balance_val;
    private int  culture_val;
    private int  promotion_val;
    private int  manager_val;
    private String  commented;
}

package com.dedu.mall.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class LoginUserResultVo {
    private boolean isLegal;
    private String sessionId;
    private String nackname;
}

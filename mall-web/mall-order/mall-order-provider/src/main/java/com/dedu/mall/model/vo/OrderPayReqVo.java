package com.dedu.mall.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderPayReqVo {
    private String orderId;
    private String sessionId;
    //支付渠道：1:微信
    private Integer payChannel;
}

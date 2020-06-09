package com.dedu.mall.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderReqVo {
    private String skuIds;
    private String sessionId;
    private Long addressId;
    //订单来源：1:app端，2：pc端，3：微信端
    private Integer sourceType;
}

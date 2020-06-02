package com.dedu.mall.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderReqVo {
    private Long id;
    private Long skuId;
    private Long buyerId;
    private Integer num;
    private BigDecimal totalPrice;
    private String title;
    private Integer sourceType;
    private String logisticsName;
    private String logisticsCode;
    private String receiverState;
    private String receiverCity;
    private String receiverDistrict;
    private String receiverAddress;
    private String receiverMobile;
    private String receiverPostcode;
    private String receiverName;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}

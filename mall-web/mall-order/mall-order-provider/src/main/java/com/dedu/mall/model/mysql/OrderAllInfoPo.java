package com.dedu.mall.model.mysql;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderAllInfoPo {
    /**
     * tb_order
     */
    private Long id;
    private Long buyerId;
    private BigDecimal totalPrice;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;

    private Integer status;

    /**
     * tb_pay
     */
    private BigDecimal totalPay;
    private Integer payType;
}

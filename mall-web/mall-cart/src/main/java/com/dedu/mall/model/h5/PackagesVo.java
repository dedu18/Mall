package com.dedu.mall.model.h5;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PackagesVo {
     private String img;
    private String intro;
    private Integer num;
    private BigDecimal price;
    private String remarks;
    private String sale;
    private String shopName;
}

package com.dedu.mall.model.h5;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ShopCartVo {
    private Long goodsId;
    private Integer count;
    private String img;
    private PackagesVo packages;
    private BigDecimal price;
    private String title;
    private String skuId;
}

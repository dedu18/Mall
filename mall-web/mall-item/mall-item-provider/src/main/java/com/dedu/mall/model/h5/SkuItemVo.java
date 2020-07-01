package com.dedu.mall.model.h5;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
public class SkuItemVo {
    private String id;
    private BigDecimal price;
    private int stock;
    //,分隔的规格参数字符串
    private String specs;
}

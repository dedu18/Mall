package com.dedu.mall.model.h5;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class GoodsListItemVo {
    private String img;
    private Double price;
    private String intro;
    private Integer num;
    private Double sale;
    private Integer remarks;
    private String shopName;
}

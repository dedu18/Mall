package com.dedu.mall.model.h5;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SaleDetail {

    private List<SkuItemVo> skus;

    private List<SpecItemVo> specs;

}

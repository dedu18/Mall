package com.dedu.mall.model.h5;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShopCarItemVo {
    @NotNull
    private Long goodsId;
    private String skuId;
    private Integer count;
    private String img;
    private PackagesVo packages;
    private BigDecimal price;
    private String title;
}

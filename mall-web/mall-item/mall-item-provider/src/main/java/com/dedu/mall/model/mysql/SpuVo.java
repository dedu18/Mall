package com.dedu.mall.model.mysql;

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
public class SpuVo {
    private Long spuId;
    private String spuTitle;
    private String spuSubTitle;
    /**
     * 展示图片
     */
    private String image;
    /**
     * 所有图片
     */
    private String images;
    private Boolean saleable;
    private BigDecimal price;
    private Integer stock;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public SpuVo(SpuPo spuPo) {
        this.spuId = spuPo.getId();
        this.spuTitle = spuPo.getTitle();
        this.spuSubTitle = spuPo.getSubTitle();
        this.saleable = spuPo.getSaleable();
        this.createTime = spuPo.getCreateTime();
        this.updateTime = spuPo.getUpdateTime();
    }
}

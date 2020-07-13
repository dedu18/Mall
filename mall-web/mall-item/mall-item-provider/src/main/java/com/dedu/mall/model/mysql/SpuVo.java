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
    private Boolean saleable;
    private String categotyNames;
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

package com.dedu.mall.service;

import com.dedu.mall.model.mysql.SkuPo;
import com.dedu.mall.model.mysql.SkuVo;

import java.util.List;

public interface SkuService {
    SkuPo addSku(SkuVo skuVo);

    SkuVo querySkuById(Long id);

    List<SkuVo> querySkuBySpuId(Long spuId);
}

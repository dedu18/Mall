package com.dedu.mall.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.dedu.mall.model.mysql.SpuAndDetailVo;
import com.dedu.mall.model.mysql.SpuPo;
import com.dedu.mall.model.mysql.SpuVo;

public interface SpuService {
    SpuPo addSpuAndSpuDetail(SpuAndDetailVo spuAndDetailVo);
    IPage<SpuVo> getSpuPage(Integer pageNum, Integer pageSize);
    IPage<SpuVo> getSpuPageByCategoryId(Long categoryId, Integer pageNum, Integer pageSize);
}

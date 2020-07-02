package com.dedu.mall.service;

import com.dedu.mall.model.mysql.StockPo;

import java.math.BigDecimal;
import java.util.Map;

public interface StockService {
    void addStockByMapBatch(Map<Long, BigDecimal> stockMap);

    StockPo getStockBySkuId(Long skuId);
}

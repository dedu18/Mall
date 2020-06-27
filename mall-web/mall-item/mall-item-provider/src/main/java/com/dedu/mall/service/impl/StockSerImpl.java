package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.StockMapper;
import com.dedu.mall.model.mysql.StockPo;
import com.dedu.mall.service.StockService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class StockSerImpl extends ServiceImpl<StockMapper, StockPo> implements StockService {

    @Override
    public void addStockByMapBatch(Map<Long, BigDecimal> stockMap) {
        List<StockPo> stockPoList = new ArrayList<>();
        stockMap.forEach((k,v) ->
            stockPoList.add(StockPo.builder()
                    .skuId(k)
                    .stock(v.intValue())
                    .createTime(LocalDateTime.now())
                    .updateTime(LocalDateTime.now())
                    .isEnable(Boolean.TRUE)
                    .isDelete(Boolean.FALSE)
                    .build())
        );
        this.saveBatch(stockPoList);
    }
}

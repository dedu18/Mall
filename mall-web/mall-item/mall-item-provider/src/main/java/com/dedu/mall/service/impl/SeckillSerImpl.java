package com.dedu.mall.service.impl;

import com.dedu.mall.model.mysql.SeckillInfoVo;
import com.dedu.mall.model.mysql.SeckillVo;
import com.dedu.mall.service.SeckillService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class SeckillSerImpl implements SeckillService {

    @Override
    public SeckillVo getSeckillInfoList() {
        SeckillVo result = new SeckillVo();
        List<SeckillInfoVo> seckillInfoList = new ArrayList<>();
        seckillInfoList.add(SeckillInfoVo.builder()
                .intro("【赠小风扇】维他 柠檬茶250ml*32盒 礼品装 整箱")
                .img("static/img/index/seckill/seckill-item1.jpg")
                .price(new BigDecimal("71.9"))
                .realPrice(new BigDecimal("89.6")).build());

        seckillInfoList.add(SeckillInfoVo.builder()
                .intro("Kindle Paperwhite 全新升级版6英寸护眼非反光电子墨水")
                .img("static/img/index/seckill/seckill-item2.jpg")
                .price(new BigDecimal("989.0"))
                .realPrice(new BigDecimal("1111")).build());
        seckillInfoList.add(SeckillInfoVo.builder()
                .intro("粮悦 大吃兄糯米锅巴 安徽特产锅巴糯米原味400g*2盒")
                .img("static/img/index/seckill/seckill-item3.jpg")
                .price(new BigDecimal("71.9"))
                .realPrice(new BigDecimal("111")).build());
        seckillInfoList.add(SeckillInfoVo.builder()
                .intro("【京东超市】清风（APP）抽纸 原木纯品金装系列 3层")
                .img("static/img/index/seckill/seckill-item4.jpg")
                .price(new BigDecimal("75.9"))
                .realPrice(new BigDecimal("99.6")).build());
        seckillInfoList.add(SeckillInfoVo.builder()
                .intro("NIKE耐克 男子休闲鞋 AIR MAX 90 ESSENTIAL 气垫")
                .img("static/img/index/seckill/seckill-item5.jpg")
                .price(new BigDecimal("11.9"))
                .realPrice(new BigDecimal("424.6")).build());
        seckillInfoList.add(SeckillInfoVo.builder()
                .intro("【京东超市】清风（APP）抽纸 原木纯品金装系列 3层")
                .img("static/img/index/seckill/seckill-item4.jpg")
                .price(new BigDecimal("71.9"))
                .realPrice(new BigDecimal("99.6")).build());
        result.setInfo(seckillInfoList);
        result.setHours(10);
        result.setMinute(10);
        result.setSeconds(19);
        return result;
    }
}

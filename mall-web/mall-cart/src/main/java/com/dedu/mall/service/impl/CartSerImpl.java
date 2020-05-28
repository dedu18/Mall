package com.dedu.mall.service.impl;

import com.dedu.mall.model.h5.ShopCartVo;
import com.dedu.mall.service.CartService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class CartSerImpl implements CartService {

    @Override
    public List<ShopCartVo> queryUserShopCartByUserId(Long userId) {
        List<ShopCartVo> result = new ArrayList<>();
        result.add(ShopCartVo.builder()
                .goodsId(1529931938150L)
                .count(1)
                .img("/static/img/goodsDetail/pack/1.jpg")
                .packages("4.7英寸-深邃蓝")
                .price(new BigDecimal(28.0))
                .title("苹果8/7手机壳iPhone7 Plus保护壳全包防摔磨砂硬外壳")
                .build());
        return result;
    }
}

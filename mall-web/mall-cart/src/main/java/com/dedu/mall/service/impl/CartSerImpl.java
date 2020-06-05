package com.dedu.mall.service.impl;

import com.dedu.mall.model.h5.ShopCarItemVo;
import com.dedu.mall.model.h5.ShopCartVo;
import com.dedu.mall.service.CartService;
import com.google.common.collect.Lists;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

@Service
public class CartSerImpl implements CartService {

    private Map<Long, List<ShopCartVo>> carCache = new HashMap<>();

    @Override
    public List<ShopCartVo> queryUserShopCartByUserId(Long userId) {
        List<ShopCartVo> result = carCache.get(userId);
        return result == null ? new ArrayList<>() : result;
    }

    @Override
    public Boolean addGoodsToShopCartOfUser(ShopCarItemVo goodsItem) {
        ShopCartVo shopCartVo = convertShopCarItemToVo(goodsItem);
        Long userId = getUserIdBySession(goodsItem.getSessionId());
        if (carCache.containsKey(userId)) {
            carCache.get(userId).add(shopCartVo);
        } else {
            carCache.put(userId, Arrays.asList(shopCartVo));
        }
        return Boolean.TRUE;
    }

    private Long getUserIdBySession(String sessionId) {
        return Long.parseLong("111");
    }

    private ShopCartVo convertShopCarItemToVo(ShopCarItemVo goodsItem) {
//        ShopCartVo.builder()
//                .goodsId(1529931938150L)
//                .count(1)
//                .img("/static/img/goodsDetail/pack/1.jpg")
//                .packages("4.7英寸-深邃蓝")
//                .price(new BigDecimal(28.0))
//                .title("苹果8/7手机壳iPhone7 Plus保护壳全包防摔磨砂硬外壳")
//                .build();

        return ShopCartVo.builder()
                .goodsId(goodsItem.getGoodsId())
                .count(1)
                .img("/static/img/goodsDetail/pack/1.jpg")
                .packages("4.7英寸-深邃蓝")
                .price(new BigDecimal(28.0))
                .title("苹果8/7手机壳iPhone7 Plus保护壳全包防摔磨砂硬外壳")
                .build();
    }
}

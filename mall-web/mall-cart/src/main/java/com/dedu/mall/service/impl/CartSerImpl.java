package com.dedu.mall.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dedu.mall.model.h5.ShopCarItemVo;
import com.dedu.mall.model.h5.ShopCartVo;
import com.dedu.mall.service.CartService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

@Service
public class CartSerImpl implements CartService {


    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    private Map<Long, List<ShopCartVo>> carCache = new HashMap<>();

    @Override
    public List<ShopCartVo> queryUserShopCartBySessionId(String sessionId) {
        Long userId = getUserIdBySession(sessionId);
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
            LinkedList shopCarItemList = new LinkedList();
            shopCarItemList.add(shopCartVo);
            carCache.put(userId, shopCarItemList);
        }
        return Boolean.TRUE;
    }

    private Long getUserIdBySession(String sessionId) {
        String userInfoJson = stringRedisTemplate.opsForValue().get(sessionId);
        if (StringUtils.isBlank(userInfoJson)) {
            return null;
        }
        Map map = JSON.parseObject(userInfoJson, Map.class);
        return Long.parseLong(map.get("id").toString());
    }

    private ShopCartVo convertShopCarItemToVo(ShopCarItemVo goodsItem) {
        return ShopCartVo.builder()
                .goodsId(goodsItem.getGoodsId())
                .skuId(goodsItem.getSkuId())
                .count(1)
                .img(goodsItem.getImg())
                .packages(goodsItem.getPackages())
                .price(goodsItem.getPrice())
                .title(goodsItem.getTitle())
                .build();
    }
}

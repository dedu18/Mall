package com.dedu.mall.service.impl;

import com.dedu.mall.model.h5.ShopCarItemVo;
import com.dedu.mall.model.h5.ShopCartVo;
import com.dedu.mall.service.CartService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

@Service
public class CartSerImpl implements CartService {



    @Autowired
    HttpServletRequest request;

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
        if (StringUtils.isEmpty(sessionId)) {
            String ip = request.getRemoteAddr();
            String ipString = ip.replace(":", "").replace(".", "");
            return Long.parseLong(ipString);
        }
        return Long.parseLong("1");
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
                .packages(goodsItem.getPackages())
                .price(new BigDecimal(28.0))
                .title("苹果8/7手机壳iPhone7 Plus保护壳全包防摔磨砂硬外壳")
                .build();
    }
}

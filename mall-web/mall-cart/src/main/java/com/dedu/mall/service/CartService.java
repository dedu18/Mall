package com.dedu.mall.service;

import com.dedu.mall.model.h5.ShopCarItemVo;
import com.dedu.mall.model.h5.ShopCartVo;

import java.util.List;

public interface CartService {
    List<ShopCartVo> queryUserShopCartBySessionId();

    Boolean addGoodsToShopCartOfUser(ShopCarItemVo goodsItem);
}

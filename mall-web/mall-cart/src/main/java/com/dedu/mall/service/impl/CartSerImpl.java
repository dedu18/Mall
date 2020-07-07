package com.dedu.mall.service.impl;

import com.dedu.mall.enums.UserEnum;
import com.dedu.mall.model.ServiceException;
import com.dedu.mall.model.UserVo;
import com.dedu.mall.model.h5.ShopCarItemVo;
import com.dedu.mall.model.h5.ShopCartVo;
import com.dedu.mall.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class CartSerImpl implements CartService {

    @Autowired
    private HttpServletRequest httpRequest;

    private Map<String, List<ShopCartVo>> carCache = new HashMap<>();

    @Override
    public List<ShopCartVo> queryUserShopCartBySessionId() {
        UserVo userVo = getUserIdBySession();
        List<ShopCartVo> result = carCache.get(userVo.getId());
        return result == null ? new ArrayList<>() : result;
    }

    @Override
    public Boolean addGoodsToShopCartOfUser(ShopCarItemVo goodsItem) {
        ShopCartVo shopCartVo = convertShopCarItemToVo(goodsItem);
        UserVo userVo = getUserIdBySession();
        if (carCache.containsKey(userVo.getId())) {
            carCache.get(userVo.getId()).add(shopCartVo);
        } else {
            LinkedList shopCarItemList = new LinkedList();
            shopCarItemList.add(shopCartVo);
            carCache.put(userVo.getId(), shopCarItemList);
        }
        return Boolean.TRUE;
    }

    private UserVo getUserIdBySession() {
        UserVo user = (UserVo)httpRequest.getSession().getAttribute("user");
        if (null == user) {
            throw new ServiceException(UserEnum.USER_LOGIN_EXPIRED_ERROR.getCode(), UserEnum.USER_LOGIN_EXPIRED_ERROR.getMsg());
        }
        return user;
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

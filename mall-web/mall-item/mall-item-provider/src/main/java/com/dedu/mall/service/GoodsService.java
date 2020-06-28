package com.dedu.mall.service;

import com.dedu.mall.model.h5.GoodsDetailRspVo;
import com.dedu.mall.model.h5.GoodsListItemVo;
import com.dedu.mall.model.mysql.GoodsListVo;
import com.dedu.mall.model.mysql.GoodsNavVo;
import com.dedu.mall.model.mysql.GoodsVo;

import java.util.List;

public interface GoodsService {
    Boolean addGoods(GoodsVo goodsVo);

    List<GoodsNavVo> queryGoodsNavByCategoryId(Long id);

    GoodsListVo queryGoodsListByCategoryId(Long id);

    GoodsDetailRspVo queryGoodsBySpuId(Long id);

    List<List<GoodsListItemVo>> queryRecommendGoodsList();
}

package com.dedu.mall.model.mysql;

import com.dedu.mall.model.h5.GoodsListItemVo;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class GoodsListVo {
    /**
     * 广告推荐列表
     */
    private List<GoodsListItemVo> advertisingList;
    /**
     * 商品列表
     */
    private List<GoodsListItemVo> goodsList;
}

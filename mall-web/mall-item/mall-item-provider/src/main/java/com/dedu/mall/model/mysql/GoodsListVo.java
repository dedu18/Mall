package com.dedu.mall.model.mysql;

import com.baomidou.mybatisplus.core.metadata.IPage;
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
     * 商品分页列表
     */
    private IPage<GoodsListItemVo> goodsListPage;
}

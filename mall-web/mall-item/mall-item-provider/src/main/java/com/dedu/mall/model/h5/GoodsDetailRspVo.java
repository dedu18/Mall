package com.dedu.mall.model.h5;

import com.dedu.mall.model.mysql.SpecialItemVo;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class GoodsDetailRspVo {
    //商品预览图
    private List<String> goodsImg;
    //商品标题
    private String title;
    //商品短语标题，如校园配送
    private String phraseTitle;
    // 标题下小标题
    private List<String> tags;
    //优惠价
    private List<String> discount;
    //促销标签
    private List<String> promotion;

    // 销售商品
    private SaleDetail saleDetail;

    // 店铺热销
    private List<GoodsListItemVo> hotSales;
    // 商品介绍图
    private List<String> goodsDetailIntroImages;
    // 规格参数
    private List<SpecialItemVo> globalSpecs;
    // 商品评价
    private CommentInfoVo remarks;
}

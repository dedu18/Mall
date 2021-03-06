package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dedu.mall.model.h5.*;
import com.dedu.mall.model.mysql.*;
import com.dedu.mall.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class GoodsSerImpl implements GoodsService {

    @Autowired
    private SpuService spuService;

    @Autowired
    private SpecificationService specService;

    @Autowired
    private SpecificationValueService specValueService;

    @Autowired
    private SpecificationGroupService specGroupService;

    @Autowired
    private SkuService skuService;

    @Autowired
    private StockService stockService;

    @Override
    public Boolean addGoods(GoodsVo goodsVo) {
        // 1插入SPU 和 插入SPUDetail
        SpuAndDetailVo spuAndDetailVo = convertGoodsToSpuAndDetail(goodsVo);
        SpuPo savedSpuPo = spuService.addSpuAndSpuDetail(spuAndDetailVo);
        // 2插入SpecificationValue
        Map<String, Long> tempCache = new HashMap<>();
        String pictures = "";
        if (!CollectionUtils.isEmpty(goodsVo.getSpecs())) {
            if (!CollectionUtils.isEmpty(goodsVo.getPictures())) {
                pictures = goodsVo.getPictures().stream().map(PictureReqVo::getUrl).collect(Collectors.joining(","));
            }
            for (SpecReqVo specReqVo : goodsVo.getSpecs()
                    ) {
                List<SpecReqVo> checkList = specReqVo.getCheckList();
                List<SpecificationValueVo> specValueVoList = new ArrayList<>();
                checkList.stream().forEach(s ->
                        specValueVoList.add(SpecificationValueVo.builder()
                                .specificationId(s.getSpecId())
                                .specificationName(specReqVo.getSpecName())
                                .value(s.getSpecValue())
                                .build()));
                List<SpecificationValuePo> specificationValuePos = specValueService.addSpecificationValueBatch(specValueVoList);
                Map<String, Long> collect = specificationValuePos.stream().collect(Collectors.toMap(SpecificationValuePo::getValue, SpecificationValuePo::getId));
                tempCache.putAll(collect);
            }
        }
        // 3插入SKU
        if (!CollectionUtils.isEmpty(goodsVo.getPrices())) {
            Map<Long, BigDecimal> stockMap = new HashMap<>();
            for (PriceReqVo priceReqVo :
                    goodsVo.getPrices()) {
                String specs = priceReqVo.getSpecs();
                String specValues = getSpecValues(tempCache, priceReqVo.getSpecNames());
                SkuPo skuPo = skuService.addSku(SkuVo.builder()
                        .spuId(savedSpuPo.getId())
                        .title(goodsVo.getName())
                        .images(pictures)
                        .price(priceReqVo.getPrice())
                        .specs(specs)
                        .specValues(specValues)
                        .build());
                if (null != skuPo) {
                    stockMap.put(skuPo.getId(), priceReqVo.getStock());
                }
            }
            // 4 插入Stock
            stockService.addStockByMapBatch(stockMap);
        }
        return true;
    }

    @Override
    public List<GoodsNavVo> queryGoodsNavByCategoryId(Long categoryId) throws Exception {
        List<GoodsNavVo> result = new ArrayList<>();
        List<SpecificationGroupVo> specGroupVos = specGroupService.queryByCategoryId(categoryId);
        List<SpecificationVo> specVoList = specGroupVos
                .stream()
                .flatMap(specGroup -> specGroup.getSpecs().stream())
                .filter(SpecificationVo::getSearchable)
                .collect(Collectors.toList());
        if (null == specVoList || specVoList.isEmpty()) {
            return result;
        }
        Map<String, List<String>> resultMap = new HashMap<>();
        specVoList.forEach(spec -> {
            if (resultMap.containsKey(spec.getGroupName())) {
                resultMap.get(spec.getGroupName()).add(spec.getName());
            } else {
                List<String> goodsNavList = new LinkedList<>();
                goodsNavList.add(spec.getName());
                resultMap.put(spec.getGroupName(), goodsNavList);
            }
        });
        result = convertSpecMapToGoodsNav(resultMap);
        return result;
    }

    private List<GoodsNavVo> convertSpecMapToGoodsNav(Map<String, List<String>> resultMap) {
//        String[] g1Arr = {"华为(HUAWEI)1", "三星(SAMSUNG)", "MATE", "摩斯维(msvii)", "OPPO", "莫凡(Mofi)", "耐尔金(NILLKIN)", "洛克(ROCK)", "亿色(ESR)", "Apple", "优加"};
//        GoodsNavVo g1 = GoodsNavVo.builder().navName("品牌").navValues(CollectionUtils.arrayToList(g1Arr)).build();
//        String[] g2Arr = {"手机保护套", "苹果周边", "手机贴膜", "移动电源", "创意配件", "手机耳机", "手机支架"};
//        GoodsNavVo g2 = GoodsNavVo.builder().navName("手机配件").navValues(CollectionUtils.arrayToList(g2Arr)).build();
//        String[] g3Arr = {"软壳", "硬壳", "翻盖式", "边框", "运动臂包", "钱包式", "定制", "防水袋", "布袋", "其他"};
//        GoodsNavVo g3 = GoodsNavVo.builder().navName("款式").navValues(CollectionUtils.arrayToList(g3Arr)).build();
//        String[] g4Arr = {"塑料/PC", "硅胶", "金属", "电镀", "真皮", "树脂", "木质", "镶钻", "液态硅胶", "TPU"};
//        GoodsNavVo g4 = GoodsNavVo.builder().navName("材质").navValues(CollectionUtils.arrayToList(g4Arr)).build();
//
//        result.add(g1);
//        result.add(g2);
//        result.add(g3);
//        result.add(g4);
        List<GoodsNavVo> result = new LinkedList<>();
        resultMap.forEach((k, v) -> {
            if (v.size() > 10) {
                v = v.subList(0, 10);
            }
            GoodsNavVo goodsNav = GoodsNavVo.builder()
                    .navName(k)
                    .navValues(v)
                    .build();
            result.add(goodsNav);
        });
        return result;
    }

    /**
     * 根据类目查询商品列表和广告列表
     *
     * @param id
     * @return
     */
    @Override
    public GoodsListVo queryGoodsListByCategoryId(Long id) {
        //查询推荐商品列表
        List<GoodsListItemVo> adList = getRecommendedGoodsList();
        //根据类目Id查Spu列表
        IPage<SpuPo> spuPageByCategoryId = spuService.getSpuPageByCategoryId(id, 0, 50);
        IPage<GoodsListItemVo> goodsListItemPage = convertSpuPageToGoodsListItemPage(spuPageByCategoryId);
        GoodsListVo result = GoodsListVo.builder().advertisingList(adList).goodsListPage(goodsListItemPage).build();
        return result;
    }

    @Override
    public GoodsListVo queryGoodsListByKeyword(String keyword) {
        //查询推荐商品列表
        List<GoodsListItemVo> adList = getRecommendedGoodsList();
        GoodsListVo result = GoodsListVo.builder().advertisingList(adList).goodsListPage(new Page()).build();
        return result;
    }

    private List<GoodsListItemVo> getRecommendedGoodsList() {
        List<GoodsListItemVo> adList = new ArrayList<>(6);
        adList.add(GoodsListItemVo.builder().img("static/img/goodsList/item-as-img-1.jpg").price(new Double("39.9")).intro("SKSK 苹果7/7plus手机壳 iPhone 7 Plus保护套全包硬").num(3140).sale(new Double("9000")).build());
        adList.add(GoodsListItemVo.builder().img("static/img/goodsList/item-as-img-2.jpg").price(new Double("49.9")).intro("狮普 苹果7/7 Plus手机壳 电镀 超薄 全包 防摔 保护外").num(1160).sale(new Double("5900")).build());
        adList.add(GoodsListItemVo.builder().img("static/img/goodsList/item-as-img-1.jpg").price(new Double("59.9")).intro("SKSK 苹果7/7plus手机壳 iPhone 7 Plus保护套全包硬").num(5160).sale(new Double("8800")).build());
        adList.add(GoodsListItemVo.builder().img("static/img/goodsList/item-as-img-2.jpg").price(new Double("69.9")).intro("狮普 苹果7/7 Plus手机壳 电镀 超薄 全包 防摔 保护外").num(6160).sale(new Double("7700")).build());
        adList.add(GoodsListItemVo.builder().img("static/img/goodsList/item-as-img-1.jpg").price(new Double("79.9")).intro("SKSK 苹果7/7plus手机壳 iPhone 7 Plus保护套全包硬").num(7160).sale(new Double("6600")).build());
        adList.add(GoodsListItemVo.builder().img("static/img/goodsList/item-as-img-2.jpg").price(new Double("89.9")).intro("狮普 苹果7/7 Plus手机壳 电镀 超薄 全包 防摔 保护外").num(9160).sale(new Double("5500")).build());
        return adList;
    }

    private IPage<GoodsListItemVo> convertSpuPageToGoodsListItemPage(IPage<SpuPo> spuVoPage) {
        IPage<GoodsListItemVo> result = new Page();
        if (null == spuVoPage) {
            return result;
        }
        result.setTotal(spuVoPage.getTotal());
        result.setSize(spuVoPage.getSize());
        result.setPages(spuVoPage.getPages());
        List<GoodsListItemVo> goodsListItemRecords = new ArrayList<>();
        for (SpuPo spuPo : spuVoPage.getRecords()) {
            goodsListItemRecords.add(
                    GoodsListItemVo.builder()
                    .spuId(spuPo.getId())
                    .intro(spuPo.getSubTitle())
                    .img("static/img/goodsList/item-show-4.jpg")
                    .price(5000.0)
                    .remarks(9000)
                    .shopName("荣耀京东自营旗舰店")
                    .sale(9000.0)
                    .build()
                    );
        }
        result.setRecords(goodsListItemRecords);
        return result;
    }

    @Override
    public GoodsDetailRspVo queryGoodsBySpuId(Long spuId) {

        SpuVo spuBySpuId = spuService.getSpuBySpuId(spuId);

        //商品预览图
        String[] goodsImgArr = {"static/img/goodsDetail/item-detail-1.jpg", "static/img/goodsDetail/item-detail-2.jpg", "static/img/goodsDetail/item-detail-3.jpg", "static/img/goodsDetail/item-detail-4.jpg"};
        List<String> goodsImg = CollectionUtils.arrayToList(goodsImgArr);

        // 标题下小标题
        String[] tagsArr = {"满69-20元", "关注产品★送钢化膜", "BIT配次日达"};
        List<String> tags = CollectionUtils.arrayToList(tagsArr);
        //优惠价
        String[] discountArr = {"满148减10", "满218减20", "满288减30"};
        List<String> discount = CollectionUtils.arrayToList(discountArr);
        //促销标签
        String[] promotionArr = {"跨店满减", "多买优惠"};
        List<String> promotion = CollectionUtils.arrayToList(promotionArr);

        List<GoodsListItemVo> hotSales = buildHotSalesOfStore(spuId);

        // 商品介绍图
        List<String> goodsDetailIntroImages = buildGoodsDetailIntroImages(spuId);

        // 全局规格参数
        List<SpecialItemVo> globalSpecs = buildAllGlobalSpec(spuId);

        // 商品评价组装
        CommentInfoVo commentInfo = buildCommentInfo(spuId);

        //销售属性组装
        List<SkuItemVo> skus = buildSkusBySpuId(spuId);
        List<SpecItemVo> saleSpecs = buildSaleSpecs(spuId);
        SaleDetail saleDetail = SaleDetail.builder().skus(skus).specs(saleSpecs).build();

        //标题短语生成
        String phraseTitle = buildPhraseTitle();

        //结果组装
        GoodsDetailRspVo result = GoodsDetailRspVo.builder()
                .goodsImg(goodsImg)
                .title(spuBySpuId.getSpuTitle())
                .phraseTitle(phraseTitle)
                .tags(tags)
                .discount(discount)
                .promotion(promotion)
                .saleDetail(saleDetail)
                .hotSales(hotSales)
                .goodsDetailIntroImages(goodsDetailIntroImages)
                .globalSpecs(globalSpecs)
                .remarks(commentInfo)
                .build();
        return result;
    }

    private List<GoodsListItemVo> buildHotSalesOfStore(Long spuId) {
        List<GoodsListItemVo> hotSales = new ArrayList<>();
        hotSales.add(GoodsListItemVo.builder().img("static/img/goodsDetail/hot/1.jpg").price(128.0).sale(165076.0).build());
        hotSales.add(GoodsListItemVo.builder().img("static/img/goodsDetail/hot/2.jpg").price(128.0).sale(165076.0).build());
        hotSales.add(GoodsListItemVo.builder().img("static/img/goodsDetail/hot/3.jpg").price(128.0).sale(165076.0).build());
        hotSales.add(GoodsListItemVo.builder().img("static/img/goodsDetail/hot/4.jpg").price(128.0).sale(165076.0).build());
        hotSales.add(GoodsListItemVo.builder().img("static/img/goodsDetail/hot/5.jpg").price(128.0).sale(165076.0).build());
        return hotSales;
    }

    private List<String> buildGoodsDetailIntroImages(Long spuId) {
        String[] goodsDetailArr = {"static/img/goodsDetail/intro/1.jpg",
                "static/img/goodsDetail/intro/2.jpg",
                "static/img/goodsDetail/intro/3.jpg",
                "static/img/goodsDetail/intro/4.jpg"};
        return CollectionUtils.arrayToList(goodsDetailArr);
    }

    private List<SpecialItemVo> buildAllGlobalSpec(Long spuId) {
        List<SpecialItemVo> result = new ArrayList<>();
        result.add(SpecialItemVo.builder().title("商品名称").content("iPhone 7手机壳").build());
        result.add(SpecialItemVo.builder().title("商品编号").content("10435663237").build());
        return result;
    }

    private CommentInfoVo buildCommentInfo(Long spuId) {
        // 好评率
        Integer goodAnalyse = 10;
        // 评价标签
        String[] remarkTagsArr = {"颜色可人", "实惠优选", "严丝合缝", "极致轻薄", "质量没话说", "比定做还合适", "完美品质", "正品行货"};
        List<String> remarkTags = CollectionUtils.arrayToList(remarkTagsArr);
        // 各评价数量
        Integer[] remarksNumDetailArr = {2000, 3000, 900, 1};
        List<Integer> remarksNumDetail = CollectionUtils.arrayToList(remarksNumDetailArr);
        // 评价列表
        List<CommentVo> detail = new ArrayList<>();
        detail.add(CommentVo.builder().username("p****1").values(3.5).content("颜色很好看，质量也不错！，还送了个指环，想不到哦！").goods("4.7英寸-深邃蓝").time(LocalDateTime.of(2019, 10, 24, 10, 24)).build());
        detail.add(CommentVo.builder().username("14****1").values(5.0).content("手感没的说，是硬壳，后背带有磨砂手感。很不错，很喜欢，还加送了钢化膜，支架环，物超所值，准备再买一个。").goods("4.7英寸-玫瑰金").time(LocalDateTime.of(2019, 10, 24, 10, 24)).build());
        detail.add(CommentVo.builder().username("3****z").values(7.0).content("相当轻薄，店家还送了一大堆配件，*元非常值得！").goods("4.7英寸-深邃蓝").time(LocalDateTime.of(2019, 10, 24, 10, 24)).build());
        detail.add(CommentVo.builder().username("gd****c").values(8.0).content("就是我想要的手机壳，壳子很薄，手感不错，就像没装手机壳一样，想要裸机手感的赶快下手了。").goods("4.7英寸-中国红").time(LocalDateTime.of(2019, 10, 24, 10, 24)).build());
        detail.add(CommentVo.builder().username("r****b").values(10.0).content("磨砂的，相当漂亮，尺寸非常合适！精工细作！").goods("5.5英寸-星空黑").time(LocalDateTime.of(2019, 10, 24, 10, 24)).build());
        return CommentInfoVo.builder()
                .remarksNum(6000)
                .goodAnalyse(goodAnalyse)
                .remarksTags(remarkTags)
                .remarksNumDetail(remarksNumDetail)
                .detail(detail)
                .build();
    }

    private String buildPhraseTitle() {
        return "新品";
    }

    /**
     * 根据SpuId查询所有的Sku
     *
     * @param spuId
     * @return
     */
    private List<SkuItemVo> buildSkusBySpuId(Long spuId) {
        List<SkuVo> skuVoList = skuService.querySkuBySpuId(spuId);
        List<SkuItemVo> result = new ArrayList<>();
        for (SkuVo skuVo : skuVoList) {
            StockPo stockPo = stockService.getStockBySkuId(skuVo.getId());
            SkuItemVo skuItemVo = SkuItemVo
                    .builder()
                    .id(skuVo.getId().toString())
                    .price(skuVo.getPrice())
                    .stock(stockPo.getStock())
                    .specs(skuVo.getSpecValues())
                    .build();
            result.add(skuItemVo);
        }
        return result;
    }

    /**
     * 根据SpuId查询销售规格属性
     *
     * @param spuId
     * @return
     */
    private List<SpecItemVo> buildSaleSpecs(Long spuId) {
        List<SkuVo> skuVoList = skuService.querySkuBySpuId(spuId);
        Map<String, SpecItemVo> cache = new HashMap<>(); //key为specId，value为所有的sepcValue
        List<String> sortedSpecIdList = new LinkedList<>();
        for (SkuVo skuVo : skuVoList) {
            String[] specs = skuVo.getSpecs().split(",");
            String[] specValues = skuVo.getSpecValues().split(",");
            for (int i = 0; i < specs.length; i++) {
                String specId = specs[i];
                if (!sortedSpecIdList.contains(specId)) {
                    sortedSpecIdList.add(specId);
                }
                String specValue = specValues[i];
                if (cache.containsKey(specId)) {
                    cache.get(specId).getSpecValues().add(SpecValueItem.builder().name(specValue).build());
                } else {
                    SpecificationPo specPo = specService.getSpecById(Long.parseLong(specId));
                    Set<SpecValueItem> specValueList = new HashSet<>();
                    specValueList.add(SpecValueItem.builder().name(specValue).build());
                    cache.put(specId, SpecItemVo.builder().id(specId).name(specPo.getName()).specValues(specValueList).build());
                }
            }
        }
        List<SpecItemVo> result = new ArrayList<>();
        for (String specId : sortedSpecIdList) {
            result.add(cache.get(specId));
        }
        return result;
    }

    @Override
    public List<List<GoodsListItemVo>> queryRecommendGoodsList() {
        List<List<GoodsListItemVo>> result = new ArrayList<>(2);
        List<GoodsListItemVo> recommend1 = new ArrayList<>();
        recommend1.add(GoodsListItemVo.builder().img("static/img/otherBuy/1.jpg").intro("iPhone7/6s/8钢化膜苹果7Plus全屏全覆盖3D抗蓝").price(29.00).build());
        recommend1.add(GoodsListItemVo.builder().img("static/img/otherBuy/2.jpg").intro("苹果数据线 苹果iPhoneX/6s/7plus/8充电线").price(36.00).build());
        recommend1.add(GoodsListItemVo.builder().img("static/img/otherBuy/3.jpg").intro("苹果8/7/6/6s钢化膜 iphone8/7/6s/6钢化玻璃").price(19.00).build());
        recommend1.add(GoodsListItemVo.builder().img("static/img/otherBuy/4.jpg").intro("iPhone6s/7钢化膜苹果8 Plus手机膜抗蓝光非全屏").price(280.0).build());
        List<GoodsListItemVo> recommend2 = new ArrayList<>();
        recommend2.add(GoodsListItemVo.builder().img("static/img/otherBuy/5.jpg").intro("苹果6s手机壳iPhone6s Plus保护壳防摔全").price(28.0).build());
        recommend2.add(GoodsListItemVo.builder().img("static/img/otherBuy/6.jpg").intro("iPhone7/8手机壳手机套防摔磨砂保护壳星空黑☆全包保护").price(30.0).build());
        recommend2.add(GoodsListItemVo.builder().img("static/img/otherBuy/7.jpg").intro("数据线 适用于苹果iPhone 6s/6plus/7plus/8/X").price(18.00).build());
        recommend2.add(GoodsListItemVo.builder().img("static/img/otherBuy/8.jpg").intro("iPhone8/7/6S/6钢化膜 苹果8/7/6s/6玻璃膜 手机高").price(15.00).build());
        result.add(recommend1);
        result.add(recommend2);
        return result;
    }

    /**
     * 获取规格参数值主键，并使用,分隔
     *
     * @param tempCache
     * @param specNames
     * @return
     */
    private String getSpecValues(Map<String, Long> tempCache, String specNames) {
        String[] specNameSplits = specNames.split("\\,");
        StringBuilder sb = new StringBuilder();
        for (String specName :
                specNameSplits) {
            Long specValueId = tempCache.get(specName);
            if (null != specValueId) {
                sb.append(specValueId.toString()).append("\\,");
            }
        }
        return sb.toString();
    }

    /**
     * 将前端GoodsVo转换成数据库对象
     *
     * @param goodsVo
     * @return
     */
    private SpuAndDetailVo convertGoodsToSpuAndDetail(GoodsVo goodsVo) {
        return SpuAndDetailVo.builder()
                .title(goodsVo.getName())
                .subTitle(goodsVo.getSubtitle())
                .categotyIds(goodsVo.getCategoryId().toString())
                .brandId(goodsVo.getBrand())
                .saleable(Boolean.TRUE)
                .spuDetailVo(SpuDetailVo.builder()
                        .description(goodsVo.getDesc())
                        .packingList(goodsVo.getPacklist())
                        .afterService(goodsVo.getService())
                        .build())
                .build();

    }
}

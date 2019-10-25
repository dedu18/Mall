package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.model.mysql.GoodsVo;
import com.dedu.mall.service.GoodsService;
import com.dedu.mall.service.SpecificationGroupService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

/**
 * 商品控制器
 */
@RestController()
@RequestMapping("/api/goods")
@CrossOrigin
public class GoodsController {

    @Autowired
    private SpecificationGroupService specGroupService;

    @Autowired
    private GoodsService goodsService;
    //**********************************分割线，以下为H5前台接口********************************************
    @GetMapping("/nav/category/{id}")
    @ApiOperation(value = "根据类目Id查询商品列表导航头信息-dedu", notes = "商品")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result queryGoodsNavByCategoryId(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), goodsService.queryGoodsNavByCategoryId(id));
    }

    @GetMapping("/list/category/{id}")
    @ApiOperation(value = "根据类目Id查询商品列表导航头信息-dedu", notes = "商品")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result queryGoodsListByCategoryId(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), goodsService.queryGoodsListByCategoryId(id));
    }

    /**
     * 商品详情
     * @param id
     * @return
     * @throws Exception
     */
    @GetMapping("/{id}")
    @ApiOperation(value = "根据商品Id查询商品详情信息-dedu", notes = "商品")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "商品主键id", required = true)
    })
    public Result queryGoodsById(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), goodsService.queryGoodsById(id));
    }

    /**
     * 加入购物车后商品推荐
     * @return
     * @throws Exception
     */
    @GetMapping("/recommend")
    @ApiOperation(value = "查询推荐商品-dedu", notes = "商品")
    @ApiImplicitParams({})
    public Result queryRecommendGoodsList() throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), goodsService.queryRecommendGoodsList());
    }



    //**********************************分割线，以下为管理平台接口*******************************************

    @GetMapping("/group/category/{id}")
    @ApiOperation(value = "根据类目Id查询规则分组信息-dedu", notes = "商品")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result querySpecGroupByCategoryId(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), specGroupService.queryByCategoryId(id));
    }


    @PostMapping("/")
    @ApiOperation(value = "添加新商品-dedu", notes = "商品")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "GoodsVo", name = "goodsVo", value = "商品实体", required = true)
    })
    public Result querySpecGroupByCategoryId(@NotNull @RequestBody GoodsVo goodsVo) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), goodsService.addGoods(goodsVo));
    }
}

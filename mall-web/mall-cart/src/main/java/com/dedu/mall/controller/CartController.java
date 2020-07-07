package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.model.h5.ShopCarItemVo;
import com.dedu.mall.service.CartService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@RestController
@RequestMapping("/api/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping("")
    @ApiOperation(value = "根据用户会话Id查询购物车列表-dedu", notes = "购物车")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "string", name = "sessionId", value = "用户会话id", required = true)
    })
    public Result queryUserShopCartByUserId() {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), cartService.queryUserShopCartBySessionId());
    }

    @PostMapping("/")
    @ApiOperation(value = "添加新商品到购物车列表-dedu", notes = "购物车")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "ShopCarItemVo", name = "goodsItem", value = "用户商品", required = true)
    })
    public Result addGoodsToShopCartOfUser(@Valid @RequestBody ShopCarItemVo goodsItem) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), cartService.addGoodsToShopCartOfUser(goodsItem));
    }
}

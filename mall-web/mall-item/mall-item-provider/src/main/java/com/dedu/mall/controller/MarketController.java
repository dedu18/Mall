package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.service.SeckillService;
import com.dedu.mall.service.SpecialService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController()
@RequestMapping("/api/market/h5")
public class MarketController {

    /**
     * 秒杀服务
     */
    @Autowired
    private SeckillService seckillService;

    /**
     * 专栏服务
     */
    @Autowired
    private SpecialService specialService;

//**********************************分割线，以下为H5前台接口*******************************************
    /**
     * 获取秒杀列表
     * @return
     */
    @GetMapping("/seckill/list")
    @ApiOperation(value = "查询所有H5导航类目列表-dedu", notes = "类目")
    @ApiImplicitParams({})
    public Result getSeckillInfoList() {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), seckillService.getSeckillInfoList());
    }

    /**
     * 专栏
     * @return
     */
    @GetMapping("/special/list/{type}")
    @ApiOperation(value = "查询所有H5导航类目列表-dedu", notes = "类目")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result getSpecialByType(@PathVariable int type) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), specialService.getSpecialByType(type));
    }
}

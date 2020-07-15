package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.service.CityService;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController()
@RequestMapping("/api/city")
public class CityController {

    @Autowired
    private CityService cityService;

    /**
     * 查询城市信息
     * @return
     */
    @GetMapping("")
    @ApiOperation(value = "根据ip地址查询城市信息-dedu", notes = "城市信息")
    @ApiImplicitParams({})
    public Result queryGoodsBySpuId() {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), cityService.queryCityInfoByIP());
    }
}

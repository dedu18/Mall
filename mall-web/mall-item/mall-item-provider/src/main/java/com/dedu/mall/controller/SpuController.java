package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.service.SkuService;
import com.dedu.mall.service.SpuService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Max;

/**
 * Spu控制器
 */
@RestController()
@RequestMapping("/api/spu")
public class SpuController {

    @Autowired
    private SpuService spuService;

    /**
     * 分页查询Spu
     */
    @GetMapping("/management/list")
    @ApiOperation(value = "分页查询SPU-dedu", notes = "SPU")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageNum", value = "页数"),
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageSize", value = "每页大小")
    })
    public Result getSpuPage(@RequestParam(value = "pageNum", defaultValue = "1")Integer pageNum,
                               @Max(100)@RequestParam(value = "pageSize", defaultValue = "10")Integer pageSize) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), spuService.getSpuPage(pageNum, pageSize));
    }
}

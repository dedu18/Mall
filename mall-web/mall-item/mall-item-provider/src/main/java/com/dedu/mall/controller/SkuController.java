package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.service.SkuService;
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
@RequestMapping("/api/sku")
public class SkuController {

    @Autowired
    private SkuService skuService;

    /**
     * 根据Id查询SKU
     */
    @GetMapping("/{id}")
    @ApiOperation(value = "根据Id查询SKU-dedu", notes = "SKU")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "SKU主键id", required = true)
    })
    public Result getSkuById(@PathVariable Long id) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), skuService.querySkuById(id));
    }

}

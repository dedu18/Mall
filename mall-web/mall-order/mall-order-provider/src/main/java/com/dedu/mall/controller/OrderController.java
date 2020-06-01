package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.service.OrderService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Max;

@CrossOrigin
@RestController()
@RequestMapping("/api/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("list")
    @ApiOperation(value = "分页查询订单-dedu", notes = "订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageNum", value = "页数"),
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageSize", value = "每页大小")
    })
    public Result getOrderPage(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                               @Max(100) @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.getOrderPage(pageNum, pageSize));
    }

    @GetMapping("/{id}")
    @ApiOperation(value = "根据订单Id获取详情信息-dedu", notes = "订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "订单主键id", required = true)
    })
    public Result getOrderDetailById(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.queryOrderDetailById(id));
    }
}

package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.model.vo.OrderPayReqVo;
import com.dedu.mall.model.vo.OrderReqVo;
import com.dedu.mall.service.OrderService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Max;

@RestController()
@RequestMapping("/api/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/list")
    @ApiOperation(value = "分页查询订单-dedu", notes = "订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageNum", value = "页数"),
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageSize", value = "每页大小")
    })
    public Result getOrderPage(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                               @Max(100) @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.getOrderAllInfoPageByUserId(pageNum, pageSize));
    }

    @GetMapping("/{id}")
    @ApiOperation(value = "根据订单Id获取详情信息-dedu", notes = "订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "string", name = "id", value = "订单主键id", required = true)
    })
    public Result getOrderDetailById(@PathVariable String id) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.queryOrderDetailById(id));
    }

    @GetMapping("/status/{orderId}")
    @ApiOperation(value = "根据订单Id获取详情信息-dedu", notes = "订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "string", name = "orderId", value = "订单主键id", required = true)
    })
    public Result getOrderStatusById(@PathVariable String orderId) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.queryOrderStatusByOrderId(orderId));
    }

    @PostMapping("/")
    @ApiOperation(value = "创建订单-dedu", notes = "创建订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "OrderVo", name = "orderVo", value = "订单信息", required = true)
    })
    public Result createOrderDetailById(@RequestBody OrderReqVo orderReqVo) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.createOrder(orderReqVo));
    }

    @PostMapping("/pay")
    @ApiOperation(value = "支付订单-dedu", notes = "支付订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "OrderVo", name = "orderVo", value = "订单信息", required = true)
    })
    public Result payOrder(@RequestBody OrderPayReqVo orderPayReqVo) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.payOrder(orderPayReqVo));
    }


    @GetMapping("/manage/list")
    @ApiOperation(value = "分页查询订单-dedu", notes = "订单")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageNum", value = "页数"),
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageSize", value = "每页大小")
    })
    public Result getOrderPageByManage(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                               @Max(100) @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), orderService.getOrderAllInfoPageByManage(pageNum, pageSize));
    }


}

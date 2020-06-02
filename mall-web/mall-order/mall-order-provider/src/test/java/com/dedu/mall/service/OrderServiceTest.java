package com.dedu.mall.service;

import com.dedu.mall.BaseTest;
import com.dedu.mall.model.vo.OrderReqVo;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;

public class OrderServiceTest extends BaseTest {

    @Autowired
    private OrderService orderService;

    @Test
    public void createOrder() {
        OrderReqVo orderReqVo = OrderReqVo.builder()
                .skuId(1L)
                .buyerId(11L)
                .num(1)
                .totalPrice(new BigDecimal(5000))
                .sourceType(1)
                .title("测试")
                .build();
        Object order = orderService.createOrder(orderReqVo);
        Assert.assertEquals(null, order);
    }
}

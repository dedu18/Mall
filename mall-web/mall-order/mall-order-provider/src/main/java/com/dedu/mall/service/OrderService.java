package com.dedu.mall.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.dedu.mall.model.mysql.OrderAllInfoPo;
import com.dedu.mall.model.mysql.OrderDetailPo;
import com.dedu.mall.model.vo.OrderPayReqVo;
import com.dedu.mall.model.vo.OrderReqVo;
import com.dedu.mall.model.vo.OrderRspVo;

public interface OrderService {

    IPage<OrderAllInfoPo> getOrderPage(Integer pageNum, Integer pageSize);

    OrderDetailPo queryOrderDetailById(String id);

    OrderRspVo createOrder(OrderReqVo orderReqVo);

    Integer queryOrderStatusByOrderId(String orderId);

    Object payOrder(OrderPayReqVo orderPayReqVo);
}

package com.dedu.mall.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.dedu.mall.model.mysql.OrderAllInfoPo;
import com.dedu.mall.model.mysql.OrderDetailPo;
import com.dedu.mall.model.vo.OrderReqVo;

public interface OrderService {

    IPage<OrderAllInfoPo> getOrderPage(Integer pageNum, Integer pageSize);

    OrderDetailPo queryOrderDetailById(Long id);

    Object createOrder(OrderReqVo orderReqVo);
}

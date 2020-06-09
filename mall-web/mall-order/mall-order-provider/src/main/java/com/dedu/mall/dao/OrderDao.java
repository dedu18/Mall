package com.dedu.mall.dao;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.OrderMapper;
import com.dedu.mall.model.mysql.OrderAllInfoPo;
import com.dedu.mall.model.mysql.OrderDetailPo;
import com.dedu.mall.model.mysql.OrderPo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrderDao extends ServiceImpl<OrderMapper, OrderPo> {

    @Autowired
    private OrderMapper orderMapper;

    public List<OrderAllInfoPo> getOrderAllInfoPage(Integer pageNum, Integer pageSize) {
        return orderMapper.getOrderAllInfoPage(pageNum - 1, pageSize);
    }

    public Integer getOrderAllInfoCount() {
        return orderMapper.getOrderAllInfoCount();
    }

    public OrderDetailPo getOrderDetailInfoById(String id) {
        return orderMapper.getOrderDetailInfoById(id);
    }

    public Integer getOrderStatusByOrderId(String id) {
        return orderMapper.getOrderStatusByOrderId(id);
    }
}

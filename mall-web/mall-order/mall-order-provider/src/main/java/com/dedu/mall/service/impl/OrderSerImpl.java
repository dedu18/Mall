package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.OrderDao;
import com.dedu.mall.dao.mapper.OrderMapper;
import com.dedu.mall.feign.SkuFeignClient;
import com.dedu.mall.model.Result;
import com.dedu.mall.model.SkuVo;
import com.dedu.mall.model.mysql.OrderAllInfoPo;
import com.dedu.mall.model.mysql.OrderDetailPo;
import com.dedu.mall.model.mysql.OrderPo;
import com.dedu.mall.model.mysql.OrderStatusPo;
import com.dedu.mall.model.vo.OrderReqVo;
import com.dedu.mall.service.OrderService;
import com.dedu.mall.util.ResultUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Slf4j
public class OrderSerImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private SkuFeignClient skuFeignClient;

    @Override
    public IPage<OrderAllInfoPo> getOrderPage(Integer pageNum, Integer pageSize) {
        //分页查询
        List<OrderAllInfoPo> orderAllInfoPage = orderDao.getOrderAllInfoPage(pageNum, pageSize);
        // 查询总数
        Integer orderAllInfoCount = orderDao.getOrderAllInfoCount();
        // 返回值封装
        return convertOrderPoToVo(orderAllInfoCount, pageNum, pageSize, orderAllInfoPage);
    }

    private IPage<OrderAllInfoPo> convertOrderPoToVo(Integer pageTotal, Integer pageNum, Integer pageSize, List<OrderAllInfoPo> orderAllInfoPage) {
        IPage<OrderAllInfoPo> result = new Page<>(pageNum, pageSize);
        result.setTotal(pageTotal);
        result.setRecords(orderAllInfoPage);
        return result;
    }

    @Override
    public OrderDetailPo queryOrderDetailById(Long id) {
        OrderDetailPo result = orderDao.getOrderDetailInfoById(id);
        if (null != result.getSkuId()) {
            Result<SkuVo> remoteRstData = skuFeignClient.getSkuById(result.getSkuId());
            SkuVo skuVo = ResultUtil.getResultData(remoteRstData);
            result.setSku(skuVo);
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Object createOrder(OrderReqVo orderReqVo) {
        //创建tb_order
        OrderPo orderEntity = buildOrderPo(orderReqVo);
        orderDao.save(orderEntity);
        //创建tb_order_status
        OrderStatusPo orderStatusPo = buildOrderStatusPo(orderEntity);
        //创建tb_pay
        return null;
    }

    private OrderStatusPo buildOrderStatusPo(OrderPo orderEntity) {
        return OrderStatusPo.builder().orderId(orderEntity.getId()).build();
    }

    private OrderPo buildOrderPo(OrderReqVo orderReqVo) {
        return OrderPo.builder()
                .skuId(orderReqVo.getSkuId())
                .buyerId(orderReqVo.getBuyerId())
                .num(orderReqVo.getNum())
                .totalPrice(orderReqVo.getTotalPrice())
                .sourceType(orderReqVo.getSourceType())
                .title(orderReqVo.getTitle())
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();
    }
}

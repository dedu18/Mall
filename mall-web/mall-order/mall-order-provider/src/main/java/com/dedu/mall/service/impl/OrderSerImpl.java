package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dedu.mall.enums.OrderStatus;
import com.dedu.mall.dao.OrderDao;
import com.dedu.mall.dao.PayDao;
import com.dedu.mall.enums.PayStatus;
import com.dedu.mall.feign.SkuFeignClient;
import com.dedu.mall.feign.UserFeignClient;
import com.dedu.mall.model.Result;
import com.dedu.mall.model.SkuVo;
import com.dedu.mall.model.UserAddressVo;
import com.dedu.mall.model.mysql.OrderAllInfoPo;
import com.dedu.mall.model.mysql.OrderDetailPo;
import com.dedu.mall.model.mysql.OrderPo;
import com.dedu.mall.model.mysql.PayPo;
import com.dedu.mall.model.vo.OrderPayReqVo;
import com.dedu.mall.model.vo.OrderReqVo;
import com.dedu.mall.model.vo.OrderRspVo;
import com.dedu.mall.service.OrderService;
import com.dedu.mall.util.FeignClientUtil;
import com.dedu.mall.util.ResultUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Service
@Slf4j
public class OrderSerImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    private PayDao payDao;

    @Autowired
    private SkuFeignClient skuFeignClient;

    @Autowired
    private UserFeignClient userFeignClient;

    @Override
    public IPage<OrderAllInfoPo> getOrderAllInfoPageByUserId(Integer pageNum, Integer pageSize, String sessionId) {
        Long userId = getUserIdBySession(sessionId);
        //分页查询
        List<OrderAllInfoPo> orderAllInfoPage = orderDao.getOrderAllInfoPageByUserId(userId, pageNum, pageSize);
        // 查询总数
        Integer orderAllInfoCount = orderDao.getOrderAllInfoCountByUserId(userId);
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
    public OrderDetailPo queryOrderDetailById(String id) {
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
    public OrderRspVo createOrder(OrderReqVo orderReqVo) {
        Long userId = getUserIdBySession(orderReqVo.getSessionId());
        Result<UserAddressVo> feignClientResult = userFeignClient.queryUserAddressByUserId(userId.toString(), orderReqVo.getAddressId().toString());
        FeignClientUtil.checkSuccessOtherwiseThrowException(feignClientResult);
        List<String> skuIdList = getSkuIdList(orderReqVo.getSkuIds());
        //检查库存tb_stock
        //创建订单tb_order
        OrderPo orderEntity = buildOrderPo(orderReqVo, feignClientResult.getData());
        orderDao.save(orderEntity);
        //创建支付订单
        PayPo payEntity = buildPayPo(orderEntity, orderReqVo);
        payDao.save(payEntity);
        return OrderRspVo.builder().orderId(orderEntity.getId().toString()).totalPrice(orderEntity.getTotalPrice()).build();
    }

    private PayPo buildPayPo(OrderPo orderEntity, OrderReqVo orderReqVo) {
        return PayPo.builder()
                .orderId(orderEntity.getId())
                .totalPay(orderEntity.getTotalPrice())
                .status(Integer.valueOf(PayStatus.WAITING_TO_PAY.getCode()))
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();
    }

    private List<String> getSkuIdList(String skuIds) {
        return Arrays.asList(skuIds.split(","));
    }

    private Long getUserIdBySession(String sessionId) {
        return Long.parseLong("1");
    }

    private OrderPo buildOrderPo(OrderReqVo orderReqVo, UserAddressVo userAddressVo) {
        return OrderPo.builder()
                .sourceType(orderReqVo.getSourceType())
                .receiverState(userAddressVo.getProvince())
                .receiverCity(userAddressVo.getCity())
                .receiverDistrict(userAddressVo.getArea())
                .receiverAddress(userAddressVo.getAddress())
                .receiverMobile(userAddressVo.getPhone())
                .receiverPostcode(userAddressVo.getPostalCode())
                .receiverName(userAddressVo.getRecipientName())
                .status(Integer.parseInt(OrderStatus.WAITING_TO_PAY.getCode()))
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();
    }

    @Override
    public Integer queryOrderStatusByOrderId(String orderId) {
        return orderDao.getOrderStatusByOrderId(orderId);
    }

    @Override
    public Object payOrder(OrderPayReqVo orderPayReqVo) {
        return null;
    }
}

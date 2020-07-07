package com.dedu.mall.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dedu.mall.model.mysql.OrderAllInfoPo;
import com.dedu.mall.model.mysql.OrderDetailPo;
import com.dedu.mall.model.mysql.OrderPo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface OrderMapper extends BaseMapper<OrderPo> {

//    @Insert("INSERT INTO tb_order(id,name) values(NULL,#{name})")
//    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
//    void save(OrderPo orderPo);

    @Select("SELECT o.id AS id, o.buyer_id AS buyerId, o.total_price AS totalPrice, o.create_time AS createTime, o.update_time AS updateTime, o.status AS status, p.total_pay AS totalPay, p.pay_type AS payType FROM tb_order o LEFT JOIN tb_pay p ON o.id = p.order_id WHERE o.buyer_id = #{userId} LIMIT #{pageNum}, #{pageSize}")
    List<OrderAllInfoPo> getOrderAllInfoPageByUserId(@Param(value = "userId") String userId, @Param(value = "pageNum") Integer pageNum, @Param(value = "pageSize") Integer pageSize);

    @Select("SELECT COUNT(*) FROM tb_order o LEFT JOIN tb_pay p ON o.id = p.order_id WHERE o.buyer_id = #{userId}")
    Integer getOrderAllInfoCountByUserId(@Param(value = "userId") String userId);

    @Select("SELECT o.id AS id, o.buyer_id AS buyerId, o.sku_id AS skuId, o.num AS num, o.source_type AS sourceType, o.total_price AS totalPrice , o.create_time AS createTime, o.update_time AS updateTime, o.logistics_name AS logisticsName, o.logistics_code AS logisticsCode , o.receiver_state AS receiverState, o.receiver_city AS receiverCity, o.receiver_district AS receiverDistrict, o.receiver_address AS receiverAddress, o.receiver_mobile AS receiverMobile , o.receiver_postcode AS receiverPostcode, o.receiver_name AS receiverName, o.status AS status, o.consign_time AS consignTime, o.end_time AS endTime , o.close_time AS closeTime, o.comment_time AS commentTime, o.create_time AS statusCreateTime, o.update_time AS statusUpdateTime, p.total_pay AS totalPay , p.pay_type AS payType, p.status AS payStatus, p.pay_time AS payTime, p.closed_time AS payClosedTime, p.refund_time AS refundTime FROM tb_order o LEFT JOIN tb_pay p ON o.id = p.order_id WHERE o.id = #{orderId}")
    OrderDetailPo getOrderDetailInfoById(@Param(value = "orderId") String id);

    @Select("SELECT status FROM tb_order WHERE id = #{orderId}")
    Integer getOrderStatusByOrderId(String orderId);
}

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

    @Select("SELECT o.id as id,o.buyer_id as buyerId, o.total_price as totalPrice, o.title as title, o.create_time as createTime, o.update_time as updateTime, s.status as status, p.total_pay as totalPay, p.pay_type as payType FROM tb_order o LEFT JOIN tb_order_status s ON o.id = s.order_id LEFT JOIN tb_pay p ON o.id = p.order_id LIMIT #{pageNum}, #{pageSize}")
    List<OrderAllInfoPo> getOrderAllInfoPage(@Param(value = "pageNum") Integer pageNum, @Param(value = "pageSize") Integer pageSize);

    @Select("SELECT COUNT(*) FROM tb_order o LEFT JOIN tb_order_status s ON o.id = s.order_id LEFT JOIN tb_pay p ON o.id = p.order_id")
    Integer getOrderAllInfoCount();

    @Select("SELECT o.id AS id, o.buyer_id AS buyerId, o.sku_id AS skuId, o.num AS num, o.source_type AS sourceType, o.total_price AS totalPrice , o.title AS title, o.create_time AS createTime, o.update_time AS updateTime, o.logistics_name AS logisticsName, o.logistics_code AS logisticsCode , o.receiver_state AS receiverState, o.receiver_city AS receiverCity, o.receiver_district AS receiverDistrict, o.receiver_address AS receiverAddress, o.receiver_mobile AS receiverMobile , o.receiver_postcode AS receiverPostcode, o.receiver_name AS receiverName, s.status AS status, s.consign_time AS consignTime, s.end_time AS endTime , s.close_time AS closeTime, s.comment_time AS commentTime, s.create_time AS statusCreateTime, s.update_time AS statusUpdateTime, p.total_pay AS totalPay , p.pay_type AS payType, p.status AS payStatus, p.pay_time AS payTime, p.closed_time AS payClosedTime, p.refund_time AS refundTime FROM tb_order o LEFT JOIN tb_order_status s ON o.id = s.order_id LEFT JOIN tb_pay p ON o.id = p.order_id WHERE o.id = #{orderId}")
    OrderDetailPo getOrderDetailInfoById(@Param(value = "orderId") String id);

    @Select("SELECT s.STATUS FROM tb_order_status s WHERE order_id = #{orderId}")
    Integer getOrderStatusByOrderId(String id);
}

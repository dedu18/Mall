package com.dedu.mall.model.mysql;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static com.baomidou.mybatisplus.annotation.IdType.AUTO;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@TableName(value = "tb_order")
public class OrderPo {
    @TableId(value = "id", type = AUTO)
    private Long id;
    @TableField(value = "sku_id")
    private String skuId;
    @TableField(value = "buyer_id")
    private Long buyerId;
    @TableField(value = "num")
    private Integer num;
    @TableField(value = "total_price")
    private BigDecimal totalPrice;
    @TableField(value = "source_type")
    private Integer sourceType;
    @TableField(value = "logistics_name")
    private String logisticsName;
    @TableField(value = "logistics_code")
    private String logisticsCode;
    @TableField(value = "receiver_state")
    private String receiverState;
    @TableField(value = "receiver_city")
    private String receiverCity;
    @TableField(value = "receiver_district")
    private String receiverDistrict;
    @TableField(value = "receiver_address")
    private String receiverAddress;
    @TableField(value = "receiver_mobile")
    private String receiverMobile;
    @TableField(value = "receiver_postcode")
    private String receiverPostcode;
    @TableField(value = "receiver_name")
    private String receiverName;
    @TableField(value = "create_time")
    private LocalDateTime createTime;
    @TableField(value = "update_time")
    private LocalDateTime updateTime;
    @TableField(value = "status")
    private Integer status;
    @TableField(value = "consign_time")
    private LocalDateTime consignTime;
    @TableField(value = "end_time")
    private LocalDateTime endTime;
    @TableField(value = "close_time")
    private LocalDateTime closeTime;
    @TableField(value = "comment_time")
    private LocalDateTime commentTime;
}

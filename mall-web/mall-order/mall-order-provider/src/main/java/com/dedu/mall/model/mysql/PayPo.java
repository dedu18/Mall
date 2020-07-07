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
@TableName(value = "tb_pay")
public class PayPo {
    @TableId(value = "id", type = AUTO)
    private Long id;
    @TableField(value = "order_id")
    private Long orderId;
    @TableField(value = "total_pay")
    private BigDecimal totalPay;
    @TableField(value = "user_id")
    private String userId;
    @TableField(value = "wechat_paycode")
    private LocalDateTime wechatPaycode;
    @TableField(value = "status")
    private Integer status;
    @TableField(value = "pay_type")
    private Integer payType;
    @TableField(value = "pay_time")
    private LocalDateTime payTime;
    @TableField(value = "closed_time")
    private LocalDateTime closedTime;
    @TableField(value = "refund_time")
    private LocalDateTime refundTime;
    @TableField(value = "create_time")
    private LocalDateTime createTime;
    @TableField(value = "update_time")
    private LocalDateTime updateTime;
}

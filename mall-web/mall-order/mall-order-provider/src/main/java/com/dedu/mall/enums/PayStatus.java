package com.dedu.mall.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum PayStatus {
    WAITING_TO_PAY("1", "未支付"),
    PAID("2", "已支付"),
    REFUNDED("3", "已退款"),
    PAYMENT_ERROR("4", "支付错误"),
    CLOSED("5", "已关闭"),
    ;
    private String code;
    private String message;
}

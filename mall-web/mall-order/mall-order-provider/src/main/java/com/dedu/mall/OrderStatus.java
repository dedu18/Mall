package com.dedu.mall;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum OrderStatus {
    // 状态：1、未付款 2、已付款,未发货 3、已发货,未确认 4、交易成功 5、交易关闭 6、已评价
    WAITING_TO_PAY("1", "未付款"),
    WAITING_GOODS("2", "已付款,未发货"),
    WAITING_TO_CONFIRM("3", "已发货,未确认"),
    SUCCESS_OF_TRADE("3", "已发货,未确认"),
    TRADE_CLOSED("3", "已发货,未确认"),
    TRADE_EVALUATED("3", "已发货,未确认"),
    ;
    private String code;
    private String message;
}

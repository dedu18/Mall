package com.dedu.mall.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum FeignClientResultEnum {
    SUCCESS("0", "调用成功"),
    ;

    private String code;
    private String desc;
}

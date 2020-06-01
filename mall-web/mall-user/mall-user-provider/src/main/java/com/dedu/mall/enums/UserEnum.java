package com.dedu.mall.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserEnum {
    USER_EXITED("001001", "用户名重复"),
    ;
    private String code;
    private String msg;
}

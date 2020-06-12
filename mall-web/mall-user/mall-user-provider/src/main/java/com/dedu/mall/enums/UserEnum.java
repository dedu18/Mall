package com.dedu.mall.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserEnum {
    USER_EXITED("001001", "用户名重复"),
    USER_CHECKNUM_ERROR("001002", "验证码错误"),
    USER_LOGIN_EXPIRED_ERROR("001003", "用户登录过期"),
    ;
    private String code;
    private String msg;
}

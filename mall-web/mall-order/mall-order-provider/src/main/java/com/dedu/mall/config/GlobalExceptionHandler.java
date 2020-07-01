package com.dedu.mall.config;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import org.springframework.core.annotation.Order;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@Order(value = 100)
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public Result exceptionHandler(Exception ex) {
        ex.printStackTrace();
        return Result.build(ResultCode.SYS_ERROR.getCode(), ResultCode.SYS_ERROR.getDesc());
    }
}

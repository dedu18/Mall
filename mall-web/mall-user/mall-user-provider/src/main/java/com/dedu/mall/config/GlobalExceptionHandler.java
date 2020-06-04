package com.dedu.mall.config;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.model.ServiceException;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@Order(value = 100)
public class GlobalExceptionHandler {

    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    @ExceptionHandler(ServiceException.class)
    public Result exceptionHandler(ServiceException ex) {
        ex.printStackTrace();
        return Result.build(ex.getCode(), ex.getMessage());
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    @ExceptionHandler(Exception.class)
    public Result exceptionHandler(Exception ex) {
        ex.printStackTrace();
        return Result.build(ResultCode.SYS_ERROR.getCode(), ResultCode.SYS_ERROR.getDesc());
    }
}

package com.dedu.mall.util;

import com.dedu.mall.model.FeignClientResultEnum;
import com.dedu.mall.model.Result;
import com.dedu.mall.model.ServiceException;

import java.util.Objects;

public class FeignClientUtil {
    /**
     * 检查远程调用结果是否成功，不成功则抛出异常
     * @param result
     */
    public static void checkSuccessOtherwiseThrowException(Result result) {
        if (!Objects.equals(FeignClientResultEnum.SUCCESS.getCode(), result.getCode())) {
            throw new ServiceException(result.getCode(), result.getMsg());
        }
    }

    /**
     * 检查远程调用结果是否成功，不成功则抛出异常
     * @param result
     */
    public static boolean checkSuccess(Result result) {
        if (!Objects.equals(FeignClientResultEnum.SUCCESS.getCode(), result.getCode())) {
            return false;
        }
        return true;
    }
}

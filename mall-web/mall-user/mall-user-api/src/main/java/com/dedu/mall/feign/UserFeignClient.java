package com.dedu.mall.feign;

import com.dedu.mall.fallback.UserFeignClientFallBack;
import com.dedu.mall.model.Result;
import com.dedu.mall.model.UserAddressVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(
        value = "mall-user-provider",
        fallback = UserFeignClientFallBack.class
)
public interface UserFeignClient {
    @GetMapping("/api/user/addresses")
    Result<UserAddressVo> queryUserAddressByUserId(@RequestParam(value = "userId") String userId, @RequestParam("addressId") String addressId);
}

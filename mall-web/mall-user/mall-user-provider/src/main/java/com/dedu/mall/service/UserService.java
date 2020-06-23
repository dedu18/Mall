package com.dedu.mall.service;

import com.dedu.mall.model.vo.*;

import java.util.List;

public interface UserService {
    List<DeliveryAddress> queryUserAddressBySessionId(String sessionId);

    LoginUserResultVo userLoginByUsernameAndPassword(LoginUserVo loginUserVo);

    Boolean userLoginByUsernameAndPassword(String username, String password);

    Boolean registerUser(RegisterUserVo registerUserVo);

    Boolean sendVerificationCode(String phone, String token);

    String addUserAddressBySessionId(DeliveryAddress userAddress);

    UserAddressVo queryUserAddressByUserIdAndAddressId(String userId, String addressId);
}

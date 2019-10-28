package com.dedu.mall.service;

import com.dedu.mall.model.DeliveryAddress;
import com.dedu.mall.model.LoginUserVo;

import java.util.List;

public interface UserService {
   List<DeliveryAddress> queryUserAddressByUsernamAndPassword(String username, String password);

    Boolean loginUserByUsernameAndPassword(LoginUserVo loginUserVo);
}

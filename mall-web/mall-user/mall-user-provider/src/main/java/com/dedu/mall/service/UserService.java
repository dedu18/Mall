package com.dedu.mall.service;

import com.dedu.mall.model.vo.DeliveryAddress;
import com.dedu.mall.model.vo.LoginUserResultVo;
import com.dedu.mall.model.vo.LoginUserVo;
import com.dedu.mall.model.vo.RegisterUserVo;

import java.util.List;

public interface UserService {
   List<DeliveryAddress> queryUserAddressByUsernamAndPassword(String username, String password);

    LoginUserResultVo userLoginByUsernameAndPassword(LoginUserVo loginUserVo);

    Boolean userLoginByUsernameAndPassword(String username, String password);

    Boolean registerUser(RegisterUserVo registerUserVo);

    Boolean sendVerificationCode(String phone);
}

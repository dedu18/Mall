package com.dedu.mall.service.impl;

import com.dedu.mall.model.DeliveryAddress;
import com.dedu.mall.model.LoginUserVo;
import com.dedu.mall.service.UserService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class UserSerImpl implements UserService {
    @Override
    public List<DeliveryAddress> queryUserAddressByUsernamAndPassword(String username, String password) {
        List<DeliveryAddress> result = new ArrayList<>();
        result.add(DeliveryAddress.builder()
                .addressId("123456")
                .name("麦特斯破")
                .province("王者荣耀省")
                .city("手Q55区市")
                .area("手Q55区")
                .address("净化共鸣")
                .phone("112****1234")
                .postalcode("123456")
                .build());
        return result;
    }

    @Override
    public Boolean loginUserByUsernameAndPassword(LoginUserVo loginUser) {
        if (Objects.equals("Dedu", loginUser.getUsername()) && Objects.equals("Aa123456", loginUser.getPassword())) {
            return Boolean.TRUE;
        } else {
            return Boolean.FALSE;
        }
    }
}

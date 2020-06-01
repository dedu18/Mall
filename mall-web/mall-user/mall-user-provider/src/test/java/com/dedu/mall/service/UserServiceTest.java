package com.dedu.mall.service;

import com.dedu.mall.BaseTest;
import com.dedu.mall.model.vo.RegisterUserVo;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class UserServiceTest extends BaseTest {

    @Autowired
    private UserService userService;

    @Test
    public void registerUser() {
        RegisterUserVo user = new RegisterUserVo();
        user.setUsername("test");
        user.setPassword("test");
        user.setMail("swpuxzh@163.com");
        user.setPhone("15662359987");
        Boolean result1 = userService.registerUser(user);
        Assert.assertEquals(result1, true);
        Boolean result2 = userService.registerUser(user);
        Assert.assertEquals(result2, false);
    }
}

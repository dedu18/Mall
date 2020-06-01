package com.dedu.mall.dao;

import com.alibaba.fastjson.JSONObject;
import com.dedu.mall.BaseTest;
import com.dedu.mall.model.po.UserEntity;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class UserDaoTest extends BaseTest {

    @Autowired
    private UserDao userDao;

    @Test
    public void getUserByUsername() {
        UserEntity dedu = userDao.getUserByUsername("dedu");
        System.out.println(JSONObject.toJSON(dedu));
        Assert.assertEquals(null, dedu);
    }
}

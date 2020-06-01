package com.dedu.mall.service;

import com.dedu.mall.BaseTest;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;

public class RedisTest extends BaseTest {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Test
    public void connectionTest() {
        String cache = stringRedisTemplate.opsForValue().get("123456789");
        Assert.assertEquals(null, cache);
    }

    @Test
    public void addKeyToRedisTest() {
        stringRedisTemplate.opsForValue().set("dedu", "123456789");
        String cache = stringRedisTemplate.opsForValue().get("dedu");
        Assert.assertEquals("123456789", cache);
    }

}

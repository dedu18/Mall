package com.dedu.mall.dao;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.UserMapper;
import com.dedu.mall.model.po.UserEntity;
import org.springframework.stereotype.Repository;

/**
 * 这里Dao集成MP的Service即可拥有CRUD数据库的基础操作，这里Dao的意思是针对数据库的封装
 */
@Repository
public class UserDao extends ServiceImpl<UserMapper, UserEntity> {
    public UserEntity getUserByUsername(String username) {
        return this.getOne(new QueryWrapper<UserEntity>()
                .eq("username", username)
                .eq("is_delete", 0));
    }
}

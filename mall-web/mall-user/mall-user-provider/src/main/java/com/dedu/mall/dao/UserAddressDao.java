package com.dedu.mall.dao;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.UserAddressMapper;
import com.dedu.mall.model.po.UserAddressEntity;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 这里Dao集成MP的Service即可拥有CRUD数据库的基础操作，这里Dao的意思是针对数据库的封装
 */
@Repository
public class UserAddressDao extends ServiceImpl<UserAddressMapper, UserAddressEntity> {
    public List<UserAddressEntity> getAddressByUserId(String userId) {
        return this.list(new QueryWrapper<UserAddressEntity>()
                .eq("user_id", userId)
                .eq("is_enable", 1)
                .eq("is_delete", 0));
    }

    public UserAddressEntity getAddressByUserIdAndAddressId(String userId, String addressId) {
        return this.getOne(new QueryWrapper<UserAddressEntity>()
                .eq("id", addressId)
                .eq("user_id", userId)
                .eq("is_enable", 1)
                .eq("is_delete", 0));
    }
}

package com.dedu.mall.dao;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.SpuDetailMapper;
import com.dedu.mall.model.mysql.SpuDetailPo;
import org.springframework.stereotype.Repository;

/**
 * 这里Dao集成MP的Service即可拥有CRUD数据库的基础操作，这里Dao的意思是针对数据库的封装
 */
@Repository
public class SpuDetailDao extends ServiceImpl<SpuDetailMapper, SpuDetailPo> {
}

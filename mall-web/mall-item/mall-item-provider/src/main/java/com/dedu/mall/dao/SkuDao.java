package com.dedu.mall.dao;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.SkuMapper;
import com.dedu.mall.model.mysql.SkuPo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SkuDao extends ServiceImpl<SkuMapper, SkuPo> {
    public List<SkuPo> querySkuBySpuId(Long spuId) {
        return this.list(new QueryWrapper<SkuPo>().eq("spu_id", spuId).eq("is_enable", 1).eq("is_delete", 0));
    }
}

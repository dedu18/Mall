package com.dedu.mall.dao;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.SpuMapper;
import com.dedu.mall.model.mysql.SpuPo;
import com.dedu.mall.model.mysql.SpuVo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 这里Dao集成MP的Service即可拥有CRUD数据库的基础操作，这里Dao的意思是针对数据库的封装
 */
@Repository
public class SpuDao extends ServiceImpl<SpuMapper, SpuPo> {
    public Integer selectSpuCount() {
        return this.getBaseMapper().selectSpuCount();
    }

    public List<SpuVo> selectSpuPage(Page page) {
        return this.getBaseMapper().selectSpuPage(page);
    }

    public IPage<SpuPo> getSpuPageByCategoryId(Long categoryId, Page page) {
        return this.page(page, new QueryWrapper<SpuPo>().eq("is_enable", 1).like("categoty_ids", categoryId));
    }

    public SpuPo getSpuPoBySpuId(Long spuId) {
        return this.getOne(new QueryWrapper<SpuPo>().eq("id", spuId).eq("is_enable", 1).eq("is_delete", 0));
    }
}

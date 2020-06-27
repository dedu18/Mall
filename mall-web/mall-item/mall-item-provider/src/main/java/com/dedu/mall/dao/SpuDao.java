package com.dedu.mall.dao;

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

    public List<SpuVo> getSpuPageByCategoryId(Long categoryId, Page page) {
        return this.getBaseMapper().getSpuPageByCategoryId(categoryId, page);
    }
}

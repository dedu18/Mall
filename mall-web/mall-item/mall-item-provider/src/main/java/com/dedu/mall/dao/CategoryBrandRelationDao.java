package com.dedu.mall.dao;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.CategoryBrandRelationMapper;
import com.dedu.mall.model.mysql.BrandPo;
import com.dedu.mall.model.mysql.CategoryBrandRelationPo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 这里Dao集成MP的Service即可拥有CRUD数据库的基础操作，这里Dao的意思是针对数据库的封装
 */
@Repository
public class CategoryBrandRelationDao extends ServiceImpl<CategoryBrandRelationMapper, CategoryBrandRelationPo> {
    public List<BrandPo> selectBrandListByCategoryId(Long categoryId) {
        return this.getBaseMapper().selectBrandListByCategoryId(categoryId);
    }
}
